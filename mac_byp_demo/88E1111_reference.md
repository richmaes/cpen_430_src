# Marvell Alaska 88E1111 — Programming & Configuration Reference

Condensed from MV-S100649-00 Rev. M (Aug 31 2020) datasheet for use by coding agents
configuring/driving this PHY (e.g. on the DE2-115 board's ENET0/ENET1 ports) via
MDC/MDIO and/or hardware strap pins. Page/table numbers from the original PDF are
noted as `[p.N]` for traceability.

## 1. Device overview

- 10/100/1000BASE-T + 1000BASE-X Gigabit Ethernet PHY. `[p.3]`
- MAC-side interfaces (selected by hardware config or Register 27.3:0 `HWCFG_MODE`):
  GMII, MII, TBI, RGMII, RTBI, SGMII, 1000BASE-X Serial/GBIC. `[p.49-67]`
- Management: MDC/MDIO (clause 22, up to 8.3 MHz) **or** Two-Wire Serial Interface
  (TWSI, I2C-like), selected by `SEL_TWSI` config bit. `[p.81,84]`
- Packages: 117-TFBGA, 96-aQFN (replaces obsolete 96-BCC), 128-PQFP.

## 2. Hardware configuration pins (CONFIG[6:0])

Each `CONFIG[n]` pin is tied (on the PCB) to one of 8 constants, encoded via LED
output pins, `VDDO`, or `VSS`. Values are latched on the rising/de-assertion edge of
`RESETn`. Register writes can override everything except PHY address. `[p.68]`

### Pin-to-constant encoding (what each CONFIG pin can be strapped to)

| Strap pin tied to | Bit[2:0] |
|---|---|
| VDDO | 111 |
| LED_LINK10 | 110 |
| LED_LINK100 | 101 |
| LED_LINK1000 | 100 |
| LED_DUPLEX | 011 |
| LED_RX | 010 |
| LED_TX | 001 |
| VSS | 000 |

### CONFIG pin → function bit mapping `[Table 34, p.70]`

| Pin | Bit[2] | Bit[1] | Bit[0] |
|---|---|---|---|
| CONFIG0 | PHYADR[2] | PHYADR[1] | PHYADR[0] |
| CONFIG1 | ENA_PAUSE | PHYADR[4] | PHYADR[3] |
| CONFIG2 | ANEG[3] | ANEG[2] | ANEG[1] |
| CONFIG3 | ANEG[0] | ENA_XC | DIS_125 |
| CONFIG4 | HWCFG_MODE[2] | HWCFG_MODE[1] | HWCFG_MODE[0] |
| CONFIG5 | DIS_FC | DIS_SLEEP | HWCFG_MODE[3] |
| CONFIG6 | SEL_TWSI | INT_POL | 75/50 OHM |

### Field meanings `[Table 35, p.71]`

- **PHYADR[4:0]** — MDIO PHY address (TWSI device addr lower 5 bits; TWSI addr
  bits[6:5] fixed at `10`).
- **ENA_PAUSE** — default advertised pause bits (Reg 4.11:10 copper / 4.8:7 fiber):
  `0`=00, `1`=11.
- **ANEG[3:0]** (copper) — Auto-Neg enable/speed/duplex/Master-Slave preference:
  - `0000`=forced 10HD, `0001`=10FD, `0010`=100HD, `0011`=100FD
  - `01xx`=AN advertise 1000BASE-T half-duplex only (xx = forced/preferred M/S)
  - `10xx`=AN advertise 1000BASE-T full-duplex only
  - `11xx`=AN advertise all speeds (`00`=forced Master,`01`=forced Slave,
    `10`=prefer Master,`11`=prefer Slave)
- **ANEG[3:2]** (fiber) — `01`=forced 1000BASE-X HD, `10`=forced FD,
  `11`=AN enabled.
- **ENA_XC** — 1=enable MDI/MDIX auto-crossover, 0=force MDI.
- **DIS_125** — 1=disable 125CLK output.
- **HWCFG_MODE[3:0]** — MAC interface mode, see §3 table.
- **DIS_FC** — 1=disable fiber/copper auto-selection.
- **DIS_SLEEP** — 0=Energy Detect+ (Mode 2, default), 1=normal power (no energy
  detect sleep).
- **SEL_TWSI** — 0=MDC/MDIO, 1=TWSI management interface.
- **INT_POL** — 0=INTn active-high, 1=active-low.
- **75/50 OHM** — default SERDES/SGMII I/O termination (0=50Ω, 1=75Ω).

## 3. HWCFG_MODE[3:0] — MAC interface mode select

Also directly settable/read via **Register 27 bits [3:0]** (page-independent) after
a software reset. `[Table 35 p.72, Reg27 p.175]`

| Value | Mode |
|---|---|
| `0000` | SGMII w/ clock, SGMII AN → Copper |
| `0100` | SGMII w/o clock, SGMII AN → Copper |
| `1000` | 1000BASE-X w/o clock, w/ 1000BASE-X AN → Copper (GBIC) |
| `1100` | 1000BASE-X w/o clock, w/o AN → Copper (legacy GBIC) |
| `1001` | RTBI → Copper |
| `1101` | TBI → Copper |
| `0110` | RGMII → SGMII |
| `1110` | GMII → SGMII |
| `0011` | RGMII → Fiber |
| `0111` | GMII → Fiber |
| `1011` | RGMII → Copper |
| `1111` | GMII/MII → Copper |

Mode switching: write new value to Reg27.3:0, then software reset (Reg0.15=1).
Some transitions require extra steps (re-advertise capabilities in Reg4, toggle
0_1.12 AN enable, reprogram Reg27.12 bypass mode) — see datasheet §2.3.4 `[p.67]`.

## 4. MDC/MDIO management frame (clause 22) `[p.81]`

```
<32-bit preamble (all 1s)><ST=01><OP><PHYADDR[4:0]><REGADDR[4:0]><TA><DATA[15:0]>
OP: Read=10, Write=01
TA (turnaround): Read = z0 (driven by PHY), Write = 10 (driven by station)
```
- Max MDC rate: 8.3 MHz. Preamble suppression supported (min 1 idle bit between ops).
- >32 registers via paging: **Register 22[7:0]** selects copper(0x00)/fiber(0x01)
  page for regs 0,1,4,5,6,7,8,17,18,19 (and selects VCT MDI pair 0-3 for Reg 28).
  **Register 29[4:0]** selects the page for Register 30 (hidden/extended regs).
  Set `Reg22.15=0` to disable automatic medium register selection when paging
  manually. `[p.121,168]`
- Shorthand in this doc: `reg_page.bits` e.g. `4_1.5` = Register 4, page 1
  (fiber), bit 5.

## 5. Register map summary `[Table 58 p.123]`

| Addr | Page 0 (Copper) | Page 1 (Fiber) |
|---|---|---|
| 0 | Control | Control |
| 1 | Status | Status |
| 2,3 | PHY Identifier (page-independent) | |
| 4 | AN Advertisement | AN Advertisement |
| 5 | Link Partner Ability | Link Partner Ability |
| 6 | AN Expansion | AN Expansion |
| 7 | Next Page Transmit | Next Page Transmit |
| 8 | Link Partner Next Page | Link Partner Next Page |
| 9 | 1000BASE-T Control (page-independent) | |
| 10 | 1000BASE-T Status (page-independent) | |
| 11-14 | Reserved | |
| 15 | Extended Status (page-independent) | |
| 16 | PHY Specific Control (page-independent) | |
| 17 | PHY Specific Status | PHY Specific Status |
| 18 | Interrupt Enable | Interrupt Enable |
| 19 | Interrupt Status | Interrupt Status |
| 20 | Extended PHY Specific Control (page-independent) | |
| 21 | Receive Error Counter (page-independent) | |
| 22 | Extended Address / page select (no paging) | |
| 23 | Global Status (page-independent) | |
| 24 | LED Control (page-independent) | |
| 25 | Manual LED Override (page-independent) | |
| 26 | Extended PHY Specific Control 2 (page-independent) | |
| 27 | Extended PHY Specific Status (page-independent) | |
| 28 | VCT status (pages 0-3=MDI pair, 4=pair skew, 5=swap/polarity) | |
| 29 | Extended Address / Reg30 page select (no paging) | |
| 30 | Paged via Reg29: 3=calib override, 7=force gigabit, 11=class A/B, 12=CRC checker, 16=test enable, 18=misc control | |
| 31 | Reserved | |

## 6. Key registers for day-to-day programming

### Register 0 — Control (copper page 0 / fiber page 1) `[Table 59/60 p.125]`

| Bit | Field | Notes |
|---|---|---|
| 15 | Reset | self-clearing software reset |
| 14 | Loopback | 1=enable MAC-interface loopback |
| 13,6 | Speed[1:0] | `11`=rsvd `10`=1000 `01`=100 `00`=10 (ignored if AN enabled & not forced) |
| 12 | AN Enable | 1=enable Auto-Negotiation |
| 11 | Power Down | 1=IEEE power down |
| 10 | Isolate | 1=tristate MAC-interface outputs |
| 9 | Restart AN | self-clearing |
| 8 | Duplex | 1=full |
| 7 | Collision test | |

To force 10BASE-T half-duplex & disable AN: write `0x8000`. Changes to bits 6,8,12,13
require a software reset (bit 15) or AN restart (bit 9) to take effect.

### Register 1 — Status `[Table 61/62 p.133]`

| Bit | Meaning |
|---|---|
| 5 | AN complete |
| 4 | Remote fault (latch-high) |
| 2 | Link status (latched-low; read twice for live value, or use `17.10`) |

### Register 4 — AN Advertisement (copper) `[Table 65 p.137]`

| Bit | Field |
|---|---|
| 15 | Next page |
| 11 | Asymmetric pause |
| 10 | Pause |
| 8 | 100BASE-TX full |
| 7 | 100BASE-TX half |
| 6 | 10BASE-T full |
| 5 | 10BASE-T half |
| 4:0 | Selector field (always `00001` = 802.3) |

(1000BASE-T advertisement is in **Register 9**, bits 9/8 = full/half duplex.)

### Register 5 — Link Partner Ability (copper) `[Table 70 p.144]`
Mirrors Reg4 bit layout but read-only, reflects the received base page.

### Register 9 — 1000BASE-T Control `[Table 81 p.152]`

| Bit | Field |
|---|---|
| 12 | Manual Master/Slave config enable |
| 11 | Master/Slave value (1=Master) |
| 10 | Port type (1=prefer Master/multi-port) |
| 9 | Advertise 1000BASE-T full-duplex |
| 8 | Advertise 1000BASE-T half-duplex |

### Register 10 — 1000BASE-T Status `[Table 82 p.154]`

| Bit | Field |
|---|---|
| 15 | Master/Slave config fault (latch-high) |
| 14 | Master/Slave resolution (1=Master) |
| 13/12 | Local/Remote receiver OK |
| 11/10 | Link partner 1000BASE-T full/half capable |

### Register 16 — PHY Specific Control `[Table 88 p.157]`

| Bit | Field |
|---|---|
| 15:14 | TX FIFO depth |
| 13:12 | RX FIFO depth |
| 10 | Force link good (bypasses link state machine, not valid in 1000BASE-T) |
| 9:8 | Energy detect: `0x`=off `10`=Energy Detect `11`=Energy Detect+ |
| 6:5 | MDI crossover mode: `00`=MDI `01`=MDIX `11`=auto |
| 4 | Disable 125CLK |
| 3 | MAC interface power-down behavior (1=always powered) |
| 1 | Disable polarity reversal correction |
| 0 | Disable jabber |

### Register 17 — PHY Specific Status (copper) `[Table 89 p.159]` — **primary link-status register**

| Bit | Field |
|---|---|
| 15:14 | Speed: `10`=1000 `01`=100 `00`=10 (valid only if bit11=1) |
| 13 | Duplex (valid only if bit11=1) |
| 11 | Speed/Duplex resolved |
| 10 | **Link (real time)** — use this, not Reg1.2 |
| 9:7 | Cable length estimate (1000BASE-T only) |
| 6 | MDI crossover status (1=MDIX) |
| 5 | Downshift status |
| 4 | Energy detect / sleep status |
| 1 | Polarity (real time) |

### Registers 18/19 — Interrupt Enable / Status `[Table 91-94 p.161]`
Bit layout identical between the two (enable vs. latched status): bit15=AN error,
14=speed changed,13=duplex changed,12=page rx,11=AN complete,10=link changed,
9=symbol error,8=false carrier,7=FIFO over/underflow,6=MDI crossover changed,
5=downshift,4=energy detect changed,2=DTE power status changed,1=polarity changed,
0=jabber. `INTn` pin asserts per `INT_POL` config while any enabled+latched bit set;
clear by reading Reg19.

### Register 20 — Extended PHY Specific Control `[Table 95 p.165]`

| Bit | Field |
|---|---|
| 15 | Block TRR byte-stuffing (needs soft reset) |
| 14 | Enable copper line loopback |
| 11:9 | Downshift counter (# of 1000 link attempts before downshift) |
| 8 | Downshift enable |
| 7 | RGMII RX_CLK extra delay |
| 6:4 | Default MAC speed while link down / also sets GMII-RGMII-to-SGMII speed when SGMII AN disabled |
| 2 | DTE (PoE) detect enable |
| 1 | RGMII GTX_CLK extra delay |

### Register 22 — Extended Address / page select `[Table 97 p.168]`
Bits[7:0]: `0x00`=copper reg bank, `0x01`=fiber reg bank (also selects VCT MDI pair
for Reg28 page 0-3). Bit15 "automatic medium register selection" should be 0 for
deterministic manual paging.

### Register 24/25 — LED Control / Manual Override `[Table 100/101 p.170]`
Reg25 bit-pairs `00`=normal(PHY-driven) `01`=blink `10`=force off `11`=force on,
for LED_DUPLEX[11:10], LED_LINK10[9:8], LED_LINK100[7:6], LED_LINK1000[5:4],
LED_RX[3:2], LED_TX[1:0]. Reg24 bits 5:3 select combined link-LED mode (`000`
direct, `011` master/slave, others see datasheet §2.23.2.2).

### Register 26 — Extended PHY Specific Control 2 `[Table 102 p.172]`

| Bit | Field |
|---|---|
| 11:10 | Fiber/copper media preference: `00`=first-up `01`=fiber `10`=copper |
| 7 | Use external fiber signal-detect pin |
| 6 | Fiber 75Ω input impedance (0=50Ω) |
| 5 | Fiber 75Ω output impedance (0=50Ω) |
| 2:0 | Fiber output amplitude (000=0.50V … 111=1.20V @100Ω load) |

### Register 27 — Extended PHY Specific Status `[Table 103 p.174]`

| Bit | Field |
|---|---|
| 15 | Disable fiber/copper auto-selection |
| 13 | Fiber/copper resolution (1=fiber, valid only if link up) |
| 12 | Serial-interface AN bypass enable |
| 10 | Interrupt polarity (mirrors INT_POL) |
| 9 | Disable automatic medium register selection |
| 8:5 | DTE-power-lost report delay (×5s) |
| 4 | DTE power status |
| 3:0 | **HWCFG_MODE[3:0]** (R/W, see §3) |

### Register 28 — Virtual Cable Tester (VCT) `[Table 104-109 p.176]`
Select MDI pair via `Reg22[1:0]` (0-3), then write `28.15=1` to start test; poll
`28.15==0` for completion. `28.14:13` = `00` normal, `01` short, `10` open,
`11` fail. `28.7:0` = distance (≈1 m/count, see table for conversion). Page 4/5
(valid when `28_5.6==1`) give per-pair skew and polarity/crossover detail.

### Register 29 — page select for Register 30 `[Table 110 p.179]`
`0x00`=pg0, `0x03`=pg3 (calibration), `0x07`=pg7 (force gigabit), `0x0C`=pg12 (CRC
checker), `0x10`=pg16 (test enable incl. CRC enable / gigabit stub loopback),
`0x12`=pg18 (misc control incl. calibration targets, packet generator).

## 7. Common procedures

### Software reset
Set bit 0.15 = 1 (self-clears). Register changes requiring reset to take effect:
speed/duplex (Reg0 bits 6,8,13), AN enable (0.12), HWCFG_MODE (27.3:0), MDI
crossover mode (16.6:5), FIFO depth (16.15:12), downshift config (20.11:8),
RGMII delay (20.7,20.1), DTE enable (20.2).

### Restart Auto-Negotiation
Set bit 0.9 = 1 (self-clears). AN also auto-restarts on HW/SW reset, power-down→up
transition, or link loss.

### Force a specific speed/duplex (disable AN)
```
Reg0 = 0x0100   ; AN disabled(bit12=0), 100 Mbps(bit13=0,bit6=1), half-duplex(bit8=0)
Reg0.15 = 1     ; software reset to apply
```
1000 Mbps is NOT forceable without AN per IEEE — even with AN disabled in bit
0.12, setting speed=1000 via 0.13/0.6 keeps AN running advertising only
1000BASE-T at the chosen duplex.

### Read link status (poll loop)
Read `Register 17` bits `[15:14]`=speed, `[13]`=duplex, `[10]`=live link,
`[11]`=resolved. This avoids the latching behavior of Register 1 bit 2.

### Enable/force MDI-MDIX crossover
`Reg16[6:5]` = `11` auto (default w/ ENA_XC=1), `00` force MDI, `01` force MDIX.
Requires software reset.

### Loopback (MAC interface, for BIST)
```
Reg27.15 = 1        ; disable fiber/copper auto-select first
Reg0.14  = 1         ; enable loopback (speed per Reg20.6:4 / Reg0.13,0.6)
```
Also see external Gigabit stub-loopback sequence in datasheet §2.15.3 (uses
Reg29/Reg30 hidden pages) if PCB-level test fixtures are available.

### Low-power modes
- COMA: assert `COMA` pin high (cannot be entered while hw reset active; PHY
  cannot wake itself).
- IEEE power-down: `Reg0.11 = 1`.
- Energy Detect / Energy Detect+: `Reg16[9:8] = 10`/`11` (Energy Detect+ is
  default unless `DIS_SLEEP` strap set). To fully exit, set `16.9:8=00` + soft
  reset.

## 8. Interface pin-mapping cheat sheet (for board bring-up)

- GMII/MII/RGMII/RTBI/TBI share the same physical pins
  (`GTX_CLK,TX_EN,TX_ER,TXD[7:0],RX_CLK,RX_DV,RX_ER,RXD[7:0],CRS,COL`); the active
  protocol depends on `HWCFG_MODE`. `[Tables 22-27 p.53-61]`
- RGMII is DDR-multiplexed: `TXD[3:0]`/`TX_EN` carry both nibbles + control signal
  on rising/falling edges of `GTX_CLK`/`RX_CLK`. `[p.57]`
- `125CLK` output is a free-running 125 MHz reference for the MAC, disable via
  `DIS_125` strap or `Reg16.4`.
- `RESETn` must be held low with `XTAL1` already toggling ≥10 cycles before
  release; registers aren't accessible until ~5 ms after `RESETn` deassert.
  `[Table 137 p.203]`
- MDIO pull-up: 1.5–10 kΩ. MDC max 8.3 MHz.

## 9. RGMII electrical & timing interface (for the FPGA RGMII MAC)

RGMII shares the same physical pins/voltage domain as GMII/MII/TBI
(`GTX_CLK,TX_EN,TX_ER,TXD[7:0],RX_CLK,RX_DV,RX_ER,RXD[7:0],CRS,COL`), all powered
from **VDDO**.

### Voltage domain `[Table 119 p.184, Table 130 p.194]`
- VDDO supply: 2.37–2.63V (2.5V nominal); absolute max 2.75V.
- Inputs: VIH 1.7–3.47V min/max, VIL -0.3–0.8V (3.3V-tolerant).
- Outputs: VOH ≥ VDDO-0.2V (IOH=-4mA), VOL ≤ 0.2V (IOL=4mA).
- A 2.5V or 3.3V LVCMOS/LVTTL FPGA bank interfaces directly; a 1.8V bank falls
  short of VIH min and needs level translation. Note: this PHY's RGMII does
  **not** support HSTL (unlike the original RGMII v1.2a spec) — it follows the
  LVCMOS-style timing of RGMII v2.0.

### RGMII clock & data AC timing `[Table 148 p.212, Figure 57]`

| Symbol | Meaning | Min | Typ | Max |
|---|---|---|---|---|
| `TskewT` | Data-to-clock output skew (PHY driving `RX_CLK`/`RXD`/`RX_CTL`) | -500ps | 0 | 500ps |
| `TskewR` | Data-to-clock input skew required at PHY's `GTX_CLK`/`TXD` inputs | 1.0ns | – | 2.8ns |
| `TCYCLE` | Clock cycle | 7.2ns | 8.0ns | 8.8ns |
| `TCYCLE_HIGH`(1000) | Clock high time @1000BASE-T | 3.6ns | 4.0ns | 4.4ns |
| `TCYCLE_HIGH`(100) | Clock high time @100BASE-T | 16ns | 20ns | 24ns |
| `TCYCLE_HIGH`(10) | Clock high time @10BASE-T | 160ns | 200ns | 240ns |
| `TRISE`/`TFALL` | Edge rate (20-80%) | – | – | 0.75ns |

- Data is DDR-multiplexed on `TXD[3:0]`/`RXD[3:0]` and `TX_EN`/`RX_DV` (as
  `TX_CTL`/`RX_CTL`), clocked on both edges of `GTX_CLK`/`RX_CLK`.
- Duty cycle may stretch/shrink up to 3×`TCYCLE` during a speed transition or
  while re-syncing to a newly received packet's clock domain — RGMII RX logic
  must tolerate this, not assume a rigid 50% duty cycle.

### Internal clock-delay registers — decide before wiring the FPGA `[Table 149-152 p.213-214]`
RGMII v2.0 needs ~1–2.6 ns clock-to-data skew, provided by *either* PCB
trace-length mismatch, the MAC, or the PHY. **The 88E1111 can add that skew
internally** via `Register 20`, so the FPGA doesn't have to:

| Register bit | 0 (default — no internal delay) | 1 (add internal delay) |
|---|---|---|
| `20.1` — `GTX_CLK` path (FPGA→PHY, transmit) | PHY input: tsetup ≥1.0ns / thold ≥0.8ns (clock ≈ edge-aligned with data at the pin) | tsetup ≥-0.9ns / thold ≥2.7ns (PHY delays its internal sample point ~1.5-2ns) |
| `20.7` — `RX_CLK` path (PHY→FPGA, receive) | PHY output: tskew -0.5 to +0.5ns (`RX_CLK` ≈ edge-aligned with `RXD`) | tsetup ≥1.2ns / thold ≥1.2ns (PHY delays `RX_CLK` output ~1.5-2ns relative to `RXD`) |

Both bits need a software reset to take effect.

**Decision for the FPGA designer:** if the board's RGMII traces are
length-matched (no built-in clock/data skew), set `20.1=1` and `20.7=1` so the
PHY inserts the delay ('RGMII-ID' style) and the FPGA MAC can treat
`GTX_CLK`/`RX_CLK` as roughly center-aligned with data. If the board already
adds the ~1.5-2ns trace-length skew (classic RGMII), leave both bits `0` and
design the FPGA's IOB output timing / input capture around the edge-aligned
numbers in the table above instead.

### Signal reference voltages used for the above timing `[Table 136 p.202]`
Timing is measured crossing these thresholds (not DC operating limits):
VIH=1.9V min / VIL=0.7V max for signals driving into the PHY (`GTX_CLK`,
`TXD`,`TX_EN`,`TX_ER`); VOH=1.9V min / VOL=0.7V max for signals driven by the
PHY (`RX_CLK`,`RXD`,`RX_DV`,`RX_ER`,`CRS`,`COL`) — i.e. roughly the half-VDDO
point.

## 10. MDIO electrical & timing interface (for the FPGA MDIO master)

The FPGA is the MDIO **station/master**: it always drives `MDC`, drives `MDIO`
only during the write phase + turnaround, and must tri-state `MDIO` to let the
PHY drive it during reads.

### Voltage domain `[Table 129 p.195]`

`MDC`/`MDIO` (plus `INTn`, `125CLK`, `RESETn`, JTAG) are powered from **VDDOX =
2.5V**, but the pins are **3.3V-tolerant inputs**, so a 3.3V or 2.5V LVCMOS FPGA
bank can drive/read them directly — no level shifter needed.

| Symbol | Condition | Min | Max |
|---|---|---|---|
| VIH (input high) | VDDOX=2.5V | 2.0 V | 3.47 V |
| VIL (input low) | VDDOX=2.5V | -0.3 V | 0.8 V |
| VOH (PHY output high) | IOH=-4mA | VDDOX-0.2V (~2.3V) | — |
| VOL (PHY output low) | IOL=4mA | — | 0.4 V |

- A 1.8V (or lower) FPGA bank **will not** meet `VIH min = 2.0V` directly —
  needs a level translator or open-drain + pull-up to 2.5V/3.3V.
- `MDIO` is effectively open-drain on the bus: board needs an external pull-up,
  **1.5 kΩ–10 kΩ**, to the I/O rail (2.5V or 3.3V). Drive `MDIO` as `inout`
  (tri-state when not actively writing/at turnaround-read bit).
- `INTn` is also open-drain (`D` pin type) — needs its own external pull resistor
  sized per `INT_POL` (pull-up if active-low, pull-down if active-high).

### MDC/MDIO AC timing `[Table 179 p.233, Figure 79]`

| Symbol | Meaning | Min | Max | Units |
|---|---|---|---|---|
| `TP_MDC` | MDC period | 120 | — | ns |
| `TH_MDC` | MDC high time | 30 | — | ns |
| `TL_MDC` | MDC low time | 30 | — | ns |
| `TSU_MDIO` | FPGA-driven MDIO setup before MDC edge | 10 | — | ns |
| `THD_MDIO` | FPGA-driven MDIO hold after MDC edge | 10 | — | ns |
| `TDLY_MDIO` | PHY-driven MDIO valid delay after MDC edge (read data) | 0 | 20 | ns |

Implications for the FPGA MDIO controller:
- **120 ns min period → MDC ≤ 8.3 MHz.** MDC does **not** need to be continuous/
  free-running — it can be gated/stopped between transactions (clause 22 does
  not require a free-running clock here), which simplifies a simple
  divide-down-from-system-clock generator.
- When the FPGA drives `MDIO` (preamble, ST/OP/PHYADDR/REGADDR, and write data),
  change the output on the MDC falling edge and hold it stable through the next
  rising edge with ≥10 ns margin on each side — i.e. launch data mid-low-phase,
  well before/after the rising edge where the PHY samples it.
- When reading, release (`Hi-Z`) `MDIO` for the turnaround bit before the PHY
  drives it; PHY output is valid within 20 ns of the MDC edge, so simply
  sampling on the following MDC edge (120 ns period) gives ample margin — no
  special fast comparator needed.
- Input leakage on digital pins without an internal pull device: ±10 µA;
  input capacitance ≈5 pF/pin. `[Table 131 p.196]`

### Frame format reminder `[Table 38 p.81]`
`<32-bit preamble of 1s><ST=01><OP: RD=10/WR=01><PHYADDR[4:0]><REGADDR[4:0]>
<TA: RD=Z0/WR=10><DATA[15:0]>`. The PHY is permanently configured to accept
**preamble suppression** (`Reg1.6`/`Reg17.6` reads back 1) — a minimalist FPGA
MDIO master can omit the 32-bit preamble and still only needs **≥1 idle bit**
between back-to-back operations, shortening each transaction if clock cycles
are precious. `[p.82]`

### Must-wait-before-first-access timing `[Table 137 p.203]`
- `XTAL1` must already be toggling ≥10 clock cycles before `RESETn` is released.
- `RESETn` assertion pulse ≥10 ms (power-up) / ≥10 ms (any later reset).
- **First MDIO transaction must wait ≥5 ms after `RESETn` deasserts** — the FPGA
  management-interface state machine should gate on a counter/timer here, not
  just start clocking MDC immediately on reset release.

## 11. Gotchas worth remembering

- Changing many control bits (speed, duplex, AN enable, HWCFG_MODE, MDI mode,
  FIFO depth, downshift, RGMII delay) is **inert until a software/hardware reset
  or AN restart occurs** — a naive single MDIO write will silently not apply.
- Register 1 bit 2 (link) is a **sticky/latched** "was link ever down" bit — poll
  `Register 17 bit 10` for the real-time value instead.
- 1000BASE-T requires Auto-Negotiation per IEEE; you cannot fully force gigabit
  without AN running (duplex-only forcing via Reg0.8 is possible with AN still
  enabled).
- Register access only works starting ~5 ms after reset deassertion; don't poll
  MDIO before that.
- Paging: forgetting to set `Register 22` (or `29` for Reg30) to the right
  page before reading/writing registers 0,1,4-8,17-19,28,30 is a common bug.
