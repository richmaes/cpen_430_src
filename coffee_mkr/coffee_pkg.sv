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

    // Converts a duration in deciseconds to clock cycles at elaboration time.
    function automatic logic [31:0] ds_to_cycles(logic [31:0] duration_ds,
                                                  logic [31:0] clk_freq_hz = CLK_FREQ_HZ,
                                                  logic [31:0] speedup     = SIM_SPEEDUP);
        logic [63:0] numerator;
        numerator = {32'b0, duration_ds} * {32'b0, clk_freq_hz};
        return numerator / (64'd10 * speedup);
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

    function automatic logic [7:0] size_to_oz(drink_size_e size);
        case (size)
            SIZE_10OZ: return 8'd10;
            SIZE_16OZ: return 8'd16;
            SIZE_20OZ: return 8'd20;
            default:   return 8'd10;
        endcase
    endfunction

    typedef struct packed {
        coffee_flavor_e flavor;
        drink_type_e    drink;
        drink_size_e    size;
    } order_t;

    // -----------------------------------------------------------------
    // Recipe timing model (architecture.md §6 / coffee_receipie.md).
    // Per-ounce timing values except POUR_DS_PER_OZ are documented
    // assumptions pending instructor confirmation (architecture.md §10, conflict #5).
    // -----------------------------------------------------------------
    localparam logic [15:0] POUR_DS_PER_OZ     = 16'd10; // 1 oz/sec
    localparam logic [15:0] WATER_DS_PER_OZ    = 16'd10; // 1 oz/sec
    localparam logic [15:0] PRESSURE_DS_PER_OZ = 16'd20; // 0.5 oz/sec
    localparam logic [15:0] ND_DS_PER_OZ       = 16'd10; // 1 oz/sec
    localparam logic [7:0] SHOT_OZ             = 8'd2;  // fixed espresso shot volume
    localparam logic [7:0] CH_VOL_OZ           = 8'd1;  // fixed Mocha topping volume
    localparam logic [15:0] CH_PULSE_DS        = 16'd30;
    localparam logic [15:0] GRIND_DS_PER_OZ    = 16'd3; // 0.3 sec/oz
    localparam logic [15:0] PAPER_PULSE_DS     = 16'd10;

    // Per-recipe step durations, in deciseconds. 0 means the signal is
    // unused for that drink type (matches coffee_receipie.csv columns).
    typedef struct packed {
        logic [15:0] paper_ds;
        logic [15:0] grind_ds;
        logic [15:0] pourover_ds;
        logic [15:0] pressure_ds;
        logic [15:0] water_ds;
        logic [15:0] ch_ds;
        logic [15:0] nd_ds;
        logic [15:0] total_ds;
    } recipe_steps_t;

    // Computes the step durations for a given drink type/size from the
    // timing model constants above - single source of truth for the
    // chart in coffee_receipie.md / coffee_receipie.csv.
    function automatic recipe_steps_t get_recipe_ds(drink_type_e drink, drink_size_e size);
        recipe_steps_t r;
        logic [7:0] size_oz;
        size_oz = size_to_oz(size);
        r = '0;
        r.paper_ds = PAPER_PULSE_DS;

        case (drink)
            DRINK_DRIP: begin
                r.grind_ds    = GRIND_DS_PER_OZ * size_oz;
                r.pourover_ds = POUR_DS_PER_OZ * size_oz;
            end
            DRINK_AMERICANO: begin
                r.grind_ds    = GRIND_DS_PER_OZ * SHOT_OZ;
                r.pressure_ds = PRESSURE_DS_PER_OZ * SHOT_OZ;
                r.water_ds    = WATER_DS_PER_OZ * (size_oz - SHOT_OZ);
            end
            DRINK_LATTE: begin
                r.grind_ds    = GRIND_DS_PER_OZ * SHOT_OZ;
                r.pressure_ds = PRESSURE_DS_PER_OZ * SHOT_OZ;
                r.nd_ds       = ND_DS_PER_OZ * (size_oz - SHOT_OZ);
            end
            DRINK_MOCHA: begin
                r.grind_ds    = GRIND_DS_PER_OZ * SHOT_OZ;
                r.pressure_ds = PRESSURE_DS_PER_OZ * SHOT_OZ;
                r.ch_ds       = CH_PULSE_DS;
                r.nd_ds       = ND_DS_PER_OZ * (size_oz - SHOT_OZ - CH_VOL_OZ);
            end
            DRINK_ESPRESSO: begin
                r.grind_ds    = GRIND_DS_PER_OZ * size_oz;
                r.pressure_ds = PRESSURE_DS_PER_OZ * size_oz;
            end
            default: ; // r already zeroed above
        endcase

        r.total_ds = r.paper_ds + r.grind_ds + r.pourover_ds + r.pressure_ds
                   + r.water_ds + r.ch_ds + r.nd_ds;
        return r;
    endfunction

endpackage : coffee_pkg
