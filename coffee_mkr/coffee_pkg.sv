// Coffee Machine Controller - shared types/constants package.
// Mirrors coffee_architecture.md (interfaces, states) and
// coffee_receipie.md / coffee_receipie.csv (recipe timing model).
// Student RTL/testbenches should `import coffee_pkg::*;` rather than
// redefining these encodings.

package coffee_pkg;

    // -----------------------------------------------------------------
    // Clock / simulation timing (architecture.md note: synthesized HW
    // takes many real seconds per coffee; simulation uses SIM_SPEEDUP
    // to compress recipe timing).
    // -----------------------------------------------------------------
    localparam int unsigned CLK_FREQ_HZ   = 50_000_000; // DE2-115 CLOCK_50
    localparam int unsigned SIM_SPEEDUP   = 1;           // override in tb to shrink cycle counts

    // Converts a recipe duration in seconds to clock cycles at elaboration time.
    function automatic int unsigned sec_to_cycles(real seconds,
                                                    int unsigned clk_freq_hz = CLK_FREQ_HZ,
                                                    int unsigned speedup     = SIM_SPEEDUP);
        return $rtoi((seconds * clk_freq_hz) / speedup);
    endfunction

    // -----------------------------------------------------------------
    // Product selection (architecture.md §5): flavor, drink type and
    // size are three independent axes (2 x 5 x 3 = 30 valid orders).
    // -----------------------------------------------------------------
    typedef enum logic [0:0] {
        COFFEE_FLAVOR_0 = 1'b0,
        COFFEE_FLAVOR_1 = 1'b1
    } coffee_flavor_e;

    typedef enum logic [2:0] {
        DRINK_DRIP      = 3'd0,
        DRINK_AMERICANO = 3'd1,
        DRINK_LATTE     = 3'd2,
        DRINK_MOCHA     = 3'd3,
        DRINK_ESPRESSO  = 3'd4
    } drink_type_e;
    localparam int unsigned NUM_DRINK_TYPES = 5;

    typedef enum logic [1:0] {
        SIZE_10OZ = 2'd0,
        SIZE_16OZ = 2'd1,
        SIZE_20OZ = 2'd2
    } drink_size_e;
    localparam int unsigned NUM_SIZES = 3;

    function automatic real size_to_oz(drink_size_e size);
        case (size)
            SIZE_10OZ: return 10.0;
            SIZE_16OZ: return 16.0;
            SIZE_20OZ: return 20.0;
            default:   return 10.0;
        endcase
    endfunction

    typedef struct packed {
        coffee_flavor_e flavor;
        drink_type_e    drink;
        drink_size_e    size;
    } order_t;

    // -----------------------------------------------------------------
    // Operating states (architecture.md §7).
    // -----------------------------------------------------------------
    typedef enum logic [2:0] {
        ST_IDLE,
        ST_SELECTING,
        ST_CONFIRM,
        ST_BREWING,
        ST_WARNING,
        ST_ERROR
    } coffee_state_e;

    typedef enum logic [1:0] {
        SEV_NORMAL,
        SEV_WARNING,
        SEV_ERROR
    } severity_e;

    // -----------------------------------------------------------------
    // Standard Coffee Processing Interface (architecture.md §4).
    // -----------------------------------------------------------------
    localparam logic [1:0] PAPER_OK            = 2'b11;
    localparam logic [1:0] PAPER_ALMOST_EMPTY  = 2'b10;
    localparam logic [1:0] PAPER_EMPTY         = 2'b01;
    localparam logic [1:0] PAPER_NOT_INSTALLED = 2'b00;

    localparam logic [1:0] W_PRESSURE_ERROR_COND = 2'b11;
    localparam logic [1:0] W_PRESSURE_HIGH       = 2'b10;
    localparam logic [1:0] W_PRESSURE_OK         = 2'b01;
    localparam logic [1:0] W_PRESSURE_LOW        = 2'b00;

    // Inputs (sensors) - 10 bits total, mapped to slide switches in HW.
    typedef struct packed {
        logic [1:0] PAPER_LEVEL;
        logic       BIN_0_AMPTY;
        logic       BIN_1_AMPTY;
        logic       ND_AMPTY;
        logic       CH_AMPTY;
        logic [1:0] W_PRESSURE;
        logic       W_TEMP;
        logic       STATUS;
    } sensor_in_t;
    localparam int unsigned SENSOR_IN_WIDTH = $bits(sensor_in_t);

    // Outputs (actuators) - 9 bits total, mapped to LEDs in HW.
    // PRESSURE_EN is a student-added extension for espresso pressurized pour.
    typedef struct packed {
        logic HEAT_EN;
        logic POUROVER_EN;
        logic WATER_EN;
        logic GRINDER_0_EN;
        logic GRINDER_1_EN;
        logic PAPER_EN;
        logic CH_EN;
        logic ND_EN;
        logic PRESSURE_EN;
    } actuator_out_t;
    localparam int unsigned ACTUATOR_OUT_WIDTH = $bits(actuator_out_t);

    // -----------------------------------------------------------------
    // Recipe timing model (architecture.md §6 / coffee_receipie.md).
    // All rates below except R_POUR are documented assumptions pending
    // instructor confirmation (architecture.md §10, conflict #5).
    // -----------------------------------------------------------------
    localparam real R_POUR       = 1.0;  // oz/sec, POUROVER_EN - given by PRD
    localparam real R_WATER      = 1.0;  // oz/sec, WATER_EN   - ASSUMPTION
    localparam real R_PRESSURE   = 0.5;  // oz/sec, PRESSURE_EN - ASSUMPTION
    localparam real R_ND         = 1.0;  // oz/sec, ND_EN      - ASSUMPTION
    localparam real SHOT_OZ      = 2.0;  // fixed espresso shot volume - ASSUMPTION
    localparam real CH_VOL_OZ    = 1.0;  // fixed Mocha topping volume - ASSUMPTION
    localparam real CH_PULSE_SEC = 3.0;  // fixed Mocha topping pulse duration - ASSUMPTION
    localparam real GRIND_RATE   = 0.3;  // sec/oz of grounds-contact volume - ASSUMPTION
    localparam real PAPER_PULSE  = 1.0;  // sec, fixed filter-advance pulse - ASSUMPTION

    // Per-recipe step durations, in seconds. 0.0 means the signal is
    // unused for that drink type (matches coffee_receipie.csv columns).
    typedef struct packed {
        real paper_s;
        real grind_s;
        real pourover_s;
        real pressure_s;
        real water_s;
        real ch_s;
        real nd_s;
        real total_s;
    } recipe_steps_t;

    // Computes the step durations for a given drink type/size from the
    // timing model constants above - single source of truth for the
    // chart in coffee_receipie.md / coffee_receipie.csv.
    function automatic recipe_steps_t get_recipe_seconds(drink_type_e drink, drink_size_e size);
        recipe_steps_t r;
        real size_oz = size_to_oz(size);
        r = '{default: 0.0};
        r.paper_s = PAPER_PULSE;

        case (drink)
            DRINK_DRIP: begin
                r.grind_s    = GRIND_RATE * size_oz;
                r.pourover_s = size_oz / R_POUR;
            end
            DRINK_AMERICANO: begin
                r.grind_s    = GRIND_RATE * SHOT_OZ;
                r.pressure_s = SHOT_OZ / R_PRESSURE;
                r.water_s    = (size_oz - SHOT_OZ) / R_WATER;
            end
            DRINK_LATTE: begin
                r.grind_s    = GRIND_RATE * SHOT_OZ;
                r.pressure_s = SHOT_OZ / R_PRESSURE;
                r.nd_s       = (size_oz - SHOT_OZ) / R_ND;
            end
            DRINK_MOCHA: begin
                r.grind_s    = GRIND_RATE * SHOT_OZ;
                r.pressure_s = SHOT_OZ / R_PRESSURE;
                r.ch_s       = CH_PULSE_SEC;
                r.nd_s       = (size_oz - SHOT_OZ - CH_VOL_OZ) / R_ND;
            end
            DRINK_ESPRESSO: begin
                r.grind_s    = GRIND_RATE * size_oz;
                r.pressure_s = size_oz / R_PRESSURE;
            end
            default: ; // r already zeroed above
        endcase

        r.total_s = r.paper_s + r.grind_s + r.pourover_s + r.pressure_s
                  + r.water_s + r.ch_s + r.nd_s;
        return r;
    endfunction

endpackage : coffee_pkg
