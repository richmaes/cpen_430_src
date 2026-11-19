# Triple-Speed Ethernet Intel FPGA IP User Guide

> Converted from the supplied PDF. Page markers refer to PDF page numbers.

<!-- PDF page 1 -->

Triple-Speed Ethernet Intel® FPGA
IP User Guide
Updated for Intel® Quartus® Prime Design Suite: 21.3
IP Version: 19.5.0
Online Version
Send Feedback UG-01008
ID: 683402
Version: 2021.10.04

<!-- PDF page 2 -->

Contents
1. About This IP.................................................................................................................. 6
1.1. Release Information...............................................................................................6
1.2. Device Family Support............................................................................................7
1.3. Features...............................................................................................................8
1.4. 10/100/1000 Ethernet MAC Versus Small MAC...........................................................9
1.5. High-Level Block Diagrams....................................................................................10
1.6. Example Applications............................................................................................12
1.7. IP Verification......................................................................................................13
1.7.1. Optical Platform.......................................................................................14
1.7.2. Copper Platform.......................................................................................14
1.8. Performance and Resource Utilization..................................................................... 14
2. Getting Started with Intel FPGA IPs..............................................................................21
2.1. Design Walkthrough............................................................................................. 21
2.1.1. Creating a New Intel Quartus Prime Project................................................. 21
2.1.2. Generating a Design Example or Simulation Model....................................... 22
2.1.3. Simulating the System..............................................................................22
2.1.4. Compiling the Triple-Speed Ethernet Intel FPGA IP Design............................. 23
2.1.5. Programming an FPGA Device....................................................................23
2.2. Generated Files................................................................................................... 23
2.2.1. Design Constraint File No Longer Generated................................................ 24
3. Parameter Settings....................................................................................................... 26
3.1. Core Configuration...............................................................................................26
3.2. Ethernet MAC Options.......................................................................................... 28
3.3. FIFO Options.......................................................................................................29
3.4. Timestamp Options.............................................................................................. 30
3.5. PCS/Transceiver Options....................................................................................... 30
4. Functional Description.................................................................................................. 33
4.1. 10/100/1000 Ethernet MAC...................................................................................33
4.1.1. MAC Architecture..................................................................................... 34
4.1.2. MAC Interfaces........................................................................................35
4.1.3. MAC Transmit Datapath............................................................................ 37
4.1.4. MAC Receive Datapath..............................................................................39
4.1.5. MAC Transmit and Receive Latencies...........................................................45
4.1.6. FIFO Buffer Thresholds............................................................................. 46
4.1.7. Congestion and Flow Control..................................................................... 50
4.1.8. Magic Packets..........................................................................................51
4.1.9. MAC Local Loopback.................................................................................52
4.1.10. MAC Error Correction Code (ECC)............................................................. 53
4.1.11. MAC Reset.............................................................................................53
4.1.12. PHY Management (MDIO)........................................................................54
4.1.13. Connecting MAC to External PHYs.............................................................56
4.2. 1000BASE-X/SGMII PCS With Optional Embedded PMA............................................. 60
4.2.1. 1000BASE-X/SGMII PCS Architecture..........................................................60
4.2.2. Transmit Operation...................................................................................62
4.2.3. Receive Operation....................................................................................62
Contents
Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
2

<!-- PDF page 3 -->

4.2.4. Transmit and Receive Latencies..................................................................64
4.2.5. GMII Converter........................................................................................66
4.2.6. SGMII Converter......................................................................................66
4.2.7. Auto-Negotiation......................................................................................67
4.2.8. Ten-bit Interface......................................................................................70
4.2.9. PHY Loopback..........................................................................................71
4.2.10. PHY Power-Down....................................................................................72
4.2.11. 1000BASE-X/SGMII PCS Reset.................................................................73
4.3. Intel FPGA IEEE 1588v2........................................................................................74
4.3.1. IEEE 1588v2 Supported Configurations....................................................... 74
4.3.2. IEEE 1588v2 Features.............................................................................. 75
4.3.3. IEEE 1588v2 Architecture..........................................................................76
4.3.4. IEEE 1588v2 Transmit Datapath.................................................................76
4.3.5. IEEE 1588v2 Receive Datapath.................................................................. 77
4.3.6. IEEE 1588v2 Frame Format.......................................................................77
4.4. Deterministic Latency...........................................................................................82
5. Configuration Register Space........................................................................................84
5.1. MAC Configuration Register Space..........................................................................84
5.1.1. Base Configuration Registers (Dword Offset 0x00 – 0x17)............................. 85
5.1.2. Statistics Counters (Dword Offset 0x18 – 0x38)........................................... 92
5.1.3. Transmit and Receive Command Registers (Dword Offset 0x3A – 0x3B)...........94
5.1.4. Supplementary Address (Dword Offset 0xC0 – 0xC7)....................................95
5.1.5. IEEE 1588v2 Feature (Dword Offset 0xD0 – 0xD6)....................................... 95
5.1.6. Deterministic Latency (Dword Offset 0xE1– 0xE3)........................................ 96
5.1.7. IEEE 1588v2 Feature PMA Delay................................................................ 96
5.2. PCS Configuration Register Space.......................................................................... 97
5.2.1. Control Register (Word Offset 0x00)........................................................... 99
5.2.2. Status Register (Word Offset 0x01).......................................................... 100
5.2.3. Dev_Ability and Partner_Ability Registers (Word Offset 0x04 – 0x05)............ 101
5.2.4. An_Expansion Register (Word Offset 0x06)................................................103
5.2.5. If_Mode Register (Word Offset 0x14)........................................................ 103
5.3. Register Initialization..........................................................................................104
5.3.1. Triple-Speed Ethernet System with MII/GMII or RGMII................................ 104
5.3.2. Triple-Speed Ethernet System with SGMII..................................................107
5.3.3. Triple-Speed Ethernet System with 1000BASE-X Interface........................... 108
6. Interface Signals........................................................................................................ 110
6.1. Interface Signals................................................................................................110
6.1.1. 10/100/1000 Ethernet MAC Signals.......................................................... 111
6.1.2. 10/100/1000 Multiport Ethernet MAC Signals.............................................119
6.1.3. 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII PCS Signals.................122

#### 6.1.4. 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS and

Embedded PMA Signals (E-Tile)................................................................126

#### 6.1.5. 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS and

Embedded PMA Signals (F-Tile)................................................................ 129

#### 6.1.6. 10/100/1000 Ethernet MAC Without Internal FIFO Buffers with 1000BASE-

X/SGMII 2XTBI PCS Signals.....................................................................131

#### 6.1.7. 10/100/1000 Ethernet MAC Without Internal FIFO Buffers with IEEE

1588v2 and 1000BASE-X/SGMII 2XTBI PCS Signals....................................133
Contents
Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
3

<!-- PDF page 4 -->


#### 6.1.8. 10/100/1000 Ethernet MAC Without Internal FIFO Buffers with IEEE

1588v2, 1000BASE-X/SGMII 2XTBI PCS, SGMII Bridge, and Deterministic
Latency Signals......................................................................................135
6.1.9. 10/100/1000 Multiport Ethernet MAC with 1000BASE-X/SGMII PCS Signals....138

#### 6.1.10. 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII PCS and Embedded

PMA Signals...........................................................................................140

#### 6.1.11. 10/100/1000 Multiport Ethernet MAC with 1000BASE-X/SGMII PCS and

Embedded PMA Signals........................................................................... 143
6.1.12. 1000BASE-X/SGMII PCS Signals.............................................................149
6.1.13. 1000BASE-X/SGMII 2XTBI PCS Signals....................................................153
6.1.14. 1000BASE-X/SGMII PCS and PMA Signals................................................ 155
6.2. Timing..............................................................................................................156
6.2.1. Avalon Streaming Receive Interface..........................................................156
6.2.2. Avalon Streaming Transmit Interface........................................................ 158
6.2.3. GMII Transmit........................................................................................159
6.2.4. GMII Receive.........................................................................................159
6.2.5. RGMII Transmit......................................................................................159
6.2.6. RGMII Receive....................................................................................... 160
6.2.7. MII Transmit..........................................................................................161
6.2.8. MII Receive........................................................................................... 161
6.2.9. IEEE 1588v2 Timestamp......................................................................... 161
7. Design Considerations................................................................................................ 166
7.1. Optimizing Clock Resources in Multiport MAC with PCS and Embedded PMA................166
7.1.1. MAC and PCS With GX Transceivers.......................................................... 167
7.1.2. MAC and PCS With LVDS Soft-CDR I/O......................................................169
7.2. Sharing PLLs in Devices with LVDS Soft-CDR I/O.................................................... 172
7.3. Sharing PLLs in Devices with GIGE PHY................................................................. 173
7.4. Sharing Transceiver Quads.................................................................................. 173
7.5. Migrating From Old to New User Interface For Existing Designs................................ 173
7.5.1. Exposed Ports in the New User Interface................................................... 174
7.6. Clocking Scheme of MAC with 2XTBI PCS and Embedded PMA..................................175
8. Timing Constraints......................................................................................................177
8.1. Creating Clock Constraints...................................................................................177
8.2. Recommended Clock Frequency........................................................................... 178
9. Testbench................................................................................................................... 181
9.1. Triple-Speed Ethernet Testbench Architecture ........................................................181
9.2. Testbench Components....................................................................................... 181
9.3. Testbench Verification.........................................................................................182
9.4. Testbench Configuration......................................................................................183
9.5. Test Flow.......................................................................................................... 184
9.6. Simulation Model............................................................................................... 184
9.6.1. Generate the Simulation Model................................................................ 184
9.6.2. Simulate the IP......................................................................................185
9.6.3. Simulation Model Files............................................................................ 186
10. Software Programming Interface..............................................................................188
10.1. Driver Architecture........................................................................................... 188
10.2. Directory Structure...........................................................................................188
10.3. PHY Definition .................................................................................................189
Contents
Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
4

<!-- PDF page 5 -->

10.4. Using Multiple SG-DMA Descriptors.....................................................................191
10.5. Using Jumbo Frames.........................................................................................191
10.6. API Functions...................................................................................................192
10.6.1. alt_tse_mac_get_common_speed()........................................................ 192
10.6.2. alt_tse_mac_set_common_speed().........................................................192
10.6.3. alt_tse_phy_add_profile()......................................................................193
10.6.4. alt_tse_system_add_sys().....................................................................193
10.6.5. triple_speed_ethernet_init().................................................................. 194
10.6.6. tse_mac_close()...................................................................................194
10.6.7. tse_mac_raw_send()............................................................................ 195
10.6.8. tse_mac_setGMII mode()......................................................................195
10.6.9. tse_mac_setMIImode()......................................................................... 196
10.6.10. tse_mac_SwReset()............................................................................ 196
10.7. Constants........................................................................................................196
11. Triple-Speed Ethernet Intel FPGA IP User Guide Archives.........................................201

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide.202

A. Ethernet Frame Format...............................................................................................214
A.1. Basic Frame Format........................................................................................... 214
A.2. VLAN and Stacked VLAN Frame Format.................................................................214
A.3. Pause Frame Format...........................................................................................216
A.3.1. Pause Frame Generation......................................................................... 216
B. Simulation Parameters............................................................................................... 218
B.1. Functionality Configuration Parameters................................................................. 218
B.2. Test Configuration Parameters............................................................................. 219
Contents
Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
5

<!-- PDF page 6 -->


## 1. About This IP

The Triple-Speed Ethernet Intel® FPGA IP is a configurable intellectual property (IP)
core that complies with the IEEE 802.3 standard.
It incorporates a 10/100/1000 Mbps Ethernet media access controller (MAC) and an
optional 1000BASE-X/SGMII physical coding sublayer (PCS) with an embedded
physical medium attachment (PMA) built with either on-chip transceiver I/Os or LVDS
I/Os. When offered in MAC-only mode, the IP connects with an external PHY chip
using Media Independent Interface (MII), Gigabit Media Independent Interface (GMII),
or Reduced Gigabit Media Independent Interface (RGMII). The IP was tested and
successfully validated by the University of New Hampshire InterOperability Lab.
Related Information
Triple-Speed Ethernet Intel FPGA IP User Guide Archives on page 201
Provides a list of user guides for previous versions of the Triple-Speed Ethernet
Intel FPGA IP.

### 1.1. Release Information

Intel FPGA IP versions match the Intel Quartus® Prime Design Suite software versions
until v19.1. Starting in Intel Quartus Prime Design Suite software version 19.2, Intel
FPGA IP has a new versioning scheme.
The Intel FPGA IP version (X.Y.Z) number can change with each Intel Quartus Prime
software version. A change in:
• X indicates a major revision of the IP. If you update the Intel Quartus Prime
software, you must regenerate the IP.
• Y indicates the IP includes new features. Regenerate your IP to include these new
features.
• Z indicates the IP includes minor changes. Regenerate your IP to include these
changes.
**Table 1. Triple-Speed Ethernet Intel FPGA IP Release Information**

| Item | Description |
| --- | --- |
| IP Version | 19.5.0 |
| Intel Quartus Prime Version | 21.3 |
| Release Date | 2021.09.27 |
| Ordering Code | Triple-Speed Ethernet: IP-TRIETHERNET<br>IEEE 1588v2 for Triple-Speed Ethernet: IP-TRIETHERNETF |
| Product ID(s) | Triple-Speed Ethernet: 00BD |
|  | IEEE 1588v2 for Triple-Speed Ethernet: 0104 |
| Vendor ID(s) | 6AF7 |


# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 7 -->

Intel verifies that the current version of the Intel Quartus Prime software compiles the
previous version of each IP. The Intel FPGA IP Release Notes report any exceptions to
this verification. Intel does not verify compilation with IP versions older than one
release.
Related Information
• Intel FPGA IP Release Notes
• Triple-Speed Ethernet Design Examples
Available design examples in Intel FPGA Design Store.
• AN-744: Scalable Triple-Speed Ethernet Reference Designs for Arria 10 Device
• AN 830: Intel FPGA Triple-Speed Ethernet and On-Board PHY Chip Reference
Design

### 1.2. Device Family Support

The IP provides the following support for Intel FPGA device families.
**Table 2. Intel FPGA IP Device Support Levels**

| Device Support Level | Definition |
| --- | --- |
| Advance | The IP is available for simulation and compilation for this device family. Timing<br>models include initial engineering estimates of delays based on early post-layout<br>information. The timing models are subject to change as silicon testing improves<br>the correlation between the actual silicon and the timing models. You can use<br>this IP for system architecture and resource utilization studies, simulation,<br>pinout, system latency assessments, basic timing assessments (pipeline<br>budgeting), and I/O transfer strategy (datapath width, burst depth, I/O<br>standards tradeoffs). |
| Preliminary | The IP is verified with preliminary timing models for this device family. The IP<br>meets all functional requirements, but might still be undergoing timing analysis<br>for the device family. It can be used in production designs with caution. |
| Final | The IP is verified with final timing models for this device family. The IP meets all<br>functional and timing requirements for the device family and can be used in<br>production designs. |

**Table 3. Device Family Support for Triple-Speed Ethernet MAC**

| Device Family | Support | Minimum Speed Grade<br>with 1588 Feature |
| --- | --- | --- |
| Intel Agilex™ (E-tile and F-tile) | Preliminary | Not supported |
| Intel Stratix® 10 (E-tile) | Final | -I3 |
| Intel Stratix 10 (L-tile and H-tile) | Final | -I3 |
| Stratix V | Final | -I3 |
| Stratix IV | Final | Not supported |
| Intel Arria® 10 | Final | -I3 |
| Arria V | Final | -I5 |
| Arria II | Final | Not supported |
| Intel Cyclone® 10 GX | Final | -I5 |
| Intel Cyclone 10 LP | Final | Not supported |
| Cyclone V | Final | -I7 |
| Cyclone IV | Final | Not supported |
| Intel MAX® 10 | Final | -I7 |


## 1. About This IP


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
7

<!-- PDF page 8 -->


### 1.3. Features

• Complete triple-speed Ethernet IP: 10/100/1000 Mbps Ethernet MAC, 1000BASE-
X/SGMII PCS, and embedded PMA.
• Successful validation from the University of New Hampshire InterOperability Lab.
• 10/100/1000 Mbps Ethernet MAC features:
— Multiple variations: 10/100/1000 Mbps Ethernet MAC in full duplex, 10/100
Mbps Ethernet MAC in half duplex, 10/100 Mbps or 1000 Mbps small MAC
(resource-efficient variant), and multiport MAC that supports up to 24 ports
— Support for basic, virtual LAN (VLAN), stacked VLAN, and jumbo Ethernet
frames. Also supports control frames including pause frames
— Optional internal FIFO buffers, depth from 64 bytes to 256 Kbytes
— Optional statistics counters
• MAC interfaces:
— Client side—8 bit or 32 bit Avalon® streaming interface
— Network side—MII, GMII, or RGMII on the network side. Optional loopback on
these interfaces.
— Optional management data input/output (MDIO) master interface for PHY
device management.
• 1000BASE-X/SGMII PCS features:
— Compliance with Clause 36 of the IEEE standard 802.3.
— Optional embedded PMA implemented with serial transceiver or LVDS I/O and
soft clock data recovery (CDR) in Intel FPGA devices that support this interface
at 1.25 Gbps data rate.
— Support for auto-negotiation as defined in Clause 37.
— Support for connection to 1000BASE-X PHYs. Support for 10BASE-T, 100BASE-
T, and 1000BASE-T PHYs if the PHYs support SGMII.
• PCS interfaces:
— Client side—MII or GMII
— Network side—ten-bit interface (TBI) for PCS without PMA; 1.25 Gbps serial
interface for PCS with PMA implemented with serial transceiver or LVDS I/O
and soft CDR in Intel FPGA devices that support this interface at 1.25 Gbps
data rate.

## 1. About This IP


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
8

<!-- PDF page 9 -->

• Programmable features via 32 bit configuration registers:
— FIFO buffer thresholds.
— Pause quanta for flow control.
— Source and destination MAC addresses.
— Address filtering on receive, up to 5 unicast and 64 multicast MAC addresses.
— Promiscuous mode—receive frame filtering is disabled in this mode.
— Frame length—in MAC only variation, up to 64 Kbytes including jumbo frames.
In all variants containing 1000BASE-X/SGMII PCS (with or without MAC), the
frame length is up to 10 Kbytes.
— Optional auto-negotiation for the 1000BASE-X/SGMII PCS.
• Error correction code protection feature for internal memory blocks.
• Optional IEEE 1588v2 feature for 10/100/1000 Mbps Ethernet MAC with SGMII
PCS and embedded serial PMA variation operating without internal FIFO buffer in
full-duplex mode, 10/100/1000 Mbps MAC with SGMII PCS and embedded LVDS
I/O, variation operating without internal FIFO buffer in full-duplex mode, or MAC
only variation operating without internal FIFO buffer in full-duplex mode. This
feature is supported in Intel Stratix 10, Arria V, Intel Arria 10, Intel Cyclone 10
GX, Cyclone V, Intel MAX 10, and Stratix V device families. This feature is also
supported in the Intel Stratix 10 E-tile transceiver variant (10/100/1000 Mbps
Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS variation operating without
internal FIFO buffer in full-duplex mode).
• Optional deterministic latency feature for 10/100/1000 Mbps Ethernet MAC with
1000BASE-X/SGMII 2XTBI PCS and IEEE 1588v2 feature enabled variation
operating without internal FIFO buffer in full-duplex mode. This feature is only
supported in the Intel Stratix 10 E-tile devices.

### 1.4. 10/100/1000 Ethernet MAC Versus Small MAC

**Table 4. Feature Comparison between 10/100/1000 Ethernet MAC and Small MAC**

| Feature | 10/100/1000 Ethernet MAC | Small MAC |
| --- | --- | --- |
| Speed | Triple speed (10/100/1000 Mbps) | 10/100 Mbps or 1000 Mbps |
| External<br>interfaces | MII/GMII or RGMII | MII only for 10/100 Mbps small MAC, GMII or RGMII for<br>1000 Mbps small MAC |
| Control interface<br>registers | Fully programmable | Limited programmable options. The following options are<br>fixed:<br>• Maximum frame length is fixed to 1518. Jumbo frames<br>are not supported.<br>• FIFO buffer thresholds are set to fixed values.<br>• Store and forward option is not available.<br>• Interpacket gap (IPG) is set to 12.<br>• Flow control is not supported; pause quanta is not in<br>use.<br>• Checking of payload length is disabled. |
|  |  | • Supplementary MAC addresses are disabled.<br>• Padding removal is disabled.<br>• Sleep mode and magic packet detection is not<br>supported. |
| Synthesis options | Fully configurable | Limited configurable options. The following options are NOT<br>available:<br>• Flow control<br>• VLAN<br>• Statistics counters<br>• Multicast hash table<br>• Loopback<br>• TBI and 1.25 Gbps serial interface<br>• 8-bit wide FIFO buffers |




## 1. About This IP


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
9

<!-- PDF page 10 -->


### 1.5. High-Level Block Diagrams

High-level block diagrams of different variations of the Triple-Speed Ethernet Intel
FPGA IP.
Figure 1. 10/100/1000 Mbps Ethernet MAC
10/100/1000-Mbps
Ethernet MAC MII/GMII/RGMII
Client Side
Network Side
Avalon Streaming Interface
(Transmit and Receive)
Avalon Memory-Mapped
(Management and Control)
Figure 2. Multiport MAC
10/100/1000-Mbps
Ethernet MAC MII/GMII/RGMII
Client Side
Network Side
Avalon Streaming Interface
(Transmit and Receive)
Avalon Memory-Mapped
(Management and Control)
10/100/1000-Mbps
Ethernet MAC MII/GMII/RGMIIAvalon Streaming Interface
(Transmit and Receive)
Multi-Port MAC

## 1. About This IP


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback

<!-- PDF page 11 -->

Figure 3. 10/100/1000 Mbps Ethernet MAC and 1000BASE-X/SGMII PCS with Optional
PMA
MII/
GMII
Client Side
Network SideAvalon Streaming Interface
(Transmit and
Receive)
Avalon Memory-Mapped
(Management
and Control) 1.25-Gbps
Serial
MAC and PCS with Embedded PMA
1000BASE-X/SGMII
PCS
PMA
(Optional)
TBI
10/100/1000-Mbps
Ethernet MAC
Figure 4. 10/100/1000 Mbps Ethernet MAC and 1000BASE-X/SGMII 2XTBI PCS with
PMA
10/100/1000-MbpsEthernet MAC
MII/
GMII
Client Side
Network SideAvalon Streaming Interface
(Transmit and
Receive)
Avalon Memory-Mapped
(Management
and Control) 1.25-Gbps
Serial
MAC and PCS with Embedded PMA
1000BASE-X/SGMII2XTBI PCS PMA2XTBI
Figure 5. 10/100/1000 Mbps Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS
10/100/1000-MbpsEthernet MAC
MII/
GMII
Client Side
Network Side
Avalon Streaming Interface
(Transmit and
Receive)
Avalon Memory-Mapped
(Management
and Control) 2x Ten-bit
Interface
MAC and PCS
1000BASE-X/SGMII2XTBI PCS
Figure 6. 1000BASE-X/SGMII PCS with Optional PMA
MII/GMII
Client Side
Network Side
1.25-Gbps
Serial
PCS with Optional Embedded PMA
1000BASE-X/SGMII
PCS
PMA
(Optional)
TBI
Figure 7. 1000BASE-X/SGMII 2XTBI PCS
MII/GMII
Client Side
Network Side
2x Ten-bit
Interface
PCS
1000BASE-X/SGMII
2XTBI PCS

## 1. About This IP


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
11

<!-- PDF page 12 -->

Figure 8. Standalone 10/100/1000 Mbps Ethernet MAC
Gigabit or Fast Ethernet PHY Device
UserApplication
Host Interface MDIO Master
Intel FPGA Device Triple-Speed Ethernet Intel FPGA IP
Management Application
MDIO
Copper
MII/GMII/RGMII
Avalon Streaming InterfaceAvalon Memory-Mapped
10/100/1000-Mbps
Ethernet MAC

### 1.6. Example Applications

This section shows example applications of different variations of the Triple-Speed
Ethernet Intel FPGA IP.
The 10/100/1000 Gbps Ethernet MAC only variation can serve as a bridge between
your application and standard fast or gigabit Ethernet PHY devices.
Figure 9. Standalone 10/100/1000 Mbps Ethernet MAC
Example application using this variation for a copper network.
Gigabit or Fast Ethernet PHY Device
UserApplication
Host Interface MDIO Master
Intel FPGA Device Triple-Speed Ethernet Intel FPGA IP
Management Application
MDIO
Copper
MII/GMII/RGMII
Avalon Streaming InterfaceAvalon Memory-Mapped
10/100/1000-Mbps
Ethernet MAC
When configured to include the 1000BASE-X/SGMII PCS function, the IP can
seamlessly connect to any industry standard gigabit Ethernet PHY device via a TBI.
Alternatively, when the 1000BASE-X/SGMII PCS function is configured to include an
embedded PMA, the IP can connect directly to a gigabit interface converter (GBIC),
small form-factor pluggable (SFP) module, or an SGMII PHY.

## 1. About This IP


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
12

<!-- PDF page 13 -->

Figure 10. 10/100/1000 Mbps Ethernet MAC and 1000BASE-X PCS with Embedded PMA
Example application using the Triple-Speed Ethernet Intel FPGA IP with 1000BASE-X and PMA. The PMA block
connects to an off-the-shelf GBIC or SFP module to communicate directly over the optical link.
GMII PMA FiberGBIC/SFPModule

## 1.25 Gbps Serial

Intel FPGA Device
Triple-Speed Ethernet Intel FPGA IP
TBI10/100/1000-Mbps
Ethernet MAC
1000BASE-X
PCS
Figure 11. 10/100/1000 Mbps Ethernet MAC and SGMII PCS with Embedded PMA—
GMII/MII to 1.25-Gbps Serial Bridge Mode
Example application using the Triple-Speed Ethernet Intel FPGA IP with 1000BASE-X and PMA, in which the PCS
function is configured to operate in SGMII mode and acts as a GMII-to-SGMII bridge. In this case, the
transceiver I/O connects to an off-the-shelf Ethernet PHY that supports SGMII (10BASE-T, 100BASE-T, or
1000BASE-T Ethernet PHY).
CopperMII/GMII SGMII PCS PMA 10/100/1000

## 1.25 Gbps SGMII

Intel FPGA Device
TBI
Triple-Speed Ethernet Intel FPGA IP
BASE-T PHY
10/100/
1000-Mbps
Ethernet MAC

### 1.7. IP Verification

For each release, Intel verifies the Triple-Speed Ethernet Intel FPGA IP through
extensive simulation and internal hardware verification in various Intel FPGA device
families. The University of New Hampshire InterOperability Lab also successfully
verified the IP prior to its release.
Intel used a highly parameterizeable transaction-based testbench to test the following
aspects of the IP:
• Register access
• MDIO access
• Frame transmission and error handling
• Frame reception and error handling

## 1. About This IP


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
13

<!-- PDF page 14 -->

• Ethernet frame MAC address filtering
• Flow control
• Retransmission in half-duplex
Intel has also validated the Triple-Speed Ethernet Intel FPGA IP in both optical and
copper platforms using the following development kits:
• Nios ® II Development Kit, Cyclone II Edition (2C35)
• Intel Arria 10 FPGA Development Kit
• Intel Cyclone 10 LP FPGA Development Kit
• Stratix III FPGA Development Kit
• Stratix IV FPGA Development Kit
• Stratix V FPGA Development Kit
• Intel Stratix 10 FPGA Development Kit
• Quad 10/100/1000 Marvell PHY
• MorethanIP 10/100 and 10/100/1000 Ethernet PHY Daughtercards

#### 1.7.1. Optical Platform

In the optical platform, the 10/100/1000 Mbps Ethernet MAC, 1000BASE-X/SGMII
PCS, and PMA functions are instantiated.
The FPGA application implements the Ethernet MAC, the 1000BASE-X PCS, and an
internal system using Ethernet connectivity. This internal system retrieves all frames
received by the MAC function and returns them to the sender by manipulating the
MAC address fields, thus implementing a loopback. A direct connection to an optical
module is provided through an external SFP optical module. Certified 1.25 GBaud
optical SFP transceivers are Finisar 1000BASE-SX FTLF8519P2BNL, Finisar 1000BASE-
LX FTRJ-1319-3, and Avago Technologies AFBR-5710Z.

#### 1.7.2. Copper Platform

In the copper platform, Intel FPGA tested the Triple-Speed Ethernet Intel FPGA IP with
an external 1000BASE-T PHY devices. The IP is connected to the external PHY device
using MII, GMII, RGMII, and SGMII, in conjunction with the 1000BASE-X/SGMII PCS
and PMA functions.
A 10/100/1000 Mbps Ethernet MAC and an internal system are implemented in the
FPGA. The internal system retrieves all frames received by the MAC function and
returns them to the sender by manipulating the MAC address fields, thus
implementing a loopback. A direct connection to an Ethernet link is provided through a
combined MII to an external PHY module. Certified 1.25 GBaud copper SFP
transceivers are Finisar FCMJ-8521-3, Methode DM7041, and Avago Technologies
ABCU-5700RZ.

### 1.8. Performance and Resource Utilization

The estimated resource utilization and performance of the Triple-Speed Ethernet Intel
FPGA IP are obtained by compiling the Triple-Speed Ethernet Intel FPGA IP using the
Intel Quartus Prime software targeting a given device. The fMAX of all configurations is
more than 125 MHz.

## 1. About This IP


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
14

<!-- PDF page 15 -->

**Table 5. Resource Utilization for Triple-Speed Ethernet for Intel Agilex Devices**

| IP Variation | Settings | FIFO Buffer<br>Size (Bits) | Combinational ALUTs | Logic<br>Registers | Memory<br>(M20K) |
| --- | --- | --- | --- | --- | --- |
| 10/100/1000<br>Mbps Ethernet<br>MAC | MII/GMII.<br>All MAC options enabled.<br>Full- and half-duplex. | 2048x32 | 4051 | 5634 | 21 |
|  |  | 2048x8 | 3865 | 5442 | 16 |
| 10/100 Mbps<br>Small MAC | MII.<br>Full- and half-duplex only. | 2048x32 | 1445 | 2120 | 11 |
| 1000 Mbps Small<br>MAC | GMII.<br>Full-duplex only. | 2048x32 | 1178 | 1937 | 10 |
| 1000BASE-X/<br>SGMII PCS | SGMII bridge enabled. | N/A | 898 | 1448 | 0 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (LVDS_IO). | N/A | 967 | 1638 | 1 |
| 1000BASE-X/<br>SGMII 2XTBI PCS<br>only | SGMII bridge enabled. | N/A | 1329 | 2003 | 2 |
|  | 1000BASE-X. | N/A | 1267 | 1917 | 2 |
| 10/100/1000 Mb<br>Ethernet MAC<br>with 1000BASEX/<br>SGMII 2XTBI PCS | All MAC options enabled.<br>SGMII bridge enabled.<br>PMA block (GXB). | 2048x32 | 5415 | 7882 | 22 |
|  | All MAC options enabled.<br>SGMII bridge enabled.<br>PMA block (FGT). | 2048x32 | 5213 | 7279 | 21 |

The following estimates are obtained by targeting the Intel Agilex (AGFB014R24A3E3VR0) device.


**Table 6. Resource Utilization for Triple-Speed Ethernet in Intel Stratix 10 Devices**

| IP Variation | Settings | FIFO Buffer<br>Size (Bits) | Combinational ALUTs | Logic<br>Registers | Memory<br>(M20K) |
| --- | --- | --- | --- | --- | --- |
| Intel Stratix 10 (1SG280HN3F43E3VG) Device with Speed Grade -3 |  |  |  |  |  |
| 10/100/1000<br>Mbps Ethernet<br>MAC | MII/GMII.<br>All MAC options enabled.<br>Full- and half-duplex. | 2048x32 | 4055 | 5398 | 21 |
|  |  | 2048x8 | 3831 | 5139 | 16 |
| 10/100 Mbps<br>Small MAC | MII.<br>Full- and half-duplex only. | 2048x32 | 1460 | 2078 | 11 |
| 1000 Mbps Small<br>MAC | GMII.<br>Full-duplex only. | 2048x32 | 1158 | 1838 | 10 |
| 1000BASE-X/<br>SGMII PCS | SGMII bridge enabled. | N/A | 901 | 1333 | 0 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (LVDS_IO). | N/A | 945 | 1500 | 0 |
| Intel Stratix 10 (1ST280EY3F55E3VG) Device with Speed Grade -3 |  |  |  |  |  |
| 1000BASE-X/<br>SGMII 2XTBI PCS<br>only | SGMII bridge enabled. | N/A | 1306 | 1609 | 2 |
|  | 1000BASE-X | N/A | 1246 | 1543 | 2 |
| 10/100/1000 Mb<br>Ethernet MAC<br>with 1000BASE-<br>X/SGMII 2XTBI<br>PCS | All MAC options enabled.<br>SGMII bridge enabled.<br>PMA block (GXB). | 2048x32 | 5292 | 7244 | 22 |

The following estimates are obtained by targeting the Intel Stratix 10 device as indicated below.



## 1. About This IP


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
15

<!-- PDF page 16 -->

**Table 7. Resource Utilization for Triple-Speed Ethernet for Intel Arria 10 Devices**

| IP Variation | Settings | FIFO Buffer<br>Size (Bits) | Combinational ALUTs | Logic<br>Registers | Memory<br>(M20K) |
| --- | --- | --- | --- | --- | --- |
| 10/100/1000<br>Mbps Ethernet<br>MAC | MII/GMII.<br>All MAC options enabled.<br>Full- and half-duplex. | 2048x32 | 3817 | 5316 | 22 |
|  |  | 2048x8 | 3646 | 5142 | 17 |
| 10/100 Mbps<br>Small MAC | MII.<br>Full- and half-duplex. | 2048x32 | 1354 | 1986 | 12 |
| 1000 Mbps Small<br>MAC | GMII.<br>Full-duplex only. | 2048x32 | 1079 | 1769 | 10 |
| 1000BASE-X/<br>SGMII PCS | SGMII bridge enabled. | N/A | 841 | 1162 | 2 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (GXB). | N/A | 662 | 995 | 2 |
|  | 1000BASE-X. | N/A | 641 | 800 | 0 |

The following estimates are obtained by targeting the Intel Arria 10 GX (10AX115R4F40I3SG) device with
speed grade -3.


**Table 8. Resource Utilization for Triple-Speed Ethernet for Intel Cyclone 10 GX**

| IP Variation | Settings | FIFO Buffer<br>Size (Bits) | Combinational ALUTs | Logic<br>Registers | Memory<br>(M20K) |
| --- | --- | --- | --- | --- | --- |
| 10/100/1000<br>Mbps Ethernet<br>MAC | MII/GMII.<br>All MAC options enabled.<br>Full- and half-duplex. | 2048x32 | 3819 | 5346 | 22 |
|  |  | 2048x8 | 3646 | 5185 | 17 |
| 10/100 Mbps<br>Small MAC | MII.<br>Full- and half-duplex. | 2048x32 | 1358 | 1992 | 12 |
| 1000 Mbps Small<br>MAC | GMII.<br>Full-duplex only. | 2048x32 | 1083 | 1761 | 10 |
| 1000BASE-X/<br>SGMII PCS | SGMII bridge enabled. | N/A | 841 | 1175 | 2 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (GXB). | N/A | 662 | 992 | 2 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (LVDS_IO). | N/A | 877 | 1285 | 2 |

Devices
The following estimates are obtained by targeting the Intel Cyclone 10 GX (10CX220YU484I6G) device with
speed grade -6.



## 1. About This IP


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
16

<!-- PDF page 17 -->

**Table 9. Resource Utilization for Triple-Speed Ethernet for Intel Cyclone 10 LP Devices**

| IP Variation | Settings | FIFO Buffer<br>Size (Bits) | Combinational ALUTs | Logic<br>Registers | Memory<br>(M9K) |
| --- | --- | --- | --- | --- | --- |
| 10/100/1000<br>Mbps Ethernet<br>MAC | MII/GMII.<br>All MAC options enabled.<br>Full- and half-duplex. | 2048x8 | 6724 | 4840 | 17 |
|  |  | N/A | 5863 | 4204 | 8 |
| 1000BASE-X/<br>SGMII PCS | 1000BASE-X.<br>SGMII bridge enabled. | N/A | 1628 | 1133 | 2 |
| 10/100 Mbps<br>Small MAC | MII.<br>Full and half-duplex only. | N/A | 2416 | 1933 | 24 |
| 1000 Mbps Small<br>MAC | GMII.<br>Full-duplex only. | N/A | 1998 | 1645 | 24 |

The following estimates are obtained by targeting the Intel Cyclone 10 LP (10CL120YF780I7G) device.


**Table 10. Resource Utilization for Triple-Speed Ethernet for Intel MAX 10 Devices**

| IP Variation | Settings | FIFO Buffer<br>Size (Bits) | Logic<br>Elements | Logic<br>Registers | Memory<br>(M9K) |
| --- | --- | --- | --- | --- | --- |
| 10/100/1000<br>Mbps Ethernet<br>MAC | MII/GMII.<br>Full- and half-duplex. | 2048x32 | 6806 | 4943 | 30 |
|  |  | 2048x8 | 6593 | 4767 | 17 |
| 10/100 Mbps<br>Small MAC | MII.<br>Full- and half-duplex. | 2048x32 | 2650 | 2117 | 24 |
| 1000 Mbps Small<br>MAC | RGMII<br>Full-duplex only. | 2048x32 | 2286 | 1862 | 24 |

The following estimates are obtained by targeting the Intel MAX 10 (10M08DAF484C8G) device with speed
grade -8.


**Table 11. Resource Utilization for Triple-Speed Ethernet for Stratix V Devices**

| IP Variation | Settings | FIFO Buffer<br>Size (Bits) | Combinational ALUTs | Logic<br>Registers | Memory<br>(M20K<br>Blocks/<br>MLAB Bits) |
| --- | --- | --- | --- | --- | --- |
| 10/100 Mbps<br>Small MAC | MII.<br>Full- and half-duplex. | 2048x32 | 1261 | 2018 | 11/0 |
|  | MII.<br>All MAC options enabled. | 2048x32 | 1261 | 2018 | 11/0 |
| 1000 Mbps Small<br>MAC | GMII.<br>All MAC options enabled. | 2048x32 | 1227 | 1959 | 10/128 |
|  | RGMII.<br>All MAC options enabled. | 2048x32 | 1237 | 1984 | 10/128 |
| 10/100/1000<br>Mbps Ethernet<br>MAC | MII/GMII.<br>Full- and half-duplex. | N/A | 3137 | 4298 | 5/2048 |
|  |  | 2048x8 | 3627 | 4971 | 10/2048 |
|  |  | 2048x32 | 3777 | 5145 | 16/2048 |
|  | MII/GMII.<br>All MAC options enabled. | 2048x32 | 3454 | 4928 | 16/768 |
|  | RGMII.<br>All MAC options enabled. | 2048x32 | 3466 | 4933 | 16/768 |
| 1000BASE-X/<br>SGMII PCS | 1000BASE-X. | N/A | 614 | 786 | 0/0 |
|  | 1000BASE-X.<br>SGMII bridge enabled. | N/A | 839 | 1160 | 0/480 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (LVDS_IO). | N/A | 857 | 1250 | 0/480 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (GXB). | N/A | 2203 | 1991 | 5/2208 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (GXB).<br>The reconfig controller is compiled<br>with this variation. | N/A | 1441 | 903 | 4/2048 |
| 10/100/1000<br>Mbps Ethernet<br>MAC and<br>1000BASE-X/<br>SGMII PCS | All MAC options enabled.<br>SGMII bridge enabled. | 2048×32 | 4306 | 6132 | 16/1248 |
|  | Default MAC options.<br>SGMII bridge enabled.<br>IEEE 1588v2 feature enabled. | 0 | 5062 | 5318 | 4/1536 |

The following estimates are obtained by targeting the Stratix V GX (5SGXMA7N3F45C3) device with speed
grade -3.



## 1. About This IP


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
17

<!-- PDF page 18 -->



**Table 12. Resource Utilization for Triple-Speed Ethernet for Cyclone V Devices**

| IP Variation | Settings | FIFO Buffer<br>Size (Bits) | Combinational ALUTs | Logic<br>Registers | Memory<br>(M10K) |
| --- | --- | --- | --- | --- | --- |
| 10/100/1000<br>Mbps Ethernet<br>MAC | MII/GMII.<br>Full- and half-duplex. | 2048x32 | 1425 | 2299 | 21 |
|  |  | 2048x8 | 1387 | 2200 | 9 |
| 10/100 Mbps<br>Small MAC | MII.<br>Full- and half-duplex. | 2048x32 | 1338 | 2037 | 21 |
| 1000 Mbps Small<br>MAC | RGMII.<br>Full-duplex only.<br>(1) | 2048x32 | 1120 | 1829 | 20 |
| 1000BASE-X/<br>SGMII PCS | 1000BASE-X. | N/A | 633 | 846 | 0 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (GXB). | N/A | 783 | 1142 | 2 |
|  | 1000BASE-X.<br>SGMII bridge enabled. | N/A | 850 | 1248 | 2 |

The following estimates are obtained by targeting the Cyclone V GX (5CGXFC7C7F23C8) device with speed
grade -8.


(1) This variant is targeting devices with –6 speed grade.

## 1. About This IP


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
18

<!-- PDF page 19 -->

**Table 13. Resource Utilization for Triple-Speed Ethernet for Stratix IV Devices**

| IP Variation | Settings | FIFO Buffer<br>Size (Bits) | Combinational ALUTs | Logic<br>Registers | Memory<br>(M9K<br>Blocks/<br>M144K<br>Blocks/MLAB<br>Bits) |
| --- | --- | --- | --- | --- | --- |
| 10/100 Mbps<br>Small MAC | MII.<br>Full- and half-duplex. | 2048x32 | 1410 | 2127 | 12/1/1408 |
|  | MII.<br>All MAC options enabled. | 2048x32 | 1157 | 1894 | 12/1/128 |
| 1000 Mbps Small<br>MAC | GMII.<br>All MAC options enabled. | 2048x32 | 1160 | 1827 | 12/1/176 |
|  | RGMII.<br>All MAC options enabled. | 2048x32 | 1170 | 1861 | 12/1/176 |
| 10/100/1000-<br>Mbps Ethernet<br>MAC | MII/GMII.<br>Full- and half-duplex. | N/A | 2721 | 3395 | 0/0/3364 |
|  |  | 2048x8 | 3201 | 3977 | 8/0/3620 |
|  |  | 2048x32 | 3345 | 4425 | 12/1/3364 |
|  | MII/GMII.<br>All MAC options enabled. | 2048x32 | 3125 | 3994 | 12/1/2084 |
|  | RGMII.<br>All MAC options enabled. | 2048x32 | 3133 | 4021 | 12/1/2084 |
| 1000BASE-X/<br>SGMII PCS | 1000BASE-X. | N/A | 624 | 661 | 0/0/0 |
|  | 1000BASE-X.<br>SGMII bridge enabled. | N/A | 808 | 986 | 2/0/0 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (LVDS_IO). | N/A | 819 | 1057 | 2/0/0 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (GXB). | N/A | 1189 | 1212 | 1/0/160 |
| 10/100/1000-<br>Mbps Ethernet<br>MAC and<br>1000BASE-X/<br>SGMII PCS | All MAC options enabled.<br>SGMII bridge enabled. | 2048×32 | 3971 | 4950 | 14/1/2084 |

The following estimates are obtained by targeting the Stratix IV GX (EP4SGX530NF45C4) device with speed
grade -4.



## 1. About This IP


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
19

<!-- PDF page 20 -->

**Table 14. Resource Utilization for Triple-Speed Ethernet for Cyclone IV GX Devices**

| IP Variation | Settings | FIFO Buffer<br>Size (Bits) | Logic<br>Elements | Logic<br>Registers | Memory<br>(M9K<br>Blocks/<br>M144K<br>Blocks/<br>MLAB Bits) |
| --- | --- | --- | --- | --- | --- |
| 1000 Mbps Small<br>MAC | RGMII<br>Full-duplex only. | 2048x32 | 2161 | 1699 | 24/0/0 |
| 10/100/1000<br>Mbps Ethernet<br>MAC | MII/GMII<br>Full- and half-duplex. | 2048x32 | 5614 | 3666 | 31/0/0 |
| 1000BASE-X/<br>SGMII PCS | 1000BASE-X. | N/A | 1149 | 661 | 0/0/0 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (GXB). | N/A | 2001 | 1127 | 2/0/0 |

The following estimates are obtained by targeting the Cyclone IV GX (EP4CGX150DF27C7) device with
speed grade -7.


**Table 15. Resource Utilization for Triple-Speed Ethernet for Arria II GX Devices**

| IP Variation | Settings | FIFO Buffer<br>Size (Bits) | Combinational ALUTs | Logic<br>Registers | Memory<br>(M9K<br>Blocks/<br>M144K<br>Blocks/MLAB<br>Bits) |
| --- | --- | --- | --- | --- | --- |
| 10/100/1000<br>Mbps Ethernet<br>MAC | RGMII.<br>All MAC options enabled.<br>Full- and half-duplex. | 2048x32 | 3357 | 3947 | 26/0/1828 |
| 1000BASE-X/<br>SGMII PCS | 1000BASE-X. | N/A | 624 | 661 | 0/0/0 |
|  | 1000BASE-X.<br>SGMII bridge enabled.<br>PMA block (GXB). | N/A | 1191 | 1214 | 1/0/160 |

The following estimates are obtained by targeting the Arria II GX (EP2AGX260EF29I3) device with speed grade
-3.

## 1. About This IP


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
20

<!-- PDF page 21 -->


## 2. Getting Started with Intel FPGA IPs

Intel and strategic IP partners offer a broad portfolio of off-the-shelf, configurable IPs
optimized for Intel FPGA devices. The Intel Quartus Prime software installation
includes the Intel FPGA IP library.
For more information on how to install and use Intel FPGA IPs, refer to the
Introduction to Intel FPGA IP Cores.
Related Information
Introduction to Intel FPGA IP Cores

### 2.1. Design Walkthrough

This walkthrough explains how to create a Triple-Speed Ethernet Intel FPGA IP design
using Platform Designer in the Intel Quartus Prime software. After you generate a
custom variation of the Triple-Speed Ethernet Intel FPGA IP, you can incorporate it
into your overall project.
This walkthrough includes the following steps:

## 1. Creating a New Intel Quartus Prime Project on page 21


## 2. Generating a Design Example or Simulation Model on page 22


## 3. Simulating the System on page 22


## 4. Compiling the Triple-Speed Ethernet Intel FPGA IP Design on page 23


## 5. Programming an FPGA Device on page 23


#### 2.1.1. Creating a New Intel Quartus Prime Project

You need to create a new Intel Quartus Prime project with the New Project Wizard,
which specifies the working directory for the project, assigns the project name, and
designates the name of the top-level design entity.
To create a new project, follow these steps:

## 1. Launch the Intel Quartus Prime software on your PC. Alternatively, you can use

the Intel Quartus Prime Lite Edition software.

## 2. On the File menu, click New Project Wizard.


## 3. In the New Project Wizard: Directory, Name, Top-Level Entity page, specify

the working directory, project name, and top-level design entity name. Click Next.

## 4. In the New Project Wizard: Add Files page, select the existing design files (if

any) you want to include in the project. Click Next.

# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 22 -->

Note: To include existing files, you must specify the directory path to where you
installed the IP. You must also add the user libraries if you installed the IP
Library in a different directory from where you installed the Intel Quartus
Prime software.

## 5. In the New Project Wizard: Family & Device Settings page, select the device

family and specific device you want to target for compilation. Click Next.

## 6. In the EDA Tool Settings page, select the EDA tools you want to use with the

Intel Quartus Prime software to develop your project.

## 7. The last page in the New Project Wizard window shows the summary of your

chosen settings. Click Finish to complete the Intel Quartus Prime project creation.

#### 2.1.2. Generating a Design Example or Simulation Model

After you have parameterized the IP, you can also generate a design example, in
addition to generating the IP component files.
In the parameter editor, click Example Design to create a functional simulation
model (design example that includes a testbench). The testbench and the automated
script are located in the <variation name>_testbench directory.
Note: Generating a design example can increase processing time.
Note: Generate Example Design option only generates the design for functional
simulation.
You can now integrate your custom IP instance in your design, simulate, and compile.
While integrating your IP instance into your design, you must make appropriate pin
assignments. You can create a virtual pin to avoid making specific pin assignments for
top-level signals while you are simulating and not ready to map the design to
hardware.
Related Information
• Testbench
More information about the IP simulation model.
• Intel Quartus Prime Help
More information about the Intel Quartus Prime software, including virtual pins.

#### 2.1.3. Simulating the System

During system generation, Platform Designer generates a functional simulation model
—or design example that includes a testbench—which you can use to simulate your
system in any Intel FPGA-supported simulation tool.
Related Information
• Intel Quartus Prime Pro Edition Software and Device Support Release Notes
More information about the latest Intel FPGA-supported simulation tools.
• Intel Quartus Prime Standard Edition Software and Device Support Release Notes
More information about the latest Intel FPGA-supported simulation tools.
• Simulating Intel FPGA Designs
More information in the Intel Quartus Prime Pro Edition User Guide: Third-party
Simulation about simulating Intel FPGA IP cores.

## 2. Getting Started with Intel FPGA IPs


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
22

<!-- PDF page 23 -->

• Simulating Intel FPGA Designs
More information in the Intel Quartus Prime Standard Edition User Guide:
Third-party Simulation about simulating Intel FPGA IPs.
• System Design with Platform Designer
More information in the Intel Quartus Prime Pro Edition User Guide: Platform
Designer about simulating Platform Designer systems.
• System Design with Platform Designer (Standard)
More information in the Intel Quartus Prime Standard Edition User Guide:
Platform Designer about simulating Platform Designer (Standard) systems.

#### 2.1.4. Compiling the Triple-Speed Ethernet Intel FPGA IP Design

Refer to Design Considerations on page 166 chapter before compiling the Triple-Speed
Ethernet Intel FPGA IP design.
To compile your design, click Start Compilation on the Processing menu in the Intel
Quartus Prime software. You can use the generated .qip file to include relevant files
into your project.
Related Information
Intel Quartus Prime Help
More information about compilation in Intel Quartus Prime software.

#### 2.1.5. Programming an FPGA Device

After successfully compiling your design, program the targeted Intel FPGA device with
the Intel Quartus Prime Programmer and verify the design in hardware. For
instructions on programming the FPGA device, refer to the Device Programming
section in volume 3 of the Intel Quartus Prime Handbook.
Related Information
Device Programming

### 2.2. Generated Files

The type of files generated in your project directory and their names may vary
depending on the custom variation of the IP you created.
**Table 16. Generated Files**

| File Name | Description |
| --- | --- |
| <variation_name>.v or<br><variation_name>.vhd | An IP variation file, which defines a VHDL or Verilog HDL top-level<br>description of the custom IP. Instantiate the entity defined by this file<br>inside your design. Include this file when compiling your design in the<br>Intel Quartus Prime software. |
| <variation_name>.bsf | Intel Quartus Prime symbol file for the IP variation. You can use this file<br>in the Intel Quartus Prime block diagram editor. |
| <variation_name>.qip and<br><variation_name>.sip | Contains Intel Quartus Prime project information for your IP variations. |
| <variation_name>.cmp | A VHDL component declaration file for the IP variation. Add the contents<br>of this file to any VHDL architecture that instantiates the IP. |
| <variation_name>.spd | Simulation Package Descriptor file. Specifies the files required for<br>simulation. |
| Testbench Files (in <variation_name>_testbench folder) |  |
| README.txt | Read me file for the testbench design. |
| generate_sim.qpf and<br>generate_sim.qsf | Dummy Intel Quartus Prime project and project setting file. Use this to<br>start the Intel Quartus Prime in the correct directory to launch the<br>generate_sim_verilog.tcl and generate_sim_vhdl.tcl files. |
| generate_sim_verilog.tcl and<br>generate_sim_vhdl.tcl | A Tcl script to generate the DUT VHDL or Verilog HDL simulation model<br>for use in the testbench. |
| /testbench_vhdl/<variation_name>/<br><variation_name>_tb.vhd or<br>/testbench_verilog/<variation_name>/<br><variation_name>_tb.v | VHDL or Verilog HDL testbench that exercises your IP variation in a third<br>party simulator. |
| /testbench_vhdl/<variation_name>/run_<br><variation_name>_tb.tcl or<br>/testbench_verilog/<variation_name>/<br>run_<br><variation_name>_tb.tcl | A Tcl script for use with the ModelSim* simulation software. |
| /testbench_vhdl/<variation_name>/<br><variation_name>_wave.do or<br>/testbench_verilog/<variation_name>/<br><variation_name>_wave.do | A signal tracing macro script used with the ModelSim simulation<br>software to display testbench signals. |
| /testbench_vhdl/models or<br>/testbench_verilog/models | A directory containing VHDL and Verilog HDL models of the Ethernet<br>generators and monitors used by the generated testbench. |


## 2. Getting Started with Intel FPGA IPs


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
23

<!-- PDF page 24 -->


#### 2.2.1. Design Constraint File No Longer Generated

For a new Triple-Speed Ethernet Intel FPGA IP created using the Intel Quartus Prime
software version 13.0 or later, the software no longer generate the
<variation_name>_constraints.tcl file that contains the necessary constraints for
the compilation of your IP variation.
The following table lists the recommended Intel Quartus Prime pin assignments that
you can set in your design.
**Table 17. Recommended Intel Quartus Prime Pin Assignments**

| Pin Assignment | Assignment<br>Value | Description | Design Pin |
| --- | --- | --- | --- |
| FAST_INPUT_REGI<br>STER | ON | To optimize I/O timing for MII, GMII and<br>TBI interface. | MII, GMII, RGMII, TBI input pins. |
| FAST_OUTPUT_RE<br>GISTER | ON | To optimize I/O timing for MII, GMII and<br>TBI interface. | MII, GMII, RGMII, TBI output pins. |
| IO_STANDARD | 1.4-V PCML or<br>1.5-V PCML | I/O standard for GXB serial input and<br>output pins. | GXB transceiver serial input and output<br>pins. |
| IO_STANDARD | LVDS | I/O standard for LVDS/IO serial input<br>and output pins. | LVDS/IO transceiver serial input and<br>output pins. |
| GLOBAL_SIGNAL | Global clock | To assign clock signals to use the global<br>clock network. Use this setting to guide<br>the Intel Quartus Prime software in the<br>fitter process for better timing closure. | • clk and reset pins for MAC only<br>(without internal FIFO).<br>• clk and ref_clk input pins for MAC<br>and PCS with transceiver (without<br>internal FIFO). |
| GLOBAL_SIGNAL | Regional clock | To assign clock signals to use the<br>regional clock network. Use this setting<br>to guide the Intel Quartus Prime<br>software in the fitter process for better<br>timing closure. | • rx_clk <n> and tx_clk <n> input<br>pins for MAC only using MII/GMII<br>interface (without internal FIFO).<br>• rx_clk <n> input pin for MAC only<br>using RGMII interface (without<br>internal FIFO). |
| GLOBAL_SIGNAL | OFF | To prevent a signal to be used as a<br>global signal. | Signals for Arria V devices:<br>• *reset_ff_wr and *reset_ff_rd<br>• *\|<br>altera_tse_reset_synchronize<br>r_chain_out |


## 2. Getting Started with Intel FPGA IPs


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
24

<!-- PDF page 25 -->

• *|

## 2. Getting Started with Intel FPGA IPs


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
25

<!-- PDF page 26 -->


## 3. Parameter Settings

You customize the Triple-Speed Ethernet Intel FPGA IP by specifying parameters using
the Triple-Speed Ethernet parameter editor, launched from Platform Designer in the
Intel Quartus Prime software. The customization enables specific core features during
synthesis and generation.
This chapter describes the parameters and how they affect the behavior of the IP.
Each section corresponds to a page in the Parameter Settings tab in the parameter
editor interface.

### 3.1. Core Configuration

**Table 18. Core Configuration Parameters**

| Name | Value | Description |
| --- | --- | --- |
| Core Variation | • 10/100/1000 Mb Ethernet<br>MAC<br>• 10/100/1000 Mb Ethernet<br>MAC with 1000BASE-X/<br>SGMII PCS<br>• 10/100/1000 Mb Ethernet<br>MAC with 1000BASE-X/<br>SGMII 2XTBI PCS(2)(3)(4)<br>• 1000BASE-X/SGMII PCS<br>only | Determines the primary blocks to include in the variation. |
|  | • 1000BASE-X/SGMII 2XTBI<br>PCS only(2)(5)<br>• 1000 Mb Small MAC<br>• 10/100 Mb Small MAC |  |
| Enable ECC<br>protection | On/Off | Turn on this option to enable ECC protection for internal<br>memory blocks. |
| Interface | • MII<br>• GMII<br>• RGMII<br>• MII/GMII | Determines the Ethernet-side interface of the MAC block.<br>• MII—The only option available for 10/100 Mb Small MAC<br>core variations.<br>• GMII—Available only for 1000 Mb Small MAC core<br>variations.<br>• RGMII—Available for 10/100/1000 Mb Ethernet MAC and<br>1000 Mb Small MAC core variations.<br>• MII/GMII—Available only for 10/100/1000 Mb Ethernet<br>MAC core variations. If this is selected, media independent<br>interface (MII) is used for the 10/100 interface, and gigabit<br>media independent interface (GMII) for the gigabit<br>interface.<br>Note: 1. The RGMII interface is not supported in Intel Stratix<br>10, Intel Arria 10, and Intel Cyclone 10 GX devices<br>from Intel Quartus Prime software version 17.1<br>onwards.<br>2. For Cyclone V devices, the timing closure is subject<br>to the ability to close timing with external PHY<br>peripherals. Intel recommends –6 or –7 speed grade<br>part, and timing analysis is required to ensure that<br>the selected speed grade meets the timing closure<br>according to the external PHY peripherals<br>specification. Intel does not recommend –8 speed<br>grade part for RGMII interface. |
| Use clock enable for<br>MAC | On/Off | Turn on this option to include clock enable signals for the MAC.<br>This option is only applicable for 10/100/1000Mb Ethernet MAC<br>and 1000Mb Small MAC core variations. |
| Use internal FIFO | On/Off | Turn on this option to include internal FIFO buffers in the core.<br>You can only include internal FIFO buffers in single-port MACs. |
| Number of ports | 1, 4, 8, 12, 16, 20, and 24 | Specifies the number of Ethernet ports supported by the IP.<br>This parameter is enabled if the parameter Use internal FIFO<br>is turned off. A multiport MAC does not support internal FIFO<br>buffers.<br>Note: For Intel Quartus Prime software version 17.1 onwards,<br>the number of ports supported for Triple-Speed Ethernet<br>designs targeting Intel Stratix 10, Intel Arria 10, and<br>Intel Cyclone 10 GX devices is 8. This is applicable only<br>when you select LVDS I/O for the Transceiver type<br>option. |
| Transceiver type | • None<br>• LVDS I/O<br>• GXB<br>• FGT | This option is only available for variations that include the PCS<br>block. |
|  |  | • None—the PCS block does not include an integrated<br>transceiver module. The PCS block implements a ten-bit<br>interface (TBI) to an external SERDES chip.<br>• LVDS I/O, GXB, or FGT—the IP includes an integrated<br>transceiver module to implement a 1.25 Gbps transceiver.<br>— Respective GXB module is included for target devices<br>with GX transceivers.<br>— For target devices with LVDS I/O including Soft-CDR<br>such as Stratix III devices, the ALTLVDS module is<br>included. Starting from Intel Stratix 10, Intel Arria 10<br>and Intel Cyclone 10 GX devices, the module included is<br>changed to LVDS SERDES.<br>— GXB and LVDS I/O options are not available for Intel<br>Cyclone 10 LP devices.<br>— For Intel Stratix 10 and Intel Agilex devices, the GXB<br>option is available only in the Intel FPGA devices with E-<br>tile transceivers.<br>— For Intel Agilex devices, the FGT option is available only<br>in the Intel FPGA devices with F-tile transceivers.<br>Note: There may be a performance risk if you use the Triple-<br>Speed Ethernet Intel FPGA IP variant with LVDS I/O for<br>PMA implementation in the Intel Arria 10 devices for<br>Intel Quartus Prime software version 17.0.2 and earlier.<br>To avoid the performance risk, Intel recommends that<br>you regenerate the Triple-Speed Ethernet Intel FPGA IP<br>and recompile the design in the Intel Quartus Prime<br>software version 17.1 or later. To download and install<br>the software patch for Intel Quartus Prime version<br>17.0.2, refer to KDB link: Performance Risk Running<br>Triple Speed Ethernet LVDS in Arria 10 Devices. |

(2) This variation is only supported when you select Intel Stratix 10 devices with E-tile
transceivers or Intel Agilex devices with E-tile or F-tile transceivers in the Intel Quartus Prime
Pro Edition software.
(3) You can only turn off Use internal FIFO option for this variation when you select Intel Stratix

# 10 devices with E-tile tranceivers is selected starting from Intel Quartus Prime software

version 20.4.
(4) Embedded PMA is included and is not optional when you turn on the Use internal FIFO
option for this variation. However, the embedded PMA is excluded when you turn off Use
internal FIFO. You must manually connect the variant to the E-tile transceiver or external
PHY that supports the 2XTBI interface.

# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 27 -->





(5) Embedded PMA is excluded. You must manually connect the variant to the E-tile or external
PHY that supports 2XTBI interface.

## 3. Parameter Settings


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
27

<!-- PDF page 28 -->

Related Information
• MAC and PCS With LVDS Soft-CDR I/O on page 169

### 3.2. Ethernet MAC Options

These options are enabled when your variation includes the MAC function. In small
MACs, only the following options are available:
• Enable MAC 10/100 half duplex support (10/100 Small MAC variations)
• Align packet headers to 32-bit boundary (10/100 and 1000 Small MAC
variations)
**Table 19. MAC Options Parameters**

| Name | Value | Description |
| --- | --- | --- |
| Ethernet MAC Options |  |  |
| Enable MAC 10/100<br>half duplex support | On/Off | Turn on this option to include support for half duplex operation<br>on 10/100 Mbps connections. |
| Enable local loopback<br>on MII/GMII/RGMII | On/Off | Turn on this option to enable local loopback on the MAC’s MII,<br>GMII, or RGMII interface. If you turn on this option, the<br>loopback function can be dynamically enabled or disabled<br>during system operation via the MAC configuration register. |
| Enable supplemental<br>MAC unicast<br>addresses | On/Off | Turn on this option to include support for supplementary<br>destination MAC unicast addresses for fast hardware-based<br>received frame filtering. |
| Include statistics<br>counters | On/Off | Turn on this option to include support for simple network<br>monitoring protocol (SNMP) management information base<br>(MIB) and remote monitoring (RMON) statistics counter<br>registers for incoming and outgoing Ethernet packets.<br>By default, the width of all statistics counters are 32 bits. |
| Enable 64-bit<br>statistics byte<br>counters | On/Off | Turn on this option to extend the width of selected statistics<br>counters— aOctetsTransmittedOK, aOctetsReceivedOK,<br>and etherStatsOctets—to 64 bits. |
| Include multicast<br>hashtable | On/Off | Turn on this option to implement a hash table, a fast hardware-<br>based mechanism to detect and filter multicast destination MAC<br>address in received Ethernet packets. |
| Align packet headers<br>to 32-bit boundary | On/Off | Turn on this option to include logic that aligns all packet<br>headers to a 32-bit boundary. This helps reduce software<br>overhead processing in realignment of data buffers.<br>This option is available for MAC variations with 32 bits wide<br>internal FIFO buffers and MAC variations without internal FIFO<br>buffers.<br>You must turn on this option if you intend to use the Triple-<br>Speed Ethernet Intel FPGA IP with the Interniche TCP/IP<br>protocol stack. |
| Enable full-duplex<br>flow control | On/Off | Turn on this option to include the logic for full-duplex flow<br>control that includes pause frames generation and termination. |
| Enable VLAN<br>detection | On/Off | Turn on this option to include the logic for VLAN and stacked<br>VLAN frame detection. When turned off, the MAC does not<br>detect VLAN and staked VLAN frames. The MAC forwards these<br>frames to the user application without processing them. |
| Enable magic packet<br>detection | On/Off | Turn on this option to include logic for magic packet detection<br>(Wake-on LAN). |
| MDIO Module |  |  |
| Include MDIO<br>module (MDC/MDIO) | On/Off | Turn on this option if you want to access external PHY devices<br>connected to the MAC function. When turned off, the core does<br>not include the logic or signals associated with the MDIO<br>interface. |
| Host clock divisor | — | Clock divisor to divide the MAC control interface clock to<br>produce the MDC clock output on the MDIO interface. The<br>default value is 40.<br>For example, if the MAC control interface clock frequency is 100<br>MHz and the desired MDC clock frequency is 2.5 MHz, a host<br>clock divisor of 40 should be specified.<br>Intel recommends that the division factor is defined such that<br>the MDC frequency does not exceed 2.5 MHz. |


## 3. Parameter Settings


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
28

<!-- PDF page 29 -->


### 3.3. FIFO Options

The FIFO options are enabled only for MAC variations that include internal FIFO

## 3. Parameter Settings


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
29

<!-- PDF page 30 -->

**Table 20. FIFO Options Parameters**

| Name | Value | Parameter |
| --- | --- | --- |
| Width |  |  |
| Width | 8 Bits and 32 Bits | Determines the data width in bits of the transmit and receive<br>FIFO buffers. |
| Depth |  |  |
| Transmit | Between 64 and 64K | Determines the depth of the internal FIFO buffers. |
| Receive |  |  |


### 3.4. Timestamp Options

**Table 21. Timestamp Options Parameters**

| Name | Value | Parameter |
| --- | --- | --- |
| Timestamp |  |  |
| Enable timestamping | On/Off | Turn on this parameter to enable time stamping on the<br>transmitted and received frames. |
| Enable deterministic<br>latency for E-tile<br>device | On/Off | Turn on this parameter to enable deterministic latency<br>measurement.<br>This parameter is only supported in the Intel Stratix 10 E-tile<br>transceiver variant (10/100/1000Mb Ethernet MAC with<br>1000BASE-X/SGMII 2xTBI PCS variation operating without<br>internal FIFO, with timestamping and SGMII bridge enabled). |
| Enable PTP 1-step<br>clock | On/Off | Turn on this parameter to insert timestamp on PTP messages<br>for 1-step clock based on the TX Timestamp Insert Control<br>interface.<br>This parameter is disabled if you do not turn on Enable<br>timestamping. |
| Timestamp<br>fingerprint width | — | Use this parameter to set the width in bits for the timestamp<br>fingerprint on the TX path. The default value is 4 bits. |


### 3.5. PCS/Transceiver Options

The PCS/Transceiver options are enabled only if your IP variation includes the PCS
function.
**Table 22. PCS/Transceiver Options Parameters**

| Name | Value | Parameter |
| --- | --- | --- |
| PCS Options |  |  |
| PHY ID (32 bit) | — | Configures the PHY ID of the PCS block. |
| Enable SGMII bridge | On/Off | Turn on this option to add the SGMII clock and rate-adaptation<br>logic to the PCS block. This option allows you to configure the<br>PCS either in SGMII mode or 1000Base-X mode. If your<br>application only requires 1000BASE-X PCS, turning off this<br>option reduces resource usage.<br>In Cyclone IV GX devices, REFCLK[0,1] and REFCLK[4,5]<br>cannot connect directly to the GCLK network. If you enable the<br>SGMII bridge, you must connect ref_clk to an alternative<br>dedicated clock input pin. |
| Transceiver Options—apply only to variations that include GXB transceiver blocks |  |  |
| Export transceiver<br>powerdown signal | On/Off | This option is not supported in Stratix V, Arria V, Arria V GZ,<br>and Cyclone V devices.<br>Turn on this option to export the powerdown signal of the GX<br>transceiver to the top-level of your design. Powerdown is<br>shared among the transceivers in a quad. Therefore, turning on<br>this option in multiport Ethernet configurations maximizes<br>efficient use of transceivers within the quad.<br>Turn off this option to connect the powerdown signal internally<br>to the PCS control register interface. This connection allows the<br>host processor to control the transceiver powerdown in your<br>system. |
| Enable transceiver<br>dynamic<br>reconfiguration | On/Off | This option is always turned on in devices other than Arria GX<br>and Stratix II GX. When this option is turned on, the IP<br>includes the dynamic reconfiguration signals.<br>For designs targeting devices other than Arria V, Cyclone V,<br>Stratix V, Intel Arria 10, and Intel Cyclone 10 GX, Intel<br>recommends that you instantiate the ALTGX_RECONFIG<br>megafunction and connect the megafunction to the dynamic<br>reconfiguration signals to enable offset cancellation.<br>For Arria V, Cyclone V, and Stratix V designs, Intel<br>recommends that you instantiate the Transceiver<br>Reconfiguration Controller megafunction and connect the<br>megafunction to the dynamic reconfiguration signals to enable<br>offset cancellation. The transceivers in the Arria V, Cyclone V,<br>and Stratix V designs are configured with Intel FPGA Custom<br>PHY IP. The Custom PHY IP requires two reconfiguration<br>interfaces for external reconfiguration controller. For more<br>information on the reconfiguration interfaces required, refer to<br>the V-Series Transceiver PHY IP Core User Guide and the<br>respective device handbook.<br>For more information about quad sharing considerations, refer<br>to Sharing PLLs in Devices with GIGE PHY on page 173. |
| Starting channel<br>number | 0 – 284 | Specifies the channel number for the GXB transceiver block. In<br>a multiport MAC, this parameter specifies the channel number<br>for the first port. Subsequent channel numbers are in four<br>increments.<br>In designs with multiple instances of GXB transceiver block<br>(multiple instances of Triple-Speed Ethernet Intel FPGA IP with<br>GXB transceiver block or a combination of Triple-Speed<br>Ethernet Intel FPGA IP and other IPs), Intel recommends that<br>you set a unique starting channel number for each instance to<br>eliminate conflicts when the GXB transceiver blocks share a<br>transceiver quad.<br>This option is not supported in Arria V, Cyclone V, Stratix V,<br>Intel Arria 10, and Intel Cyclone 10 GX devices. For these<br>devices, the channel numbers depends on the dynamic<br>reconfiguration controller. |
| Series V GXB Transceiver Options |  |  |
| TX PLLs type | • CMU<br>• ATX | This option is only available for variations that include the PCS<br>block for Stratix V and Arria V GZ devices.<br>Specifies the TX phase-locked loops (PLLs) type—CMU or ATX—<br>in the GXB transceiver for Series V devices. |
| Enable SyncE<br>Support | On/Off | Turn on this option to enable SyncE support by separating the<br>TX PLL and RX PLL reference clock. |
| TX PLL clock network | • x1<br>• xN | This option is only available for variations that include the PCS<br>block for Arria V and Cyclone V devices.<br>Specifies the TX PLL clock network type. |
| Intel Arria 10 or Intel Cyclone 10 GX GXB Transceiver Options |  |  |
| Enable Intel Arria 10<br>or Intel Cyclone 10<br>GX transceiver<br>dynamic<br>reconfiguration | On/Off | Turn on this option for the IP to include the dynamic<br>reconfiguration signals. |
| Intel Stratix 10 GXB Transceiver Options |  |  |
| Enable E-tile<br>transceiver dynamic<br>reconfiguration | On/Off | Turn on this option for the IP to include the dynamic<br>reconfiguration signals. |
| Intel Stratix 10 GXB<br>PMA Adaptation | On/Off | Enables PMA adaptation parameter customization. For more<br>details about PMA adaptation parameter, refer to E-Tile<br>Transceiver PHY User Guide. |


## 3. Parameter Settings


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
30

<!-- PDF page 31 -->




## 3. Parameter Settings


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
31

<!-- PDF page 32 -->

Note: 1. You must configure the Intel Arria 10/Intel Cyclone 10 GX Transceiver ATX PLL
with an output clock frequency of 1250.0 MHz (instead of applying the default
value of 625 MHz) when using the Intel Arria 10/Intel Cyclone 10 GX Transceiver
Native PHY with the Triple-Speed Ethernet Intel FPGA IP.

## 2. The Transceiver Options and Series V GXB Transceiver Options parameters

are not available in the Triple-Speed Ethernet Intel FPGA IP parameter editor
interface of the Intel Quartus Prime Pro Edition software version 19.2 onwards.
These options are only present in the Intel Quartus Prime Standard Edition
software.
Refer to the respective device handbook for more information on dynamic
reconfiguration in Intel FPGA devices.
Related Information
More information about dynamic reconfiguration in the Intel Stratix 10 and
Intel Agilex devices.
More information about the Intel Arria 10 transceiver ATX PLL.
More information about the Intel Cyclone 10 GX transceiver ATX PLL.
• E-tile Hard IP Intel Stratix 10 Design Examples User Guide: Ethernet, CPRI PHY,
and Dynamic Reconfiguration

## 3. Parameter Settings


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
32

<!-- PDF page 33 -->


## 4. Functional Description

The Triple-Speed Ethernet Intel FPGA IP includes the following functions:
• 10/100/1000 Ethernet MAC
• 1000BASE-X/SGMII PCS With Optional Embedded PMA
• Intel FPGA IEEE 1588v2

### 4.1. 10/100/1000 Ethernet MAC

The Intel 10/100/1000 Ethernet MAC function handles the flow of data between user
applications and Ethernet network through an internal or external Ethernet PHY. Intel
offers the following MAC variations:
• Variations with internal FIFO buffers—supports only single port.
• Variations without internal FIFO buffers—supports up to 24 ports (except for Intel
Arria 10, Intel Cyclone 10 GX, and Intel Stratix 10 devices) and the ports can
operate at different speeds.
• Small MAC—provides basic functionalities of a MAC function using minimal
resources.
Refer to 10/100/1000 Ethernet MAC Versus Small MAC on page 9 for a feature
comparison between the 10/100/1000 Ethernet MAC and small MAC.
The MAC function supports the following Ethernet frames: basic, VLAN and stacked
VLAN, jumbo, and control frames.
Related Information
Ethernet Frame Format on page 214

# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 34 -->


#### 4.1.1. MAC Architecture

Figure 12. 10/100/1000 Ethernet MAC With Internal FIFO Buffers
ReceiveFIFO Buffer
TransmitFIFO Buffer
Configuration and Statistics MDIO Master
CRC Check Pause Frame Termination
MII/GMII/RGMIIReceive
LocalLoopbackReceiver Control
MII/GMII/RGMIITransmit
PHYManagementInterface
Control Interface (Avalon Memory-Mapped Interface)
Magic Packet Detection
Ethernet SideSystem Side
CRC Generation Pause Frame Generation
Transmitter ControlMAC TransmitInterface(Avalon StreamingInterface)
MAC ReceiveInterface(Avalon StreamingInterface)
10/100/1000 Ethernet MAC with Internal FIFO Buffers
The FIFO buffers, which you can configure to 8 or 32 bits wide, store the transmit and
receive data. The buffer width determines the data width on the Avalon streaming
receive and transmit interfaces. You can configure the FIFO buffers to operate in cut-
through or store-and-forward mode using the rx_section_full and
tx_section_full registers.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
34

<!-- PDF page 35 -->

Figure 13. Multiport MAC Without Internal FIFO Buffers
Configuration and Statistics
CRC CheckPause Frame Termination
Port 0 LoopbackReceiver Control
Transmitter Control
Magic Packet Detection
CRC GenerationPause Frame Generation
Port n
. . .
MDIO Master
Configuration and Statistics
CRC CheckPause Frame Termination
LoopbackReceiver Control
Transmitter Control
Magic Packet Detection
CRC GenerationPause Frame Generation
Shared Configuration
Multiport MAC (Without Internal FIFO Buffers)Ethernet Side(MII/GMII/RGMII)
System Side(Avalon StreamingInterface)
Transmit / Receive Interfaces
Transmit / Receive Interfaces
To/From External PHY
To/From External PHY
Avalon Memory-Mapped Interface
In a multiport MAC, the instances share the MDIO master and some configuration
registers. You can use the Avalon Streaming Multi-Channel Shared Memory FIFO core
in the Platform Designer to store the transmit and receive data.
Related Information
MAC Configuration Register Space on page 84

#### 4.1.2. MAC Interfaces

The MAC function implements the following interfaces:

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
35

<!-- PDF page 36 -->

• Avalon streaming interface on the system side.
— Avalon streaming sink port on transmit with the following properties:
• Fixed data width, 8 bits, in MAC variations without internal FIFO buffers;
configurable data width, 8 or 32 bits, in MAC variations with internal FIFO
buffers.
• Packet support using start-of-packet (SOP) and end-of-packet (EOP)
signals, and partial final packet signals.
• Error reporting.
• Variable-length ready latency specified by the tx_almost_full register.
— Avalon streaming source port on receive with the following properties:
• Fixed data width of 8 bits in MAC variations without internal FIFO buffers;
configurable data width, 8 or 32 bits, in MAC variations with internal FIFO
buffers.
• Backpressure is supported only in MAC variations with internal FIFO
buffers. Transmission stops when the level of the FIFO buffer reaches the
respective programmable thresholds.
• Packet support using SOP and EOP signals, and partial final packet signals.
• Error reporting.
• Ready latency is zero in MAC variations without internal FIFO buffers. In
MAC variations with internal FIFO buffers, the ready latency is two.
• Media independent interfaces on the network side—select MII, GMII, or RGMII by
setting the Interface option on the Core Configuration page or the ETH_SPEED
bit in the command_config register.
• Control interface—an Avalon memory-mapped slave port that provides access to

# 256 32-bit configuration and status registers, and statistics counters. This

interface supports the use of waitrequest to stall the interconnect fabric for as
many cycles as required.
• PHY management interface—implements the standard MDIO specification, IEEE

## 803.2 standard Clause 22, to access the PHY device management registers. This

interface supports up to 32 PHY devices.
MAC variations without internal FIFO buffers implement the following additional
interfaces:
• FIFO status interface—an Avalon streaming sink port that streams in the fill level
of an external FIFO buffer. Only MAC variations without internal buffers implement
this interface.
• Packet classification interface—an Avalon streaming source port that streams out
receive packet classification information. Only MAC variations without internal
buffers implement this interface.
Related Information
• Transmit Thresholds on page 48
• Interface Signals on page 110
• MAC Configuration Register Space on page 84
• Avalon Interface Specifications
More information about the Avalon interfaces.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
36

<!-- PDF page 37 -->


#### 4.1.3. MAC Transmit Datapath

On the transmit path, the MAC function accepts frames from a user application and
constructs Ethernet frames before forwarding them to the PHY. Depending on the MAC
configuration, the MAC function realigns the payload, modifies the source address,
calculates and appends the 32-bit Cyclic Redundancy Check (CRC-32) field, and
inserts interpacket gap (IPG) bytes. In half-duplex mode, the MAC function also
detects collision and attempts to retransmit frames when a collision occurs. The
following conditions trigger transmission:
• In MAC variations with internal FIFO buffers:
— Cut-through mode—transmission starts when the level of the FIFO level hits
the transmit section-full threshold.
— Store and forward mode—transmission starts when a full packet is received.
Note: To use the internal FIFO buffer in the store and forward mode, ensure
that the internal FIFO buffer size is larger than the transmitted packet
size. If the transmitted packet size is larger than the internal FIFO buffer
size, the Triple-Speed Ethernet Intel FPGA IP locks up with no packet
transmission. The lock-up of the IP can only be cleared through a hard
reset to the IP.
• In MAC variations without internal FIFO buffers, transmission starts as soon as
data is available on the Avalon streaming transmit interface.
Related Information
Ethernet Frame Format on page 214

##### 4.1.3.1. IP Payload Re-alignment

If you turn the Align packet headers to 32-bit boundaries option, the MAC
function removes the additional two bytes from the beginning of Ethernet frames.
Related Information
IP Payload Alignment on page 44

##### 4.1.3.2. Address Insertion

By default, the MAC function retains the source address received from the user
application. You can configure the MAC function to replace the source address with the
primary MAC address or any of the supplementary addresses by setting the
TX_ADDR_INS bit in the command_config register to 1. The TX_ADDR_SEL bits in
the command_config register determines the address selection.
Related Information
Command_Config Register (Dword Offset 0x02) on page 88

##### 4.1.3.3. Frame Payload Padding

The MAC function inserts padding bytes (0x00) when the payload length does not
meet the minimum length required:

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
37

<!-- PDF page 38 -->

• 46 bytes for basic frames
• 42 bytes for VLAN tagged frames
• 38 bytes for stacked VLAN tagged frames

##### 4.1.3.4. CRC-32 Generation

To turn on CRC-32 generation, you must set the OMIT_CRC bit in the tx_cmd_stat
register to 0 and send the frame to the MAC function with the ff_tx_crc_fwd signal
deasserted.
The following equation shows the CRC polynomial, as specified in the IEEE 802.3
standard:
FCS(X) = X 32 +X 26 +X 23 +X 22 +X 16 +X 12 +X 11 +X 10 +X 8 +X 7 +X 5 +X 4 +X 2
+X 1 +1
The 32-bit CRC value occupies the FCS field with X31 in the least significant bit of the
first byte. The CRC bits are thus transmitted in the following order: X31, X30, ..., X1,
X0.

##### 4.1.3.5. Interpacket Gap Insertion

In full-duplex mode, the MAC function maintains the minimum number of IPG
configured in the tx_ipg_length register between transmissions. You can configure
the minimum IPG to any value between 64 and 216 bit times, where 64 bit times is
the time it takes to transmit 64 bits of raw data on the medium.
In half-duplex mode, the MAC function constantly monitors the line. Transmission
starts only when the line has been idle for a period of 96 bit times and any backoff
time requirements have been satisfied. In accordance with the standard, the MAC
function begins to measure the IPG when the m_rx_crs signal is deasserted.

##### 4.1.3.6. Collision Detection in Half-Duplex Mode

Collision occurs only in a half-duplex network. It occurs when two or more nodes
transmit concurrently. The PHY device asserts the m_rx_col signal to indicate
collision.
When the MAC function detects collision during transmission, it stops the transmission
and sends a 32-bit jam pattern instead. A jam pattern is a fixed pattern, 0x648532A6,
and is not compared to the CRC of the frame. The probability of a jam pattern being
identical to the CRC is very low, 0.532%.
If the MAC function detects a collision while transmitting the preamble or start frame
delimiter (SFD) field, it sends the jam pattern only after transmitting the SFD field,
which subsequently results in a minimum of a 96-bit fragment.
If the MAC function detects a collision while transmitting the first 64 bytes, including
the preamble and SFD fields, the MAC function waits for an interval equal to the
backoff period and then retransmits the frame. The frame is stored in a 64-byte
retransmit buffer. The backoff period is generated from a pseudo-random process,
truncated binary exponential backoff.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
38

<!-- PDF page 39 -->

Figure 14. Frame Retransmission
MAC TransmitControl
MAC TransmitDatapath PHY Interface
Retransmission Block
PHY Control
LFSR
Col
Rd_en
FrameDiscard
MAC Transmit
Backoff Period
RetransmitBufferControl
64x8RetransmitBuffer
Avalon
Streaming
Interface
WAddr RAddr
The backoff time is a multiple of slot times. One slot is equal to a 512 bit times period.
The number of the delay slot times, before the Nth retransmission attempt, is chosen
as a uniformly distributed random integer (r) in the following range:

# 0 ≤ r < 2k

k = min(n, N), where n is the number of retransmissions and N = 10.
For example, after the first collision, the backoff period, in slot time, is 0 or 1. If a
collision occurs during the first retransmission, the backoff period, in slot time, is 0, 1,
2, or 3.
The maximum backoff time, in 512 bit times slots, is limited by N set to 10 as
specified in the IEEE Standard 802.3.
If a collision occurs after 16 consecutive retransmissions, the MAC function reports an
excessive collision condition by setting the EXCESS_COL bit in the command_config
register to 1, and discards the current frame from the transmit FIFO buffer.
In networks that violate standard requirements, collision may occur after the
transmission of the first 64 bytes. If this happens, the MAC function stops transmitting
the current frame, discards the rest of the frame from the transmit FIFO buffer, and
resumes transmitting the next available frame. You can check the LATE_COL register
(command_config [12]) to verify if the MAC has discarded any frame due to a
collision.

#### 4.1.4. MAC Receive Datapath

The MAC function receives Ethernet frames from the network via a PHY and forwards
the payload with relevant frame fields to the user application after performing checks,
filtering invalid frames, and removing the preamble and SFD.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
39

<!-- PDF page 40 -->


##### 4.1.4.1. Preamble Processing

The MAC function uses the SFD (0xD5) to identify the last byte of the preamble. If an
SFD is not found after the seventh byte, the MAC function rejects the frame and
discards it.
The IEEE standard specifies that frames must be separated by an interpacket gap
(IPG) of at least 96 bit times. The MAC function, however, can accept frames with an
IPG of less than 96 bit times; at least 8-bytes and 6-bytes in RGMII/GMII (1000 Mbps
operation) and RGMII/MII (10/100 Mbps operation) respectively.
The MAC function removes the preamble and SFD fields from valid frames.

##### 4.1.4.2. Collision Detection in Half-Duplex Mode

In half-duplex mode, the MAC function checks for collisions during frame reception.
When collision is detected during the reception of the first 64 bytes, the MAC function
discards the frame if the RX_ERR_DISC bit is set to 1. Otherwise, the MAC function
forwards the frame to the user application with error.

##### 4.1.4.3. Address Checking

The MAC function can accept frames with the following address types:
• Unicast address—bit 0 of the destination address is 0.
• Multicast address—bit 0 of the destination address is 1.
• Broadcast address—all 48 bits of the destination address are 1.
The MAC function always accepts broadcast frames. If promiscuous mode is
enabled (PROMIS_EN bit in the command_config register = 1), the MAC function
omits address filtering and accepts all frames.

###### 4.1.4.3.1. Unicast Address Checking

When promiscuous mode is disabled, the MAC function only accepts unicast frames if
the destination address matches any of the following addresses:
• The primary address, configured in the registers mac_0 and mac_1
• The supplementary addresses, configured in the following registers: smac_0_0/
smac_0_1, smac_1_0/smac_1_1, smac_2_0/smac_2_1 and smac_3_0/
smac_3_1
Otherwise, the MAC function discards the frame.

###### 4.1.4.3.2. Multicast Address Resolution

You can use either a software program running on the host processor or a hardware
multicast address resolution engine to resolve multicast addresses. Address resolution
using a software program can affect the system performance, especially in gigabit
mode.
The MAC function uses a 64-entry hash table in the register space, multicast hash
table, to implement the hardware multicast address resolution engine as shown in
figure below. The host processor must build the hash table according to the specified
algorithm. A 6-bit code is generated from each multicast address by XORing the

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
40

<!-- PDF page 41 -->

address bits as shown in table below. This code represents the address of an entry in
the hash table. Write one to the most significant bit in the table entry. All multicast
addresses that hash to the address of this entry are valid and accepted.
You can choose to generate the 6-bit code from all 48 bits of the destination address
by setting the MHASH_SEL bit in the command_config register to 0, or from the
lower 24 bits by setting the MHASH_SEL bit to 1. The latter option is provided if you
want to omit the manufacturer's code, which typically resides in the upper 24 bits of
the destination address, when generating the 6-bit code.
Figure 15. Hardware Multicast Address Resolution Engine
Hash
Generate
multicast_match
frame destination
address(47:0)
write_port
din
read_addr(5:0)dout
hash_addr(5:0)
hash_wren
hash_data
wclk
Look-Up Table
(64x1 DPRAM)
**Table 23. Hash Code Generation—Full Destination Address**

| Hash Code Bit | Value |
| --- | --- |
| 0 | xor multicast MAC address bits 7:0 |
| 1 | xor multicast MAC address bits 15:8 |
| 2 | xor multicast MAC address bits 23:16 |
| 3 | xor multicast MAC address bits 31:24 |
| 4 | xor multicast MAC address bits 39:32 |
| 5 | xor multicast MAC address bits 47:40 |

Algorithm for generating the 6-bit code from the entire destination address.












**Table 24. Hash Code Generation—Lower 24 Bits of Destination Address**

| Hash Code Bit | Value |
| --- | --- |
| 0 | xor multicast MAC address bits 3:0 |
| 1 | xor multicast MAC address bits 7:4 |
| 2 | xor multicast MAC address bits 11:8 |
| 3 | xor multicast MAC address bits 15:12 |
| 4 | xor multicast MAC address bits 19:16 |
| 5 | xor multicast MAC address bits 23:20 |

Algorithm for generating the 6-bit code from the lower 24 bits of the destination address.







## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
41

<!-- PDF page 42 -->







The MAC function checks each multicast address received against the hash table,
which serves as a fast matching engine, and a match is returned within one clock
cycle. If there is no match, the MAC function discards the frame.
All multicast frames are accepted if all entries in the hash table are one.
Note: 1. All entries in the hash table must be filled.

## 2. RX_ENA needs to be set to '0' prior to filling the hash table.

Failure to follow notes (1) and (2) can result in error during multicast packet
detection.

##### 4.1.4.4. Frame Type Validation

The MAC function checks the length/type field to determine the frame type:
• Length/type < 0x600—the field represents the payload length of a basic Ethernet
frame. The MAC function continues to check the frame and payload lengths.
• Length/type >= 0x600—the field represents the frame type.
— Length/type = 0x8100—VLAN or stacked VLAN tagged frames. The MAC
function continues to check the frame and payload lengths, and asserts the
following signals:
• for VLAN frames, rx_err_stat[16] in MAC variations with internal FIFO
buffers or pkt_class_data[1] in MAC variations without internal FIFO
buffers
• for stacked VLAN frames, rx_err_stat[17] in MAC variations with
internal FIFO buffers or pkt_class_data[0] in MAC variations without
internal FIFO buffers.
— Length/type = 0x8088—control frames. The next two bytes, the Opcode field,
indicate the type of control frame.
• For pause frames (Opcode = 0x0001), the MAC function continues to
check the frame and payload lengths. For valid pause frames, the MAC
function proceeds with pause frame processing. The MAC function
forwards pause frames to the user application only when the PAUSE_FWD
bit in the command_config register is set to 1.
• For other types of control frames, the MAC function accepts the frames
and forwards them to the user application only when the CNTL_FRM_ENA
bit in the command_config register is set to 1.
• For other field values, the MAC function forwards the receive frame to the user
application.
Related Information
Remote Device Congestion on page 50

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
42

<!-- PDF page 43 -->


##### 4.1.4.5. Payload Pad Removal

You can turn on padding removal by setting the PAD_EN bit in the command_config
register to 1. The MAC function removes the padding, prior to forwarding the frames
to the user application, when the payload length is less than the following values for
the different frame types:
• 46 bytes for basic MAC frames
• 42 bytes for VLAN tagged frames
• 38 bytes for stacked VLAN tagged frames
Padding removal is not applicable when:
• the length or type field is equal to or greater than 1536 (0x600) for basic frame.
• the client length or type field is equal to or greater than 1536 (0x600) for VLAN
and stacked VLAN frames.
When padding removal is turned off, complete frames including the padding are
forwarded to the Avalon streaming receive interface.

##### 4.1.4.6. CRC Checking

The following equation shows the CRC polynomial, as specified in the IEEE 802.3
standard:
FCS(X) = X 32 +X 26 +X 23 +X 22 +X 16 +X 12 +X 11 +X 10 +X 8 +X 7 +X 5 +X 4 +X 2
+X 1 +1
The 32-bit CRC value occupies the FCS field with X31 in the least significant bit of the
first byte. The CRC bits are thus received in the following order: X31, X30,..., X1, X0.
If the MAC function detects CRC-32 error, it marks the frame invalid by asserting the
following signals:
• rx_err[2] in MAC variations with internal FIFO buffers.
• data_rx_error[1] in MAC variations without internal FIFO buffers.
The MAC function discards frames with CRC-32 error if the RX_ERR_DISC bit in the
command_config register is set to 1.
For frames less than the required minimum length, the MAC function forwards the
CRC-32 field to the user application if the CRC_FWD and PAD_EN bits in the
command_config register are 1 and 0 respectively. Otherwise, the CRC-32 field is
removed from the frame.

##### 4.1.4.7. Length Checking

The MAC function checks the frame and payload lengths of basic, VLAN, and stacked
VLAN tagged frames. The jumbo frame does not go through the length check.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
43

<!-- PDF page 44 -->

The frame length must be at least 64 (0x40) bytes and not exceed the following
maximum value for the different frame types:
• Basic frames—the value specified in the frm_length register
• VLAN tagged frames—the value specified in the frm_length register plus four
• Stacked VLAN tagged frames—the value specified in the frm_length register plus
eight
To prevent FIFO buffer overflow, the MAC function truncates the frame if it is more
than 11 bytes longer than the allowed maximum length.
For frames of a valid length, the MAC function continues to check the payload length if
the NO_LGTH_CHECK bit in the command_config register is set to 0. The MAC
function keeps track of the payload length as it receives a frame, and checks the
length against the length/type field in basic MAC frames or the client length/type field
in VLAN tagged frames. The payload length is valid if it satisfies the following
conditions:
• The actual payload length matches the value in the length/type or client length/
type field.
• Basic frames—the payload length is between 46 (0x2E)and 1536 (0x0600) bytes,
excluding 1536.
• VLAN tagged frames—the payload length is between 42 (0x2A)and 1536
(0x0600), excluding 1536.
• Stacked VLAN tagged frames—the payload length is between 38 (0x26) and 1536
(0x0600), excluding 1536.
If the frame or payload length is not valid, the MAC function asserts one of the
following signals to indicate length error:
• rx_err[1] in MACs with internal FIFO buffers.
• data_rx_error[0] in MACs without internal FIFO buffers.

##### 4.1.4.8. Frame Writing

The IP removes the preamble and SFD fields from the frame. The CRC field and
padding bytes may be removed depending on the configuration.
For MAC variations with internal FIFO buffers, the MAC function writes the frame to
the internal receive FIFO buffers. For MAC variations without internal FIFO buffers, it
forwards the frame to the Avalon streaming receive interface.
MAC variations without internal FIFO buffers do not support backpressure on the
Avalon streaming receive interface. In this variation, if the receiving component is not
ready to receive data from the MAC function, the frame gets truncated with error and
subsequent frames are also dropped with error.

##### 4.1.4.9. IP Payload Alignment

The network stack makes frequent use of the IP addresses stored in Ethernet frames.
When you turn on the Align packet headers to 32-bit boundaries option, the MAC
function aligns the IP payload on a 32-bit boundary by adding two bytes to the
beginning of Ethernet frames. The padding of Ethernet frames are determined by the
registers tx_cmd_stat and rx_cmd_stat on transmit and receive, respectively.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
44

<!-- PDF page 45 -->

**Table 25. 32-Bit Interface Data Structure — Non-IP Aligned Ethernet Frame**

| Bits | Column 2 | Column 3 | Column 4 |
| --- | --- | --- | --- |
| 31...24 | 23...16 | 15...8 | 7...0 |
| Byte 0 | Byte 1 | Byte 2 | Byte 3 |
| Byte 4 | Byte 5 | Byte 6 | Byte 7 |

**Table 26. 32-Bit Interface Data Structure — IP Aligned Ethernet Frame**

| Bits | Column 2 | Column 3 | Column 4 |
| --- | --- | --- | --- |
| 31...24 | 23...16 | 15...8 | 7...0 |
| padded with zeros |  | Byte 0 | Byte 1 |
| Byte 2 | Byte 3 | Byte 4 | Byte 5 |


#### 4.1.5. MAC Transmit and Receive Latencies

Intel uses the following definitions for the transmit and receive latencies:
• Transmit latency is the number of clock cycles the MAC function takes to transmit
the first bit on the network-side interface (MII/GMII/RGMII) after the bit was first
available on the Avalon streaming interface.
• Receive latency is the number of clock cycles the MAC function takes to present
the first bit on the Avalon streaming interface after the bit was received on the
network-side interface (MII/GMII/RGMII).
**Table 27. Transmit and Receive Nominal Latency**

| MAC Configuration | Latency (Clock Cycles) (6)<br>(7) | Column 3 |
| --- | --- | --- |
|  | Transmit | Receive |
| MAC with Internal FIFO Buffers (8) |  |  |
| GMII in gigabit and cut-through mode | 38 | 99 |
| MII in 100M and cut-through mode | 40 | 184 |
| MII in 10M and cut-through mode | 34 | 183 |
| RGMII in gigabit and cut-through mode | 40 | 102 |
| RGMII in 10 Mbps and cut-through mode | 41 | 187 |
| RGMII in 100 Mbps and cut-through mode | 36 | 186 |
| MAC without Internal FIFO Buffers (9) |  |  |
|  | Transmit | Receive |
| GMII | 15 | 28 |
| MII | 26 | 56 |
| RGMII in gigabit mode | 16 | 31 |
| RGMII in10/100 Mbps | 27 | 59 |

The transmit and receive nominal latencies in various modes. The FIFO buffer thresholds are set to the typical
values specified in this user guide when deriving the latencies. Under MAC Options tab, only the following
options are selected when deriving the latencies shown in the table below: Enable MAC 10/100 half duplex
support, Include statistics counters, and Enable magic packet detection.
(6) The clocks in all domains are running at the same frequency.
(7) The numbers in this table are from simulation.
(8) The data width is set to 32 bits

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
45

<!-- PDF page 46 -->

Related Information
Base Configuration Registers (Dword Offset 0x00 – 0x17) on page 85

#### 4.1.6. FIFO Buffer Thresholds

For MAC variations with internal FIFO buffers, you can change the operations of the
FIFO buffers, and manage potential FIFO buffer overflow or underflow by configuring
the following thresholds:
• Almost empty
• Almost full
• Section empty
• Section full
These thresholds are defined in bytes for 8-bit wide FIFO buffers and in words for 32-
bit wide FIFO buffers. The FIFO buffer thresholds are configured via the registers.
(6) The clocks in all domains are running at the same frequency.
(7) The numbers in this table are from simulation.
(9) The data width is set to 8 bits.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
46

<!-- PDF page 47 -->


##### 4.1.6.1. Receive Thresholds

Figure 16. Receive FIFO Thresholds
Network
Switch Fabric
Frame Buffer n
Frame Buffer n - 1
Frame Buffer k
Frame Buffer 2
Frame Buffer 1
The remainingunwritten entries inthe FIFO bufferbefore it is full. Almost full
The remainingunread entries inthe FIFO bufferbefore it is empty.
Almost empty
An early indicationthat the FIFObuffer is gettingfull.
Section Empty
Sufficient unreadentries in the FIFObuffer for the userapplication to startreading from it.
Section full
**Table 28. Receive Thresholds**

| Threshold | Register Name | Description |
| --- | --- | --- |
| Almost empty | rx_almost_empty | The number of unread entries in the FIFO<br>buffer before the buffer is empty. When<br>the level of the FIFO buffer reaches this<br>threshold, the MAC function asserts the<br>ff_rx_a_empty signal. The MAC function<br>stops reading from the FIFO buffer and<br>subsequently stops transferring data to<br>the user application to avoid buffer<br>underflow.<br>When the MAC function detects an EOP, it<br>transfers all data to the user application<br>even if the number of unread entries is<br>below this threshold. |
| Almost full | rx_almost_full | The number of unwritten entries in the<br>FIFO buffer before the buffer is full. When<br>the level of the FIFO buffer reaches this<br>threshold, the MAC function asserts the<br>ff_rx_a_full signal. If the user<br>application is not ready to receive data<br>(ff_rx_rdy = 0), the MAC function<br>performs the following operations:<br>• Stops writing data to the FIFO buffer.<br>• Truncates received frames to avoid<br>FIFO buffer overflow.<br>• Asserts the rx_err[0] signal when<br>the ff_rx_eop signal is asserted.<br>• Marks the truncated frame invalid by<br>setting the rx_err[3] signal to 1.<br>If the RX_ERR_DISC bit in the<br>command_config register is set to 1 and<br>the section-full (rx_section_full) |
|  |  | threshold is set to 0, the MAC function<br>discards frames with error received on the<br>Avalon streaming interface. |
| Section empty | rx_section_empty | An early indication that the FIFO buffer is<br>getting full. When the level of the FIFO<br>buffer hits this threshold, the MAC<br>function generates an XOFF pause frame<br>to indicate FIFO congestion to the remote<br>Ethernet device. When the FIFO level goes<br>below this threshold, the MAC function<br>generates an XON pause frame to indicate<br>its readiness to receive new frames. To<br>avoid data loss, you can use this<br>threshold as an early warning to the<br>remote Ethernet device on the potential<br>FIFO buffer congestion before the buffer<br>level hits the almost-full threshold. The<br>MAC function truncates receive frames<br>when the buffer level hits the almost-full<br>threshold. |
| Section full | rx_section_full | The section-full threshold indicates that<br>there are sufficient entries in the FIFO<br>buffer for the user application to start<br>reading from it. The MAC function asserts<br>the ff_rx_dsav signal when the buffer<br>level hits this threshold.<br>Set this threshold to 0 to enable store and<br>forward on the receive datapath. In the<br>store and forward mode, the ff_rx_dsav<br>signal remains deasserted. The MAC<br>function asserts the ff_rx_dval signal<br>as soon as a complete frame is written to<br>the FIFO buffer. |


## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
47

<!-- PDF page 48 -->


##### 4.1.6.2. Transmit Thresholds

Figure 17. Transmit FIFO Thresholds
Network
Switch Fabric
Frame Buffer n
Frame Buffer n - 1
Frame Buffer k
Frame Buffer 1
The remainingunwritten entries inthe FIFO bufferbefore it is full. Almost full
The remainingunread entries inthe FIFO bufferbefore it is empty.
An early indicationthat the FIFObuffer is gettingfull.
Sufficient unreadentries in the FIFObuffer for the transmitter to starttransmission.
Frame Buffer 2

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
48

<!-- PDF page 49 -->

**Table 29. Transmit Thresholds**

| Threshold | Register Name | Description |
| --- | --- | --- |
| Almost empty | tx_almost_empty | The number of unread entries in the FIFO<br>buffer before the buffer is empty. When<br>the level of the FIFO buffer reaches this<br>threshold, the MAC function asserts the<br>ff_tx_a_empty signal. The MAC function<br>stops reading from the FIFO buffer and<br>sends the Ethernet frame with GMII/MII/<br>RGMII error to avoid FIFO underflow. |
| Almost full | tx_almost_full | The number of unwritten entries in the<br>FIFO buffer before the buffer is full. When<br>the level of the FIFO buffer reaches this<br>threshold, the MAC function asserts the<br>ff_tx_a_full signal. The MAC function<br>deasserts the ff_tx_rdy signal to<br>backpressure the Avalon streaming<br>transmit interface. |
| Section empty | tx_section_empty | An early indication that the FIFO buffer is<br>getting full. When the level of the FIFO<br>buffer reaches this threshold, the MAC<br>function deasserts the ff_tx_septy<br>signal. This threshold can serve as a<br>warning about potential FIFO buffer<br>congestion. |
| Section full | tx_section_full | This threshold indicates that there are<br>sufficient entries in the FIFO buffer to<br>start frame transmission.<br>Set this threshold to 0 to enable store and<br>forward on the transmit path. When you<br>enable the store and forward mode, the<br>MAC function forwards each frame as<br>soon as it is completely written to the<br>transmit FIFO buffer. |


##### 4.1.6.3. Transmit FIFO Buffer Underflow

If the transmit FIFO buffer hits the almost-empty threshold during transmission and
the FIFO buffer does not contain the end-of-packet indication, the MAC function stops
reading data from the FIFO buffer and initiates the following actions:

## 1. The MAC function asserts the RGMII/GMII/MII error signals (tx_control/

gm_tx_err/m_tx_err) to indicate that the fragment transferred is not valid.

## 2. The MAC function deasserts the RGMII/GMII/MII transmit enable signals

(tx_control/gm_tx_en/m_tx_en) to terminate the frame transmission.

## 3. After the underflow, the user application completes the frame transmission.


## 4. The transmitter control discards any new data in the FIFO buffer until the end of

frame is reached.

## 5. The MAC function starts to transfer data on the RGMII/GMII/MII when the user

application sends a new frame with an SOP.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
49

<!-- PDF page 50 -->

Figure 18. Transmit FIFO Buffer Underflow
Figure illustrates the FIFO buffer underflow protection algorithm for gigabit Ethernet system.
[1] [2] [5]
[3] [4]
ff_tx_data
ff_tx_sop
ff_tx_eop
ff_tx_rdy
ff_tx_wren
ff_tx_crc_fwd
ff_tx_err
ff_tx_septy
ff_tx_uflow
ff_tx_a_full
ff_tx_a_empty
gm_tx_err
gm_tx_en
gm_tx_d
GMII Transmit
Transmit FIFO
valid valid
valid valid

#### 4.1.7. Congestion and Flow Control

In full-duplex mode, the MAC function implements flow control to manage the
following types of congestion:
• Remote device congestion—the receiving device experiences congestion and
requests the MAC function to stop sending data.
• Receive FIFO buffer congestion—when the receive FIFO buffer is almost full, the
MAC function sends a pause frame to the remote device requesting the remote
device to stop sending data.
• Local device congestion—any device connected to the MAC function, such as a
processor, can request the remote device to stop data transmission.
Related Information
MAC Configuration Register Space on page 84

##### 4.1.7.1. Remote Device Congestion

When the MAC function receives an XOFF pause frame and the PAUSE_IGNORE bit in
the command_config register is set to 0, the MAC function completes the transfer of
the current frame and stops transmission for the amount of time specified by the
pause quanta in 512 bit times increments. Transmission resumes when the timer
expires or when the MAC function receives an XON frame.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
50

<!-- PDF page 51 -->

You can configure the MAC function to ignore pause frames by setting the
PAUSE_IGNORE bit in the command_config register is set to 1.

##### 4.1.7.2. Receive FIFO Buffer and Local Device Congestion

Pause frames generated are compliant to the IEEE Standard 802.3 annex 31A & B.
The MAC function generates pause frames when the level of the receive FIFO buffer
hits a level that can potentially cause an overflow, or at the request of the user
application. The user application can trigger the generation of an XOFF pause frame by
setting the XOFF_GEN bit in the command_config register to 1 or asserting the
xoff_gen signal.
For MAC variations with internal FIFO buffers, the MAC function generates an XOFF
pause frame when the level of the FIFO buffer reaches the section-empty threshold
(rx_section_empty). If transmission is in progress, the MAC function waits for the
transmission to complete before generating the pause frame. The fill level of an
external FIFO buffer is obtained via the Avalon streaming receive FIFO status
interface.
When generating a pause frame, the MAC function fills the pause quanta bytes P1 and
P2 with the value configured in the pause_quant register. The source address is set
to the primary MAC address configured in the mac_0 and mac_1 registers, and the
destination address is set to a fixed multicast address, 01-80-C2-00-00-01
(0x010000c28001).
The MAC function automatically generates an XON pause frame when the FIFO buffer
section-empty flag is deasserted and the current frame transmission is completed. The
user application can trigger the generation of an XON pause frame by clearing the
XOFF_GEN bit and signal, and subsequently setting the XON_GEN bit to 1 or asserting
the xon_gen signal.
When generating an XON pause frame, the MAC function fills the pause quanta
(payload bytes P1 and P2) with 0x0000 (zero quanta). The source address is set to
the primary MAC address configured in the mac_0 and mac_1 registers and the
destination address is set to a fixed multicast address, 01-80-C2-00-00-01
(0x010000c28001).
In addition to the flow control mechanism, the MAC function prevents an overflow by
truncating excess frames. The status bit, rx_err[3], is set to 1 to indicate such
errors. The user application should subsequently discard these frames by setting the
RX_ERR_DISC bit in the command_config register to 1.

#### 4.1.8. Magic Packets

A magic packet can be a unicast, multicast, or broadcast packet which carries a
defined sequence in the payload section. Magic packets are received and acted upon
only under specific conditions, typically in power-down mode.
The defined sequence is a stream of six consecutive 0xFF bytes followed by a
sequence of 16 consecutive unicast MAC addresses. The unicast address is the
address of the node to be awakened.
The sequence can be located anywhere in the magic packet payload and the magic
packet is formed with a standard Ethernet header, optional padding and CRC.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
51

<!-- PDF page 52 -->


##### 4.1.8.1. Sleep Mode

You can only put a node to sleep (set SLEEP bit in the command_config register to 1
and deassert the magic_sleep_n signal) if magic packet detection is enabled (set
the MAGIC_ENA bit in the command_config register to 1).
Intel recommends that you do not put a node to sleep if you disable magic packet
detection.
Network transmission is disabled when a node is put to sleep. The receiver remains
enabled, but it ignores all traffic from the line except magic packets to allow a remote
agent to wake up the node. In the sleep mode, only etherStatsPkts and
etherStatsOctets count the traffic statistics.

##### 4.1.8.2. Magic Packet Detection

Magic packet detection wakes up a node that was put to sleep. The MAC function
detects magic packets with any of the following destination addresses:
• Any multicast address
• A broadcast address
• The primary MAC address configured in the mac_0 and mac_1 registers
• Any of the supplementary MAC addresses configured in the following registers if
they are enabled: smac_0_0, smac_0_1, smac_1_0, smac_1_1, smac_2_0,
smac_2_1, smac_3_0 and smac_3_1
When the MAC function detects a magic packet, the WAKEUP bit in the
command_config register is set to 1, and the etherStatsPkts and
etherStatsOctets statistics registers are incremented.
Magic packet detection is disabled when the SLEEP bit in the command_config
register is set to 0. Setting the SLEEP bit to 0 also resets the WAKEUP bit to 0 and
resumes the transmit and receive operations.

#### 4.1.9. MAC Local Loopback

You can enable local loopback on the MII/GMII/RGMII of the MAC function to exercise
the transmit and receive paths. If you enable local loopback, use the same clock
source for both the transmit and receive clocks. If you use different clock sources,
ensure that the difference between the transmit and receive clocks is less than ±100
ppm.
To enable local loopback:

## 1. Initiate software reset by setting the SW_RESET bit in command_config register

to 1.
Software reset disables the transmit and receive operations, flushes the internal
FIFOs, and clears the statistics counters. The SW_RESET bit is automatically
cleared upon completion.

## 2. When software reset is complete, enable local loopback on the MAC's MII/GMII/

RGMII by setting the LOOP_ENA bit in command_config register to 1.

## 3. Enable transmit and receive operations by setting the TX_ENA and RX_ENA bits in

command_config register to 1.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
52

<!-- PDF page 53 -->


## 4. Initiate frame transmission.


## 5. Compare the statistics counters aFramesTransmittedOK and

aFramesReceivedOK to verify that the transmit and receive frame counts are
equal.

## 6. Check the statistics counters ifInErrors and ifOutErrors to determine the

number of packets transmitted and received with errors.

## 7. To disable loopback, initiate a software reset and set the LOOP_ENA bit in

command_config register to 0.

#### 4.1.10. MAC Error Correction Code (ECC)

The error correction code (ECC) feature is implemented to the memory instances in
the IP. This feature is capable of detecting single and double bit errors, and can fix
single bit errors in the corrupted data.
Note: This feature is only applicable for Arria V GZ, Stratix V, and Intel Arria 10 devices.
**Table 30. IP Variation and ECC Protection Support**

| IP Variation | ECC Protection Support |
| --- | --- |
| 10/100/1000 Mb Ethernet MAC | Protects the following options:<br>• Transmit and receive FIFO buffer<br>• Retransmit buffer (if half duplex is enabled)<br>• Statistic counters (if enabled)<br>• Multicast hashtable (if enabled) |
| 10/100/1000 Mb Ethernet MAC with 1000BASE-X/SGMII<br>PCS | Protects the following options:<br>• Transmit and receive FIFO buffer<br>• Retransmit buffer (if half duplex is enabled)<br>• Statistic counters (if enabled)<br>• Multicast hashtable (if enabled)<br>• SGMII bridge (if enabled) |
| 1000BASE-X/SGMII PCS only | Protects the SGMII bridge (if enabled). |
| 1000 Mb Small MAC | Protects the transmit and receive FIFO buffer. |
| 10/100 Mb Small MAC | Protects the following options:<br>• Transmit and receive FIFO buffer<br>• Retransmit buffer (if half duplex is enabled) |



When you enable this feature, the following output ports are added for
10/100/1000 Mb Ethernet MAC and 1000BASE-X/SGMII PCS variants to provide ECC
status of all the memory instances in the IP.
• Single channel core configuration—eccstatus[1:0] output ports.
• Multi-channel core configuration—eccstatus_<n>[1:0] output ports, where
eccstatus_0[1:0] is for channel 0, eccstatus_1[1:0] for channel 1, and so on.

#### 4.1.11. MAC Reset

A hardware reset resets all logic. A software reset only disables the transmit and
receive paths, clears all statistics registers, and flushes the receive FIFO buffer. The
values of configuration registers, such as the MAC address and thresholds of the FIFO
buffers, are preserved during a software reset.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
53

<!-- PDF page 54 -->

When you trigger a software reset, the MAC function sets the TX_ENA and RX_ENA
bits in the command_config register to 0 to disable the transmit and receive paths.
However, the transmit and receive paths are only disabled when the current frame
transmission and reception complete.
• To trigger a hardware reset, assert the reset signal.
• To trigger a software reset, set the SW_RESET bit in the command_config
register to 1. The SW_RESET bit is cleared automatically when the software reset
ends.
Intel recommends that you perform a software reset and wait for the software reset
sequence to complete before changing the MAC operating speed and mode (full/half
duplex). If you want to change the operating speed or mode without changing other
configurations, preserve the command_config register before performing the
software reset and restore the register after the changing the MAC operating speed or
mode.
Figure 19. Software Reset Sequence
Receive Frames Transmit Frames
Flush FIFO
Clear Statistics Counters
Yes Yes
Yes
No
No No Yes
No
Yes
No
RX_ENA = 0TX _ENA = 0
START
(SW_RESET = 1)
END
(SW_RESET = 0)
Frame
Reception
Completed?
Frame
Transmission
Completed?
MAC with
internal FIFO?
Receive
FIFO empty?
Statistics
Counters
Enabled?
Note: If the SW_RESET bit is 1 when the line clocks are not available (for example, cable is
disconnected), the statistics registers may not be cleared.

#### 4.1.12. PHY Management (MDIO)

This module implements the standard MDIO specification, IEEE 803.2 standard Clause
22, to access the PHY device management registers, and supports up to 32 PHY
devices.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
54

<!-- PDF page 55 -->

To access each PHY device, write the PHY address to the MDIO register
(mdio_addr0/1) followed by the transaction data (MDIO Space 0/1). For faster
access, the MAC function allows up to two PHY devices to be mapped in its register
space at any one time. Subsequent transactions to the same PHYs do not require
writing the PHY addresses to the register space thus reducing the transaction
overhead. You can access the MDIO registers via the Avalon memory-mapped
interface.
For more information about the registers of a PHY device, refer to the specification
provided with the device.
For more information about the MDIO registers, refer to the MAC Configuration
Register Space section.
Related Information
MAC Configuration Register Space on page 84

##### 4.1.12.1. MDIO Connection

Figure 20. MDIO Interface
PHY Addr
MDIO Frame Generation and Decoding
MDIO Interfacemdc
mdio_in
mdio_out
mdio_oen
PHY AddrPHY Management Registers
MDIO FrameGeneration &Decoding
mdio
mdc
addr
PHY Management Registers
MDIO FrameGeneration &Decoding
mdio
mdc
addr
Avalon Memory-Mapped
Control
Interface
10/100/1000 Ethernet MAC

##### 4.1.12.2. MDIO Frame Format

The MDIO master communicates with the slave PHY device using MDIO frames. A
complete frame is 64 bits long and consists of 32-bit preamble, 14-bit command, 2-bit
bus direction change, and 16-bit data. Each bit is transferred on the rising edge of the
MDIO clock, mdc.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
55

<!-- PDF page 56 -->

**Table 31. MDIO Frame Formats (Read/Write)**

| Type | PRE | Command | Column 4 | Column 5 | Column 6 | Column 7 | Column 8 | Column 9 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  |  | ST<br>MSB LSB | OP<br>MSB LSB | Addr1<br>MSB LSB | Addr2<br>MSB LSB | TA | Data<br>MSB LSB | Idle |
| Read | 1 ...<br>1 | 01 | 10 | xxxxx | xxxxx | Z0 | xxxxxxxxxxxxxxxx | Z |
| Write | 1 ...<br>1 | 01 | 01 | xxxxx | xxxxx | 10 | xxxxxxxxxxxxxxxx | Z |

Field settings for MDIO transactions.




**Table 32. MDIO Frame Field Descriptions**

| Name | Description |
| --- | --- |
| PRE | Preamble. 32 bits of logical 1 sent prior to every transaction. |
| ST | Start indication. Standard MDIO (Clause 22): 0b01. |
| OP | Opcode. Defines the transaction type. |
| Addr1 | The PHY device address (PHYAD). Up to 32 devices can be addressed. For PHY<br>device 0, the Addr1 field is set to the value configured in the mdio_addr0<br>register. For PHY device 1, the Addr1 field is set to the value configured in the<br>mdio_addr1 register. |
| Addr2 | Register Address. Each PHY can have up to 32 registers. |
| TA | Turnaround time. Two bit times are reserved for read operations to switch the<br>data bus from write to read for read operations. The PHY device presents its<br>register contents in the data phase and drives the bus from the 2nd bit of the<br>turnaround phase. |
| Data | 16-bit data written to or read from the PHY device. |
| Idle | Between frames, the MDIO data signal is tri-stated. |


#### 4.1.13. Connecting MAC to External PHYs

The MAC function implements a flexible network interface—MII for 10/100-Mbps
interfaces, RGMII or GMII for 1000-Mbps interfaces—that you can use in multiple
applications. This section provides the guidelines for implementing the following
network applications:
• Gigabit Ethernet operation
• Programmable 10/100 Ethernet operation
• Programmable 10/100/1000 Ethernet operation

##### 4.1.13.1. Gigabit Ethernet

You can connect gigabit Ethernet PHYs to the MAC function via GMII or RGMII. On the
receive path, connect the 125-MHz clock provided by the PHY device to the MAC clock,
rx_clk. On transmit, drive a 125-MHz clock to the PHY GMII or RGMII. Connect a
125-MHz clock source to the MAC transmit clock, tx_clk.
A technology specific clock driver is required to generate a clock centered with the
GMII or RGMII data from the MAC. The clock driver can be a PLL, a delay line or a
DDR flip-flop.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
56

<!-- PDF page 57 -->

Figure 21. Gigabit PHY to MAC via GMII
Unused
FPGA Device
ena_10eth_mode
set_10
set_1000
tx_clk
m_tx_d(3:0)m_tx_en
m_tx_err
gm_tx_d(7:0)gm_tx_engm_tx_err
rx_clk
m_rx_d(3:0) m_rx_en
gm_rx_d(7:0)gm_rx_dvgm_rx_err
m_rx_err
Reference Clock

# 125 MHz

Vcc
gtx_clk
tx_entx_err
rx_clk
rx_dv
rx_err
txd(7:0)
rxd(7:0)
10/100/1000
Ethernet
MAC
Gigabit
PHY
clk_in/xtali

##### 4.1.13.2. Programmable 10/100 Ethernet

Connect 10/100 Ethernet PHYs to the MAC function via MII. On the receive path,
connect the 25-MHz (100 Mbps) or 2.5-MHz (10 Mbps) clock provided by the PHY
device to the MAC clock, rx_clk. On the transmit path, connect the 25 MHz (100
Mbps) or a 2.5 MHz (10 Mbps) clock provided by the PHY to the MAC clock, tx_clk.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
57

<!-- PDF page 58 -->

Figure 22. 10/100 PHY Interface
Unused
FPGA Device
Optional tie to 0 if not used
Reference Clock25Mhz
ena_10
eth_mode
set_10
set_1000
tx_clk
m_tx_d(3:0)
m_tx_en
m_tx_err
gm_tx_d(7:0)
gm_tx_en
gm_tx_err
rx_clk
m_rx_d(3:0)
m_rx_en
gm_rx_d(7:0)
gm_rx_dv
gm_rx_err
m_rx_err
tx_clk
txd(3:0)
tx_en
tx_err
clk_in/xtali
rx_clk
rxd(3:0)
rx_dv
rx_err
m_rx_colm_rx_crs
m_rx_col
m_rx_crs
10/100/1000
Ethernet
MAC
10/100
PHY

##### 4.1.13.3. Programmable 10/100/1000 Ethernet Operation

Typically, 10/100/1000 Ethernet PHY devices implement a shared interface that you
connect to a 10/100-Mbps MAC via MII/RGMII or to a gigabit MAC via GMII/RGMII.
On the receive path, connect the clock provided by the PHY device (2.5 MHz, 25 MHz
or 125 MHz) to the MAC clock, rx_clk. The PHY interface is connected to both the
MII (active PHY signals) and GMII of the MAC function.
On the transmit path, standard programmable PHY devices operating in 10/100 mode
generate a 2.5 MHz (10 Mbps) or a 25 MHz (100 Mbps) clock. In gigabit mode, the
PHY device expects a 125-MHz clock from the MAC function. Because the MAC function
does not generate a clock output, an external clock module is introduced to drive the

# 125 MHz clock to the MAC function and PHY devices. In 10/100 mode, the clock

generated by the MAC to the PHY can be tri-stated.
During transmission, the MAC control signal eth_mode selects either MII or GMII. The
MAC function asserts the eth_mode signal when the MAC function operates in gigabit
mode, which subsequently drives the MAC GMII to the PHY interface. The eth_mode
signal is deasserted when the MAC function operates in 10/100 mode. In this mode,
the MAC MII is driven to the PHY interface.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
58

<!-- PDF page 59 -->

Figure 23. 10/100/1000 PHY Interface via MII/GMII
FPGA Device
x5
Unused
eth_mode
set_1000
set_10
tx_clk
m_tx_d(3:0)
m_tx_en
m_tx_err
gm_tx_d(7:0)
gm_tx_en
gm_tx_err
rx_clk
m_rx_d(3:0)
m_rx_en
gm_rx_d(7:0)
gm_rx_dv
gm_rx_err
m_rx_err
en_10
25MHzOsc
125/25/2.5 MHz
25MHz
clk_in/xtali
25/2.5 MHz
gtx_clk
txd(7:0)
tx_en
tx_err
tx_clk
rx_clk
rxd(7:0)
rx_dv
rx_err
ClockDriver
10/100/1000
Ethernet
MAC
10/100/1000
PHY
Optional tie to 0
if not used
Figure 24. 10/100/1000 PHY Interface via RGMII
FPGA Device
ena_10eth_mode
set_10set_1000
tx_clktx_controlrgmii_out[3:0]
rx_clkrx_controlrgmii_in[3:0]
Reference Clock125 MHz
gtx_clk
tx_entxd[3:0]
rx_clkrx_dvrxd[3:0]
clk_in/xtali Clock Divider
10/100/1000
Ethernet
MAC10/100/1000
PHY
Optional tie to 0
if not used

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
59

<!-- PDF page 60 -->


### 4.2. 1000BASE-X/SGMII PCS With Optional Embedded PMA

The Intel FPGA 1000BASE-X/SGMII PCS function implements the functionality
specified by IEEE 802.3 Clause 36. It does not support carrier extension, frame
bursting, and low power idle features. The PCS function is accessible via MII (SGMII)
or GMII (1000BASE-X/SGMII). The PCS function interfaces to an on- or off-chip
SERDES component via the industry standard ten-bit interface (TBI).
You can configure the PCS function to include an embedded physical medium
attachment (PMA) with a a serial transceiver or LVDS I/O and soft CDR. The PMA
interoperates with an external physical medium dependent (PMD) device, which drives
the external copper or fiber network. The interconnect between Intel FPGA and PMD
devices can be TBI or 1.25 Gbps serial.
The PCS function supports the following external PHYs:
• 1000 BASE-X PHYs as is.
• 10BASE-T, 100BASE-T and 1000BASE-T PHYs if the PHYs support SGMII.

#### 4.2.1. 1000BASE-X/SGMII PCS Architecture

Figure 25. 1000BASE-X/SGMII PCS
SGMII Receive Converter
SGMII Transmit Converter
Configuration
Encapsulation
De-encapsulation& Synchronization
Auto-Negotiation
1000BASE-X/SGMII PCS
TBIReceive
TBITransmit
StatusLEDs
Avalon Memory-Mapped Interface
MII/GMIIReceive
MII/GMIITransmit
Ethernet SideMAC Side
8b/10b
Decoder
8b/10b
Encoder

# 1000 Base-X PCS Receive Control


# 1000 Base-X PCS Transmit Control


## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
60

<!-- PDF page 61 -->

Figure 26. 1000BASE-X/SGMII 2XTBI PCS
Configuration
Encapsulation
De-encapsulation&Synchronization
Auto-Negotiation
1000BASE-X/SGMII 2XTBI PCS
2X TBITransmit
StatusLEDs
Ethernet SideMAC Side
2x 8b/10bDecoder
2x 8b/10bEncoder

# 1000 Base-X 2XTBI PCS Receive Control


# 1000 Base-X 2XTBI PCS Transmit Control

GMIIReceiveConverter
GMII Receive
MII Receive
GMII Transmit
MII Transmit
SGMIITransmitConverter
SGMIIReceiveConverter
GMIITransmitConverter
2X TBIReceive
Avalon Memory-Mapped Interface
Figure 27. 1000BASE-X/SGMII PCS with Embedded PMA
SGMII Receive Converter
SGMII Transmit Converter
Configuration
Encapsulation
De-encapsulation & Synchronization
Auto-Negotiation
StatusLEDs
Avalon Memory-Mapped Interface
MII/GMIIReceive
MII/GMIITransmit Serializer
PMA
PHY Loopback
Ethernet SideMAC Side

# 1000 Base-X PCS Receive Control


# 1000 Base-X PCS Transmit Control

8b/10bDecoder
8b/10bEncoder

## 1.25 GbpsSerial Receive


## 1.25 GbpsSerial Transmit

1000BASE-X/SGMII PCS with PMA
CDR & Deserializer

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
61

<!-- PDF page 62 -->

Figure 28. 1000BASE-X/SGMII 2XTBI PCS with Embedded PMA
Configuration
Encapsulation Serializer
PMA
PHY Loopback
Ethernet Side

# 1000 Base-X 2XTBI PCS Receive Control


# 1000 Base-X 2XTBI PCS Transmit Control

2x 8b/10bEncoder

## 1.25 GbpsSerial Receive


## 1.25 GbpsSerial Transmit

1000BASE-X/SGMII 2XTBI PCS with Embedded PMA
CDR & Deserializer
MAC Side
GMIIReceiveConverter
GMII Receive
MII Receive
GMII Transmit
MII Transmit
GMIITransmitConverter
SGMIITransmitConverter
SGMIIReceiveConverter De-encapsulation&Synchronization
2x 8b/10bDecoder
StatusLEDs
Auto-Negotiation
Avalon Memory-Mapped Interface

#### 4.2.2. Transmit Operation

The transmit operation includes frame encapsulation and encoding.

##### 4.2.2.1. Frame Encapsulation

The PCS function replaces the first preamble byte in the MAC frame with the start of
frame /S/ symbol. Then, the PCS function encodes the rest of the bytes in the MAC
frame with standard 8B/10B encoded characters. After the last FCS byte, the PCS
function inserts the end of frame sequence, /T/ /R/ /R/ or /T/ /R/, depending on the
number of character transmitted. Between frames, the PCS function transmits /I/
symbols.
If the PCS function receives a frame from the MAC function with an error (gm_tx_err
asserted during frame transmission), the PCS function encodes the error by inserting
a /V/ character.

##### 4.2.2.2. 8b/10b Encoding

The 8B/10B encoder maps 8-bit words to 10-bit symbols to generate a DC balance
and ensure disparity of the stream with a maximum run length of 5.

#### 4.2.3. Receive Operation

The receive operation includes comma detection, decoding, de-encapsulation,
synchronization, and carrier sense.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
62

<!-- PDF page 63 -->


##### 4.2.3.1. Comma Detection

The comma detection function searches for the 10-bit encoded comma character,
K28.1/K28.5/K28.7, in consecutive samples received from PMA devices. When the
K28.1/K28.5/K28.7 comma code group is detected, the PCS function realigns the data
stream on a valid 10-bit character boundary. A standard 8b/10b decoder can
subsequently decodes the aligned stream.
The comma detection function restarts the search for a valid comma character if the
receive synchronization state machine loses the link synchronization.

##### 4.2.3.2. 8b/10b Decoding

The 8b/10b decoder performs the disparity checking to ensure DC balancing and
produces a decoded 8-bit stream of data for the frame de-encapsulation function.

##### 4.2.3.3. Frame De-encapsulation

The frame de-encapsulation state machine detects the start of frame when the /I/ /S/
sequence is received and replaces the /S/ with a preamble byte (0x55). It continues
decoding the frame bytes and transmits them to the MAC function. The /T/ /R/ /R/ or
the /T/ /R/ sequence is decoded as an end of frame.
A /V/ character is decoded and sent to the MAC function as frame error. The state
machine decodes sequences other than /I/ /I/ (Idle) or /I/ /S/ (Start of Frame) as
wrong carrier.
During frame reception, the de-encapsulation state machine checks for invalid
characters. When the state machine detects invalid characters, it indicates an error to
the MAC function.

##### 4.2.3.4. Synchronization

The link synchronization constantly monitors the decoded data stream and determines
if the underlying receive channel is ready for operation. The link synchronization state
machine acquires link synchronization if the state machine receives three code groups
with comma consecutively without error.
When link synchronization is acquired, the link synchronization state machine counts
the number of invalid characters received. The state machine increments an internal
error counter for each invalid character received and incorrectly positioned comma
character. The internal error counter is decremented when four consecutive valid
characters are received. When the counter reaches 4, the link synchronization is lost.
The PCS function drives the led_link signal to 1 when link synchronization is
acquired. This signal can be used as a common visual activity check using a board
LED.
The PCS function drives the led_panel_link signal to 1 when link synchronization is
acquired for the PCS operating in 1000 Base-X without auto negotiation and SGMII
mode without auto negotiation.

##### 4.2.3.5. Carrier Sense

The carrier sense state machine detects an activity when the link synchronization is
acquired and when the transmit and receive encapsulation or de-encapsulation state
machines are not in the idle or error states.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
63

<!-- PDF page 64 -->

The carrier sense state machine drives the mii_rx_crs and led_crs signals to 1
when it detects an activity. The led_crs signal can be used as a common visual
activity check using a board LED.

##### 4.2.3.6. Collision Detection

A collision happens when non-idle frames are received from the PHY and transmitted
to the PHY simultaneously. Collisions can be detected only in SGMII and half-duplex
mode.
When a collision happens, the collision detection state machine drives the
mii_rx_col and led_col signals to 1. You can use the led_col signal as a visual
check using a board LED.

#### 4.2.4. Transmit and Receive Latencies

Intel uses the following definitions for the transmit and receive latencies for the PCS
function with an embedded PMA:
• Transmit latency is the time the PCS function takes to transmit the first bit on the
PMA-PCS interface after the bit was first available on the MAC side interface (MII/
GMII).
• Receive latency is the time the PCS function takes to present the first bit on the
MAC side interface (MII/GMII) after the bit was received on the PMA-PCS
interface.
**Table 33. PCS Transmit and Receive Latency**

| PCS Configuration | Latency (ns) | Column 3 |
| --- | --- | --- |
|  | Transmit | Receive |
| Stratix IV |  |  |
| 10 Mbps SGMII PCS with GXB | 3456 | 1454.85 |
| 100 Mbps SGMII PCS with GXB | 376 | 214.8 |
| 1000 Mbps SGMII PCS with GXB | 104 | 142.8 |
| 1000BASE-X with GXB | 8 | 48 |
| 10 Mbps SGMII PCS with LVDS I/O | 3064 | 1720 |
|  | Transmit | Receive |
| 100 Mbps SGMII PCS with LVDS I/O | 384 | 280 |
| 1000 Mbps SGMII PCS with LVDS I/O | 136 | 192 |
| 1000BASE-X PCS with LVDS I/O | 40 | 96 |
| Intel Arria 10 |  |  |
| 10 Mbps SGMII PCS with GXB | 3600 | 1867.65 |
| 100 Mbps SGMII PCS with GXB | 360 | 187.65 |
| 1000 Mbps SGMII PCS with GXB | 104 | 139.65 |
| 1000BASE-X with GXB | 8 | 48 |
| 10 Mbps SGMII PCS with LVDS I/O | 3208 | 1176 |
| 100 Mbps SGMII PCS with LVDS I/O | 368 | 256 |
| 1000 Mbps SGMII PCS with LVDS I/O | 136 | 192 |
| 1000BASE-X PCS with LVDS I/O | 40 | 96 |
| Intel Cyclone 10 GX |  |  |
| 10 Mbps SGMII PCS with GXB | 3600 | 1867.65 |
| 100 Mbps SGMII PCS with GXB | 360 | 187.65 |
| 1000 Mbps SGMII PCS with GXB | 104 | 139.65 |
| 1000BASE-X with GXB | 8 | 48 |
| 10 Mbps SGMII PCS with LVDS I/O | 3208 | 1176 |
| 100 Mbps SGMII PCS with LVDS I/O | 368 | 256 |
| 1000 Mbps SGMII PCS with LVDS I/O | 136 | 192 |
| 1000BASE-X PCS with LVDS I/O | 40 | 96 |
| Intel Stratix 10 |  |  |
| 10 Mbps SGMII PCS with LVDS I/O | 3336 | 1840 |
| 100 Mbps SGMII PCS with LVDS I/O | 456 | 280 |
| 1000 Mbps SGMII PCS with LVDS I/O | 112 | 208 |
| 1000BASE-X PCS with LVDS I/O with no Enable SGMII | 40 | 104 |
| Intel Stratix 10 E-tile |  |  |
| 10 Mbps SGMII 2XTBI PCS | 4872 | 6328 |
| 100 Mbps SGMII 2XTBI PCS | 752 | 968 |
| 1000 Mbps SGMII 2XTBI PCS | 300 | 416 |
| 1000BASE-X 2XTBI PCS without enabling SGMII | 300 | 416 |
| 10 Mbps SGMII 2XTBI PCS with GXB | 6466.401 | 6160.280 |
| 100 Mbps SGMII 2XTBI PCS with GXB | 906.401 | 880.272 |
| 1000 Mbps SGMII 2XTBI PCS with GXB | 306.401 | 424.281 |
| 1000BASE-X 2XTBI PCS with GXB without enabling SGMII | 306.401 | 424.281 |
|  | Transmit | Receive |
| Intel Agilex |  |  |
| 10 Mbps SGMII PCS with LVDS I/O | 2512 | 2512 |
| 100 Mbps SGMII PCS with LVDS I/O | 352 | 232 |
| 1000 Mbps SGMII PCS with LVDS I/O | 116 | 192 |
| 1000BASE-X PCS with LVDS I/O without enabling SGMII | 44 | 88 |
| 10 Mbps SGMII 2XTBI PCS | 4872 | 6328 |
| 100 Mbps SGMII 2XTBI PCS | 752 | 968 |
| 1000 Mbps SGMII 2XTBI PCS | 300 | 416 |
| 1000BASE-X 2XTBI PCS without enabling SGMII | 300 | 416 |
| Intel Agilex E-tile |  |  |
| 10 Mbps SGMII 2XTBI PCS with GXB | 6466.401 | 6160.280 |
| 100 Mbps SGMII 2XTBI PCS with GXB | 906.401 | 880.272 |
| 1000 Mbps SGMII 2XTBI PCS with GXB | 306.401 | 424.281 |
| 1000BASE-X 2XTBI PCS with GXB without enabling SGMII | 306.401 | 424.281 |
| Intel Agilex F-tile |  |  |
| 1000 Mbps SGMII 2XTBI PCS with FGT | 297.79 | 429.18 |

For GXB, the TX latencies are obtained from sim:/tb/dut/gmii_tx_d or sim:/tb/dut/mii_tx_d (after
clkena is asserted) to sim:/tb/dut/i_tse_pcs_0/tx_frame. The RX latencies are obtained from
sim:/tb/dut/gmii_rx_d or sim:/tb/dut/mii_rx_d to sim:/tb/dut/i_tse_pcs_0/tx_frame.
For LVDS, the TX latencies are obtained from the TX latencies are obtained from sim:/tb/dut/gmii_tx_d or
sim:/tb/dut/mii_tx_d (after clkena is asserted) to sim:/tb/dut/i_tse_pcs_0/tbi_tx_d_muxed.
The RX latencies are obtained from sim:/tb/dut/gmii_rx_d or sim:/tb/dut/mii_rx_d to
sim:/tb/dut/i_tse_pcs_0/tbi_rx_d_lvds.
For 2XTBI PCS variant, the TX latencies are obtained from sim:/tb/gmii_tx_d to sim:/tb/tbi2x_tx_d.
The RX latencies are obtained from sim:/tb/tbi2x_rx_d to sim:/tb/gmii_rx_d.
For 2XTBI PCS with GXB variant, the TX latencies are obtained from sim:/tb/dut/eth_tse_0_testbench/
i_tse_pcs_0/gmii_tx_d to sim:/tb/dut/eth_tse_0_testbench/i_tse_pcs_0/tbi2x_tx_d. The RX
latencies are obtained from sim:/tb/dut/eth_tse_0_testbench/i_tse_pcs_0/tbi2x_rx_d to
sim:/tb/dut/eth_tse_0_testbench/i_tse_pcs_0/gmii_rx_d.









## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
64

<!-- PDF page 65 -->
















































## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide

<!-- PDF page 66 -->






















#### 4.2.5. GMII Converter

• The GMII transmit converter converts the GMII (1000 Mbps)/MII (10/100 Mbps)
datapath to 16 bit GMII data.
• The GMII receive converter converts the 16 bit GMII data to GMII (1000
Mbps)/MII (10/100 Mbps).

#### 4.2.6. SGMII Converter

You can configure the PCS layer to use SGMII mode or 1000BASE-X mode. To
configure to SGMII mode, enable the SGMII converter by setting the SGMII_ENA bit in
the if_mode register to 1. When enabled and the USE_SGMII_AN bit in the if_mode
register is set to 1, the SGMII converter is automatically configured with the
capabilities advertised by the PHY. Otherwise, Intel recommends that you configure
the SGMII converter with the SGMII_SPEED bits in the if_mode register.
In 1000BASE-X mode, the PCS function always operates in gigabit mode and data
duplication is disabled.

##### 4.2.6.1. Transmit

In gigabit mode, the PCS and MAC functions must operate at the same rate. The
transmit converter transmits each byte from the MAC function once to the PCS
function.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
66

<!-- PDF page 67 -->

In 100 Mbps mode, the transmit converter replicates each byte received by the PCS
function 10 times. In 10 Mbps mode, the transmit converter replicates each byte
transmitted from the MAC function to the PCS function 100 times.

##### 4.2.6.2. Receive

In gigabit mode, the PCS and MAC functions must operate at the same rate. The
receive converter transmits each byte from the PCS function once to the MAC function.
In 100 Mbps mode, the receive converter transmits one byte out of 10 bytes received
from the PCS function to the MAC function. In 10 Mbps mode, the receive converter
transmits one byte out of 100 bytes received from the PCS function to the MAC
function.

#### 4.2.7. Auto-Negotiation

Auto-negotiation is an optional function that can be started when link synchronization
is acquired during system start up. To start auto-negotiation automatically, set the
AUTO_NEGOTIATION_ENABLE bit in the PCS control register to 1. During auto-
negotiation, the PCS function advertises its device features and exchanges them with
a link partner device.
If the SGMII_ENA bit in the if_mode register is set to 0, the PCS function operates in
1000BASE-X. Otherwise, the operating mode is SGMII. The following sections describe
the auto-negotiation process for each operating mode.
When simulating your design, you can disable auto-negotiation to reduce the
simulation time. If you enable auto-negotiation in your design, set the link_timer
time to a smaller value to reduce the auto-negotiation link timer in the simulation.
Related Information
PCS Configuration Register Space on page 97

##### 4.2.7.1. 1000BASE-X Auto-Negotiation

When link synchronization is acquired, the PCS function starts sending a /C/ sequence
(configuration sequence) to the link partner device with the advertised register set to
0x00. The sequence is sent for a time specified in the PCS link_timer register
mapped in the PCS register space.
When the link_timer time expires, the PCS dev_ability register is advertised,
with the ACK bit set to 0 for the link partner. The auto-negotiation state machine
checks for three consecutive /C/ sequences received from the link partner.
The auto-negotiation state machine then sets the ACK bit to 1 in the advertised
dev_ability register and checks if three consecutive /C/ sequences are received
from the link partner with the ACK bit set to 1.
Auto-negotiation waits for the value configured in the link_timer register to ensure
no more consecutive /C/sequences are received from the link partner. The auto-
negotiation is successfully completed when three consecutive idle sequences are
received after the link timer expires.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
67

<!-- PDF page 68 -->

After auto-negotiation completes successfully, the user software reads both the
dev_ability and partner_ability register and proceed to resolve priority for
duplex mode and pause mode. If the design contains a MAC and PCS, the user
software configures the MAC with a proper resolved pause mode by setting the
PAUSE_IGNORE bit in command_config register. To disable pause frame generation
based on the receive FIFO buffer level, you should set the rx_section_empty
register accordingly.
Figure 29. Auto-Negotiation Activity (Simplified)
Data
Link Partner PCS
Link Synchronization Acquired
Link Timer
= 10 ms
/C/ with dev_ability register and
ACK bit set to 0
/C/ with dev_ability register and
ACK bit set to 1
Send /I/ (Idle) sequence
/C/ with 0x00 ability

# 3 Consecutive /C/

with Acknowledge3 Consecutive /C/Link TimerLink Timer

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
68

<!-- PDF page 69 -->

Once auto-negotiation completes successfully, the ability advertised by the link
partner device is available in the partner_ability register and the
AUTO_NEGOTIATION_COMPLETE bit in the status register is set to 1.
The PCS function restarts auto-negotiation when link synchronization is lost and
reacquired, or when you set the RESTART_AUTO_NEGOTIATION bit in the PCS control
register to 1.

##### 4.2.7.2. SGMII Auto-Negotiation

In SGMII mode, the capabilities of the PHY device are advertised and exchanged with
a link partner PHY device.
Possible application of SGMII auto-negotiation in MAC mode and PHY mode.
Figure 30. SGMII Auto-Negotiation in MAC Mode and PHY Mode
SGMII PCS(MAC Mode)
SGMII Link
MediumTwisted Copper Pair
Device Ability
Link Partner Ability
Intel FPGA Device
Triple Speed EthernetIntel FPGA IP
SGMII PCS with PMA(PHY Mode)
Device Ability
Link Partner Ability
Intel FPGA Device
Triple Speed EthernetIntel FPGA IP
Device Ability
10/100/1000BASE-T PHY10/100/1000BASE-T PHYLink Partner
Link Partner Ability
Device Ability
Link Partner Ability
If the SGMII_ENA and USE_SGMII_AN bits in the if_mode register are 1, the PCS
function is automatically configured with the capabilities advertised by the PHY device
once the auto-negotiation completes.
If the SGMII_ENA bit is 1 and the USE_SGMII_AN bit is 0, the PCS function can be
configured with the SGMII_SPEED and SGMII_DUPLEX bits in the if_mode register.
If the SGMII_ENA bit is 1 and the SGMII_AN_MODE bit is 1 (SGMII PHY Mode auto-
negotiation is enabled) the speed and duplex mode resolution will be resolved based
on the value that you set in the dev_ability register once auto negotiation is done.
You should use set to the PHY mode if you want to advertise the link speed and duplex
mode to the link partner.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
69

<!-- PDF page 70 -->

Figure 31. SGMII Auto-Negotiation Activity
Link Timer
= 1.6 ms
Data
PHY SGMII PCS
Link
Synchronization
Acquired
/C/ with 0x00 ability
/C/ with dev_ability/C/ with 0x0001
/C/ with dev_ability and ACK
Send /I/ (Idle) sequence
Link TimerLink Timer 3 Consecutive /C/

# 3 Consecutive /C/

with Acknowledge
For more information, refer to CISCO Serial-GMII Specifications.

#### 4.2.8. Ten-bit Interface

In PCS variations without embedded PMA, the PCS function implements a TBI to an
external SERDES.
On transmit, the SERDES must serialize tbi_tx_d[0], the least significant bit of the
TBI output bus first and tbi_tx_d[9], the most significant bit of the TBI output bus
last to ensure the remote node receives the data correctly, as illustrated in the
following figure.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
70

<!-- PDF page 71 -->

Figure 32. SERDES Serialization Overview
serialization
tbi_tx_d(9:0)
1.25GbpsSerial Stream

# 9 0

On receive, the SERDES must serialize the TBI least significant bit first and the TBI
most significant bit last, as illustrated in the following figure.
Figure 33. SERDES De-Serialization Overview
de-serialization
tbi_rx_d(9:0)
1.25GbpsSerial Stream

# 9 0


#### 4.2.9. PHY Loopback

In PCS variations with embedded PMA targeting devices with GX transceivers, you can
enable loopback on the serial interface to test the PCS and embedded PMA functions in
isolation of the PMD. To enable loopback, set the sd_loopback bit in the PCS
control register to 1.
The serial loopback option is not supported in Cyclone IV devices with GX transceiver.
Figure 34. Serial Loopback
SERDES
Transmit
SERDES
Receive
SERDES
Serial Receive
Serial TransmitPCS Transmit
PCS Receive
sd _loopbackControl
MDIO
Slave
1000BASE-X PCS
Ten-bit
Interface

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
71

<!-- PDF page 72 -->


#### 4.2.10. PHY Power-Down

Power-down is controlled by the POWERDOWN bit in the PCS control register. When
the system management agent enables power-down, the PCS function drives the
powerdown signal, which can be used to control a technology specific circuit to switch
off the PCS function clocks to reduce the application activity.
When the PHY is in power-down state, the PCS function is in reset and any activities
on the GMII transmit and the TBI receive interfaces are ignored. The management
interface remains active and responds to management transactions from the MAC
layer device.
Figure 35. Power-Down
MDIO
Slave
powerdown
Control
Powerdown Control
(Technology Specific)
1000BASE-X PCS

##### 4.2.10.1. Power-Down in PCS Variations with Embedded PMA

In PCS variations with embedded PMA targeting devices with GX transceivers, the
power-down signal is internally connected to the power-down of the GX transceiver. In
these devices, the power-down functionality is shared across quad-port transceiver
blocks. Ethernet designs must share a common gxb_pwrdn_in signal to use the
same quad-port transceiver block.
For designs targeting devices other than Stratix V, you can export the power-down
signals to implement your own power-down logic to efficiently use the transceivers
within a particular transceiver quad. Turn on the Export transceiver powerdown
signal parameter to export the signals.
Figure 36. Power-Down with Export Transceiver Power-Down Signal
PMA
POWERDOWNCONTROL
pcs_pwrdn_out
gxb_pwrdn_in
1000BASE-X PCS

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
72

<!-- PDF page 73 -->


#### 4.2.11. 1000BASE-X/SGMII PCS Reset

A hardware reset resets all logic synchronized to the respective clock domains
whereas a software reset only resets the PCS state machines, comma detection
function, and 8B10B encoder and decoder. To trigger a hardware reset on the PCS,
assert the respective reset signals: reset_reg_clk, reset_tx_clk, and
reset_rx_clk. To trigger a software reset, set the RESET bit in the control
register to 1.
In PCS variations with embedded PMA, assert the respective reset signals or the
power-down signal to trigger a hardware reset. You must assert the reset signal
subsequent to asserting the reset_rx_clk, reset_tx_clk, or gxb_pwrdn_in
signal. The reset sequence is also initiated when the active-low rx_freqlocked
signal goes low.
Figure 37. Reset Distribution in PCS with Embedded PMA
PMA
Reset
Sequencer
Reset
Synchronizer
Reset
Synchronizer
PCS
reset
reset_tx_clk
reset_rx_clk
gxb_pwrdn_in
rx_freqlocked
For more information about the rx_freqlocked signal and transceiver reset, refer to
the transceiver handbook of the respective device family.
Assert the reset or gxb_pwrdn_in signals to perform a hardware reset on MAC with
PCS and embedded PMA variation.
Note: You must assert the reset signal for at least three clock cycles.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
73

<!-- PDF page 74 -->

Figure 38. Reset Distribution in MAC with PCS and Embedded PMA
PMA
Reset
Sequencer
Reset
Synchronizer
Reset
Synchronizer
MAC
reset gxb_pwrdn_in
PCS

### 4.3. Intel FPGA IEEE 1588v2

The Intel FPGA IEEE 1588v2 provides a timestamp for receiving and transmitting
frames in the Triple-Speed Ethernet Intel FPGA IP designs. This feature consists of
Precision Time Protocol (PTP). PTP is a layer-3 protocol that accurately synchronizes all
real time-of-day clocks in a network to a master clock.

#### 4.3.1. IEEE 1588v2 Supported Configurations

The Triple-Speed Ethernet Intel FPGA IP supports the IEEE 1588v2 feature only in the
following configurations:
• 10/100/1000-Mbps MAC with 1000BASE-X/SGMII PCS and embedded serial PMA
without FIFO buffer in full-duplex mode
• 10/100/1000-Mbps MAC with 1000BASE-X/SGMII PCS and embedded LVDS I/O
without FIFO buffer in full-duplex mode
• 10/100/1000-Mbps MAC without FIFO buffer in full-duplex mode
• 10/100/1000-Mbps Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS without
FIFO buffer in full-duplex mode

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
74

<!-- PDF page 75 -->


#### 4.3.2. IEEE 1588v2 Features

• Supports 4 types of PTP clock on the transmit datapath:
— Master and slave ordinary clock
— Master and slave boundary clock
— End-to-end (E2E) transparent clock
— Peer-to-peer (P2P) transparent clock
• Supports PTP message types:
— PTP event messages—Sync, Delay_Req, Pdelay_Req, and Pdelay_Resp.
— PTP general messages—Follow_Up, Delay_Resp, Pdelay_Resp_Follow_Up,
Announce, Management, and Signaling.
• Supports simultaneous 1-step and 2-step clock synchronizations on the transmit
datapath.
— 1-step clock synchronization—The MAC function inserts accurate timestamp in
Sync PTP message or updates the correction field with residence time.
— 2-step clock synchronization—The MAC function provides accurate timestamp
and the related fingerprint for all PTP message.
• Supports the following PHY operating speed accuracy:
— random error:
• 10Mbps—NA
• 100Mbps—timestamp accuracy of ± 5 ns
• 1000Mbps—timestamp accuracy of ± 2 ns
— static error—timestamp accuracy of ± 3 ns
• Supports IEEE 802.3, UDP/IPv4, and UDP/IPv6 transfer protocols for the PTP
frames.
• Supports untagged, VLAN tagged, Stacked VLAN Tagged PTP frames, and any
number of MPLS labels.
• Supports configurable register for timestamp correction on both transmit and
receive datapaths.
• Supports Time-of-Day (ToD) clock that provides a stream of 64-bit and 96-bit
timestamps.
Related Information
Altera 1588 System Solution

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
75

<!-- PDF page 76 -->


#### 4.3.3. IEEE 1588v2 Architecture

Figure 39. Overview of the IEEE 1588v2 Feature
This figure shows only the datapaths related to the IEEE 1588v2 feature.
IEEE 1588v2
Tx Logic
IEEE 1588v2
Rx Logic
PTP Software
Stack
Time-of-Day
Clock
PHY
Tx
PHY
Rx
MAC PHY
tx_path_delay
rx_path_delay
Timestamp &
User Fingerprint
Correction
Time of Day
Timestamp Aligned to
Receive Frame
tx_egress_timestamp_request
tx_ingress_timestamp
tx_time_of_day
rx_time_of_day

#### 4.3.4. IEEE 1588v2 Transmit Datapath

The IEEE 1588v2 feature supports 1-step and 2-step clock synchronizations on the
transmit datapath.
• For 1-step clock synchronization:
— Timestamp insertion depends on the PTP device and message type.
— The MAC function inserts a timestamp in the Sync PTP message if the PTP
clock operates as ordinary or boundary clock.
— Depending on the PTP device and message type, the MAC function updates the
residence time in the correction field of the PTP frame when the client asserts
tx_etstamp_ins_ctrl_residence_time_update. The residence time is
the difference between the egress and ingress timestamps.
— For PTP frames encapsulated using the UDP/IPv6 protocol, the MAC function
performs UDP checksum correction using extended bytes in the PTP frame.
— The MAC function re-computes and re-inserts CRC-32 into the PTP frames
after each timestamp or correction field insertion.
• For 2-step clock synchronization, the MAC function returns the timestamp and the
associated fingerprint for all transmit frames when the client asserts
tx_egress_timestamp_request_valid.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
76

<!-- PDF page 77 -->

**Table 34. Timestamp and Correction Insertion for 1-Step Clock Synchronization**

| PTP Message | Ordinary Clock | Column 3 | Boundary Clock | Column 5 | E2E Transparent Clock | Column 7 | P2P Transparent<br>Clock | Column 9 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  | Insert<br>Time<br>stamp | Insert<br>Correction | Insert<br>Time<br>stamp | Insert<br>Correction | Insert<br>Time<br>stamp | Insert<br>Correction | Insert<br>Time<br>stamp | Insert<br>Correct<br>ion |
| Sync | Yes (10) | No | Yes (10) | No | No | Yes (11) | No | Yes (11) |
| Delay_Req | No | No | No | No | No | Yes (11) | No | No |
| Pdelay_Req | No | No | No | No | No | Yes (11) | No | No |
| Pdelay_Resp | No | Yes (10)(11) | No | Yes (10)(11) | No | Yes (11) | No | Yes (10)<br>(11) |
| Delay_Resp | No | No | No | No | No | No | No | No |
| Follow_Up | No | No | No | No | No | No | No | No |
| Pdelay_Resp_F<br>ollow_Up | No | No | No | No | No | No | No | No |
| Announce | No | No | No | No | No | No | No | No |
| Signaling | No | No | No | No | No | No | No | No |
| Management | No | No | No | No | No | No | No | No |

This table summarizes the timestamp and correction field insertions for various PTP messages in different PTP
clocks.

#### 4.3.5. IEEE 1588v2 Receive Datapath

In the receive datapath, the IEEE 1588v2 feature provides a timestamp for all receive
frames. The timestamp is aligned with the avalon_st_rx_startofpacket signal.

#### 4.3.6. IEEE 1588v2 Frame Format

The MAC, with the IEEE 1588v2 feature, supports PTP frame transfer for the following
transport protocols:
• IEEE 802.3
• UDP/IPv4
• UDP/IPv6
(10) Applicable only when 2-step flag in flagField of the PTP frame is 0.
(11) Applicable when you assert tx_ingress_timestamp_request_valid.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
77

<!-- PDF page 78 -->


##### 4.3.6.1. PTP Frame in IEEE 802.3

Figure 40. PTP Frame in IEEE 802.3
flagField
correctionField
transportSpecific | messageType
reserved | versionPTP
reserved

# 1 Octet


# 1 Octet


# 1 Octet


# 2 Octets


# 8 Octets

reserved4 Octets
SourcePortIdentify10 Octets
sequenceId2 Octets
controlField1 Octet
logMessageInterval1 Octet
TimeStamp10 Octets
domainNumber
messageLength2 Octets

# 1 Octet

Length/Type = 0x88F7
Source Address
Destination Address

# 2 Octets


# 6 Octets


# 6 Octets

MAC Header
PTP Header
0..1500/9600 Octets
CRC
Payload

# 4 Octets

(1)
Note to Figure 40 on page 78 :

## 1. For frames with VLAN or Stacked VLAN tag, add 4 or 8 octets offsets before the

length/type field.

##### 4.3.6.2. PTP Frame over UDP/IPv4

Checksum calculation is optional for the UDP/IPv4 protocol. The 1588v2 Tx logic
should set the checksum to zero.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
78

<!-- PDF page 79 -->

Figure 41. PTP Frame over UDP/IPv4
MAC Header
UDP Header
IP Header
PTP Header
Time To Live
Protocol = 0x11
Version | Internet Header Length
Differentiated Services
Flags | Fragment Offsets

# 1 Octet


# 1 Octet


# 2 Octets


# 1 Octet


# 1 Octet

Header Checksum2 Octets
Source IP Address4 Octets
Destination IP Address4 Octets
Options | Padding0 Octet
Source Port2 Octets
Destination Port = 319 / 3202 Octets
Identification
Total Length2 Octets

# 2 Octets

Length/Type = 0x0800
Source Address
Destination Address

# 2 Octets


# 6 Octets


# 6 Octets

Checksum
Length

# 2 Octets


# 2 Octets

flagField
correctionField
transportSpecific | messageType
reserved | versionPTP
reserved

# 1 Octet


# 1 Octet


# 1 Octet


# 2 Octets


# 8 Octets

reserved4 Octets
SourcePortIdentify10 Octets
sequenceId2 Octets
controlField1 Octet
logMessageInterval1 Octet
TimeStamp10 Octets
domainNumber
messageLength2 Octets

# 1 Octet

CRC4 Octets
(1)
0..1500/9600 Octets Payload
Note to Figure 41 on page 79 :

## 1. For frames with VLAN or Stacked VLAN tag, add 4 or 8 octets offsets before the

length/type field.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
79

<!-- PDF page 80 -->


##### 4.3.6.3. PTP Frame over UDP/IPv6

Checksum calculation is mandatory for the UDP/IPv6 protocol. You must extend 2
bytes at the end of the UDP payload of the PTP frame. The MAC function modifies the
extended bytes to ensure that the UDP checksum remains uncompromised.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
80

<!-- PDF page 81 -->

Figure 42. PTP Frame over UDP/IPv6
Version | Traffic Class | Flow Label
Payload Length

# 4 Octet


# 2 Octets

Source IP Address16 Octets
Destination IP Address16 Octets
Source Port2 Octets
Destination Port = 319 / 3202 Octets
Hop Limit
Next Header = 0x111 Octet

# 1 Octet

Length/Type = 0x86DD
Source Address
Destination Address

# 2 Octets


# 6 Octets


# 6 Octets

Checksum
Length

# 2 Octets


# 2 Octets

flagField
correctionField
transportSpecific | messageType
reserved | versionPTP
reserved

# 1 Octet


# 1 Octet


# 1 Octet


# 2 Octets


# 8 Octets

reserved4 Octets
SourcePortIdentify10 Octets
sequenceId2 Octets
controlField1 Octet
logMessageInterval1 Octet
TimeStamp10 Octets
extended bytes2 Octets
CRC4 Octets
domainNumber
messageLength2 Octets

# 1 Octet

MAC Header
UDP Header
IP Header
PTP Header
(1)
Payload0..1500/9600 Octets
Note to Figure 42 on page 81 :

## 1. For frames with VLAN or Stacked VLAN tag, add 4 or 8 octets offsets before the

length/type field.

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
81

<!-- PDF page 82 -->


### 4.4. Deterministic Latency

The Deterministic Latency (DL) term used across this document refers to the ability to
precisely determine the delay between the elastic FIFO (EFIFO) and the PMA pins.
The deterministic latency measurement methodology is introduced for Intel Stratix 10
E-tile devices. It is based on the concept of measuring the time when a given word is
at the interface to the PMA and when that same word is at the FPGA core. The
difference in time between these two events, when added to the PMA propagation
delay, determines the total latency between the FPGA core and the serial pins. Such a
calculation intrinsically includes all delays due to intermediate logic, FIFOs, and all
other effects.
Figure 43. Deterministic Latency High Level Block Diagram
E-Tile Transceiver Native PHY
TX PMA
RX PMA
o_sl_latency_sclk
i_sl_tx_dl_async_pulse
o_sl_tx_rx_dl_measure_sel
i_sl_rx_dl_async_pulse
TX 80 bits data
RX 80 bits data
TX 20 bits data
RX 20 bits data
TX Serial
RX Serial
Triple-Speed Ethernet (Fifoless) + PCS 2xTBI
TX MAC TX PCS
RX MAC RX PCS
Triple-Speed EthernetDeterministicLatency (DL)
Even though this measurement is applicable for E-tile devices, Triple-Speed Ethernet
only supports this feature for the 10/100/1000Mb Ethernet MAC with 1000BASE-X/
SGMII 2xTBI PCS and without internal FIFO enabled IP variant using Intel Stratix 10
E-tile devices, running at 1G speed. You must turn on Enable timestamping and
Enable deterministic latency for E-tile device options to enable the DL feature.
**Table 35. Deterministic Latency Parameter Description for Triple-Speed Ethernet**

| Item | Value | Description |
| --- | --- | --- |
| sampling_clk period | 4.375 ns | Period for sampling clock<br>(i_dl_sampling_clk) of 228.571429 MHz. |
| UI period | 0.8 ns | Period for unit interval. |
| parallel_clk | 20 UI | Period for 1 parallel clock cycle. |
| tx_delay (TxDL) | Read from EFIFO-DL<br>register 0xE2[20:0] | TX delay value in sampling_clk cycles, fixed<br>point format Q13.8.<br>Bit [20:8] is integer, bit [7:0] is fractional<br>number.<br>For example, tx_delay = 0x27F4,<br>Bit [20:8] = 0x27 = 39<br>Bit [7:0] = 0xF4 = 0.953125<br>Hence, tx_delay = 39.953125 clock cycles. |
| rx_delay (RxDL) | Read from EFIFO-DL<br>register 0xE3[20:0] | RX delay value in the sampling_clk cycles,<br>fixed point format Q13.8.<br>Bit [20:8] is integer, bit [7:0] is fractional<br>number.<br>For example, rx_delay = 0x27F4,<br>Bit [20:8] = 0x27 = 39 |
|  |  | Bit [7:0] = 0xF4 = 0.953125<br>Hence, tx_delay = 39.953125 clock cycles. |

This table shows parameter description for the deterministic latency measurement for Triple-Speed Ethernet
use case.

## 4. Functional Description


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
82

<!-- PDF page 83 -->

**Table 36. Deterministic Latency Measurement for Triple-Speed Ethernet**

| Variant | TX Latency (ns) | RX Latency (ns) |
| --- | --- | --- |
| 1G | TxDL * (sampling_clock period in<br>ns)/(2^8) + (225 * UI period in ns) | RxDL * (sampling_clock period in<br>ns)/(2^8) + (-45) * (UI period in ns) |

This table shows the TX and RX latency calculations for the 1G variant.
Note: 1. Read TX/RX DL values from DL soft registers 0xE2 and 0xE3 respectively and
calculate TX/RX latency based on Table 36 on page 83.

## 2. Convert the TX and RX latency to 16 bits nanosecond and 16 bits fractional

nanosecond format by multiplying them by 216 or 65536.

## 3. Program the calculated 16 bits values to Triple-Speed Ethernet register.

a. Program lower 16 bits TX latency values to TSE MAC register 0xD1, which is
the TX fns value.
b. Program upper 16 bits TX latency values to TSE MAC register 0xD2, which is
the TX ns value.
c. Program lower 16 bits RX latency values to TSE MAC register 0xD4, which is
the RX fns value.
d. Program upper 16 bits RX latency values to TSE MAC register 0xD5, which is
the RX ns value.
Related Information
Deterministic Latency (Dword Offset 0xE1– 0xE3) on page 96

## 4. Functional Description


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
83

<!-- PDF page 84 -->


## 5. Configuration Register Space


### 5.1. MAC Configuration Register Space

Use the registers to configure the different aspects of the MAC function and retrieve its
status and statistics counters.
In multiport MACs, a contiguous register space is allocated for all ports and accessed
via the Avalon memory-mapped control interface. For example, if the register space
base address for the first port is 0x00, the base address for the next port is 0x100 and
so forth. The registers that are shared among the instances occupy the register space
of the first port. Updating these registers in the register space of other ports has no
effect on the configuration.
Note: If you select 10/100/1000Mb Ethernet MAC variant and deselect Use clock
enable for MAC in the parameter editor of the Triple-Speed Ethernet Intel FPGA IP,
the CSR access latency will be dependent on the datapath clock frequency.
**Table 37. Overview of MAC Register Space**

| Dword Offset | Section | Description |
| --- | --- | --- |
| 0x00 – 0x17 | Base Configuration | Base registers to configure the MAC function. At the minimum, you must<br>configure the following functions:<br>• Primary MAC address (mac_0/mac_1)<br>• Enable transmit and receive paths (TX_ENA and RX_ENA bits in the<br>command_config register)<br>The following registers are shared among all instances of a multiport MAC:<br>• rev<br>• scratch<br>• frm_length<br>• pause_quant<br>• mdio_addr0 and mdio_addr1<br>• tx_ipg_length<br>For more information about the base configuration registers, refer to Base<br>Configuration Registers (Dword Offset 0x00 – 0x17) on page 85. |
| 0x18 – 0x38 | Statistics Counters | Counters collecting traffic statistics. For more information about the statistics<br>counters, refer to Statistics Counters (Dword Offset 0x18 – 0x38) on page 92. |
| 0x3A | Transmit Command | Transmit and receive datapaths control register. For more information about<br>these registers, see Transmit and Receive Command Registers (Dword Offset<br>0x3A – 0x3B) on page 94. |
| 0x3B | Receive Command |  |
| 0x3C – 0x3E | Extended Statistics<br>Counters | Upper 32 bits of selected statistics counters. These registers are used if you<br>turn on the option to use extended statistics counters. For more information<br>about these counters, refer to Statistics Counters (Dword Offset 0x18 – 0x38)<br>on page 92. |
| 0x3F | Reserved (12) | Unused. |
| 0x40 – 0x7F | Multicast Hash Table | 64-entry write-only hash table to resolve multicast addresses. Only bit 0 in<br>each entry is significant. When you write a 1 to a dword offset in the hash<br>table, the MAC accepts all multicast MAC addresses that hash to the value of<br>the address (bits 5:0). Otherwise, the MAC rejects the multicast address. This<br>table is cleared during reset.<br>Hashing is not supported in 10/100 and 1000 Mbps small MAC variations. |
| 0x80 – 0x9F | MDIO Space 0<br>or PCS Function<br>Configuration | MDIO Space 0 and MDIO Space 1 map to registers 0 to 31 of the PHY devices<br>whose addresses are configured in the mdio_addr0 and mdio_addr1<br>registers respectively. For example, register 0 of PHY device 0 maps to dword<br>offset 0x80, register 1 maps to dword offset 0x81 and so forth.<br>Reading or writing to MDIO Space 0 or MDIO Space 1 immediately triggers a<br>corresponding MDIO transaction to read or write the PHY register. Only bits<br>[15:0] of each register are significant. Write 0 to bits [31:16] and ignore them<br>on reads.<br>If your variation does not include the PCS function, you can use MDIO Space 0<br>and MDIO Space 1 to map to two PHY devices.<br>If your MAC variation includes the PCS function, the PCS function is always<br>device 0 and its configuration registers (PCS Configuration Register Space on<br>page 97) occupy MDIO Space 0. You can use MDIO Space 1 to map to a PHY<br>device. |
| 0xA0 – 0xBF | MDIO Space 1 |  |
| 0xC0 – 0xC7 | Supplementary Address | Supplementary unicast addresses. For more information about these<br>addresses, refer to Supplementary Address (Dword Offset 0xC0 – 0xC7) on<br>page 95. |
| 0xC8 – 0xCF | Reserved (12) | Unused. |
| 0xD0 – 0xD6 | IEEE 1588v2 Feature | Registers to configure the IEEE 1588v2 feature. For more information about<br>these registers, refer to IEEE 1588v2 Feature (Dword Offset 0xD0 – 0xD6) on<br>page 95. |
| 0xD7 – 0xE0 | Reserved (12) | Unused. |
| 0xE1 – 0xE3 | Deterministic Latency | Configuration and status registers to retrieve the status and access the latency<br>values returned by the deterministic latency module. For more information<br>about these registers, refer to Deterministic Latency (Dword Offset 0xE1–<br>0xE3) on page 96. |


# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 85 -->


#### 5.1.1. Base Configuration Registers (Dword Offset 0x00 – 0x17)

The following table lists the base registers you can use to configure the MAC function.
A software reset does not reset these registers except the first two bits (TX_ENA and
RX_ENA = 0) in the command_config register.
(12) Intel recommends that you set all bits in the reserved registers to 0 and ignore them on



# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
85

<!-- PDF page 86 -->

**Table 38. Base Configuration Register Map**

| Dword<br>Offset | Name | R/W | Description | HW Reset |
| --- | --- | --- | --- | --- |
| 0x00 | rev | RO | • Bits[15:0]—Set to the current version of the IP.<br>• Bits[31:16]—Customer specific revision, specified by the<br>CUST_VERSION parameter defined in the top-level file<br>generated for the instance of the IP. These bits are set to<br>0 during the configuration of the IP. | <IP<br>version<br>number> |
| 0x01 | scratch (13) | RW | Scratch register. Provides a memory location for you to test<br>the device memory operation. | 0 |
| 0x02 | command_config | RW | MAC configuration register. Use this register to control and<br>configure the MAC function. The MAC function starts<br>operation as soon as the transmit and receive enable bits in<br>this register are turned on. Intel, therefore, recommends<br>that you configure this register last.<br>See Command_Config Register (Dword Offset 0x02) on<br>page 88 for the bit description. | 0 |
| 0x03 | mac_0 | RW | 6-byte MAC primary address. The first four most significant<br>bytes of the MAC address occupy mac_0 in reverse order.<br>The last two bytes of the MAC address occupy the two least<br>significant bytes of mac_1 in reverse order.<br>For example, if the MAC address is 00-1C-23-17-4A-CB, the<br>following assignments are made:<br>mac_0 = 0x17231c00<br>mac_1 = 0x0000CB4a<br>Ensure that you configure these registers with a valid MAC<br>address if you disable the promiscuous mode (PROMIS_EN<br>bit in command_config = 0). | 0 |
| 0x04 | mac_1 | RW |  | 0 |
| 0x05 | frm_length | RW/<br>RO | • Bits[15:0]—16-bit maximum frame length in bytes. The<br>IP checks the length of receive frames against this value.<br>Typical value is 1518.<br>In the 10/100 Mbps and 1000 Mbps small MAC<br>variations, this register is RO and the maximum frame<br>length is fixed to 1518.<br>• Bits[31:16]—unused. | 1518 |
| 0x06 | pause_quant | RW | • Bits[15:0]—16-bit pause quanta. Use this register to<br>specify the pause quanta to be sent to remote devices<br>when the local device is congested. The IP sets the<br>pause quanta (P1, P2) field in pause frames to the value<br>of this register.<br>The 10/100 Mbps and 1000 Mbps small MAC variations<br>do not support flow control.<br>• Bits[31:16]—unused. | 0 |
| 0x07 | rx_section_empt<br>y | RW/<br>RO | Variable-length section-empty threshold of the receive FIFO<br>buffer. Use the depth of your FIFO buffer to determine this<br>threshold. This threshold is typically set to (FIFO Depth –<br>16).<br>Set this threshold to a value that is below the<br>rx_almost_full threshold and above the<br>rx_section_full or rx_almost_empty threshold.<br>In the 10/100 Mbps and 1000 Mbps small MAC variations,<br>this register is RO and the register is set to a fixed value of<br>(FIFO Depth – 16). | 0 |
| 0x08 | rx_section_full | RW/<br>RO | Variable-length section-full threshold of the receive FIFO<br>buffer. Use the depth of your FIFO buffer to determine this<br>threshold.<br>For cut-through mode, this threshold is typically set to 16.<br>Set this threshold to a value that is above the<br>rx_almost_empty threshold.<br>For store-and-forward mode, set this threshold to 0.<br>In the 10/100 Mbps and 1000 Mbps small MAC variations,<br>this register is RO and the register is set to a fixed value of<br>16. | 0 |
| 0x09 | tx_section_empt<br>y | RW/<br>RO | Variable-length section-empty threshold of the transmit<br>FIFO buffer. Use the depth of your FIFO buffer to determine<br>this threshold. This threshold is typically set to (FIFO Depth<br>– 16).<br>Set this threshold to a value below the rx_almost_full<br>threshold and above the rx_section_full or<br>rx_almost_empty threshold.<br>In the 10/100 Mbps and 1000 Mbps small MAC variations,<br>this register is RO and the register is set to a fixed value of<br>(FIFO Depth – 16). | 0 |
| 0x0A | tx_section_full | RW/<br>RO | Variable-length section-full threshold of the transmit FIFO<br>buffer. Use the depth of your FIFO buffer to determine this<br>threshold.<br>For cut-through mode, this threshold is typically set to 16.<br>Set this threshold to a value above the tx_almost_empty<br>threshold.<br>For store-and-forward mode, set this threshold to 0.<br>In the 10/100 Mbps and 1000 Mbps small MAC variations,<br>this register is RO and the register is set to a fixed value of<br>16. | 0 |
| 0x0B | rx_almost_empty | RW/<br>RO | Variable-length almost-empty threshold of the receive FIFO<br>buffer. Use the depth of your FIFO buffer to determine this<br>threshold.<br>Due to internal pipeline latency, you must set this threshold<br>to a value greater than 3. This threshold is typically set to<br>8.<br>In the 10/100 Mbps and 1000 Mbps small MAC variations,<br>this register is RO and the register is set to a fixed value of<br>8. | 0 |
| 0x0C | rx_almost_full | RW/<br>RO | Variable-length almost-full threshold of the receive FIFO<br>buffer. Use the depth of your FIFO buffer to determine this<br>threshold.<br>Due to internal pipeline latency, you must set this threshold<br>to a value greater than 3. This threshold is typically set to<br>8.<br>In the 10/100 Mbps and 1000 Mbps small MAC variations,<br>this register is RO and the register is set to a fixed value of<br>8. | 0 |
| 0x0D | tx_almost_empty | RW/<br>RO | Variable-length almost-empty threshold of the transmit FIFO<br>buffer. Use the depth of your FIFO buffer to determine this<br>threshold.<br>Due to internal pipeline latency, you must set this threshold<br>to a value greater than 3. This threshold is typically set to<br>8.<br>In the 10/100 Mbps and 1000 Mbps small MAC variations,<br>this register is RO and the register is set to a fixed value of<br>8. | 0 |
| 0x0E | tx_almost_full | RW/<br>RO | Variable-length almost-full threshold of the transmit FIFO<br>buffer. Use the depth of your FIFO buffer to determine this<br>threshold.<br>You must set this register to a value greater than or equal<br>to 3. A value of 3 indicates 0 ready latency; a value of 4<br>indicates 1 ready latency, and so forth. Because the<br>maximum ready latency on the Avalon streaming interface<br>is 8, you can only set this register to a maximum value of<br>11. This threshold is typically set to 3.<br>In the 10/100 Mbps and 1000 Mbps small MAC variations,<br>this register is RO and the register is set to a fixed value<br>of 3. | 0 |
| 0x0F | mdio_addr0 | RW | • Bits[4:0]—5-bit PHY address. Set these registers to the<br>addresses of any connected PHY devices you want to<br>access. The mdio_addr0 and mdio_addr1 registers<br>contain the addresses of the PHY whose registers are<br>mapped to MDIO Space 0 and MDIO Space 1<br>respectively.<br>• Bits[31:5]—unused. Set to read-only value of 0. | 0 |
| 0x10 | mdio_addr1 | RW |  | 1 |
| 0x11 | holdoff_quant | RW | • Bit[15:0]—16-bit holdoff quanta. When you enable the<br>flow control, use this register to specify the gap between<br>consecutive XOFF requests.<br>• Bits[31:16]—unused. | 0xFFFF |
| 0x12 –<br>0x16 | Reserved | — | — | 0 |
| 0x17 | tx_ipg_length | RW | • Bits[4:0]—minimum IPG. Valid values are between 8 and<br>26 byte-times. If this register is set to an invalid value,<br>the MAC still maintains a typical minimum IPG value of<br>12 bytes between packets, although a read back to the<br>register reflects the invalid value written.<br>In the 10/100 Mbps and 1000 Mbps small MAC<br>variations, this register is RO and the register is set to a<br>fixed value of 12.<br>Bits[31:5]—unused. Set to read-only value 0. | 0 |



(13) Register is not available in 10/100 Mbps and 1000 Mbps small MAC variations.

## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
86

<!-- PDF page 87 -->


## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
87

<!-- PDF page 88 -->








##### 5.1.1.1. Command_Config Register (Dword Offset 0x02)

Figure 44. Command_Config Register Fields
TX_ENA
RX_ENA
XON_GEN
ETH_SPEED
PROMIS_EN
PAD_EN
CRC_FWD
PAUSE_FWD
PAUSE_IGNORE
TX_ADDR_INS
HD_ENA
EXCESS_COL
LATE_COL
SW_RESET
MHASH_SEL
LOOP_ENA
TX_ADDR_SEL
MAGIC_ENA
SLEEP
WAKEUP
XOFF_GEN
CTRL_FRM_ENA
NO_LGTH_CHECK
ENA_10
RX_ERR_DISC
CNT_RESET

# 31 30 … 26 25 24 23 22 21 201918 … 16 15 14 13 1211 10 9 8 7 6 5 4 3 2 1 027

At the minimum, you must configure the TX_ENA and RX_ENA bits to 1 to start the
MAC operations. When configuring the command_config register, Intel recommends
that you configure the TX_ENA and RX_ENA bits the last because the MAC
immediately starts its operations once these bits are set to 1.

## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
88

<!-- PDF page 89 -->

**Table 39. Command_Config Register Field Descriptions**

| Bit(s) | Name | R/W | Description | HW Reset |
| --- | --- | --- | --- | --- |
| 0 | TX_ENA | RW | Transmit enable. Set this bit to 1 to enable the transmit<br>datapath. The MAC clears this bit following a hardware or<br>software reset. See the SW_RESET bit description. | 0 |
| 1 | RX_ENA | RW | Receive enable. Set this bit to 1 to enable the receive<br>datapath. The MAC clears this bit following a hardware or<br>software reset. See the SW_RESET bit description. | 0 |
| 2 | XON_GEN | RW | Pause frame generation. When you set this bit to 1, the<br>MAC generates a pause frame with a pause quanta of 0,<br>independent of the status of the receive FIFO buffer. | 0 |
| 3 | ETH_SPEED | RW | Ethernet speed control.<br>• Set this bit to 1 to enable gigabit Ethernet operation.<br>The set_1000 signal is masked and does not affect<br>the operation.<br>• If you set this bit to 0, gigabit Ethernet operation is<br>enabled only if the set_1000 signal is asserted.<br>Otherwise, the MAC operates in 10/100 Mbps Ethernet<br>mode.<br>When the MAC operates in gigabit mode, the eth_mode<br>signal is asserted. This bit is not available in the small<br>MAC variation. | 0 |
| 4 | PROMIS_EN | RW | Promiscuous enable. Set this bit to 1 to enable<br>promiscuous mode. In this mode, the MAC receives all<br>frames without address filtering. | 0 |
| 5 | PAD_EN | RW | Padding removal on receive. Set this bit to 1 to remove<br>padding from receive frames before the MAC forwards the<br>frames to the user application. This bit has no effect on<br>transmit frames.<br>This bit is not available in the small MAC variation. | 0 |
| 6 | CRC_FWD | RW | CRC forwarding on receive.<br>• Set this bit to 1 to forward the CRC field to the user<br>application.<br>• Set this bit to 0 to remove the CRC field from receive<br>frames before the MAC forwards the frame to the user<br>application.<br>• The MAC ignores this bit when it receives a padded<br>frame and the PAD_EN bit is 1. In this case, the MAC<br>checks the CRC field and removes the checksum and<br>padding from the frame before forwarding the frame<br>to the user application. | 0 |
| 7 | PAUSE_FWD | RW | Pause frame forwarding on receive.<br>• Set this bit to 1 to forward receive pause frames to the<br>user application.<br>• Set this bit to 0 to terminate and discard receive<br>pause frames. | 0 |
| 8 | PAUSE_IGNORE | RW | Pause frame processing on receive.<br>• Set this bit to 1 to ignore receive pause frames.<br>• Set this bit to 0 to process receive pause frames. The<br>MAC suspends transmission for an amount of time<br>specified by the pause quanta. | 0 |
| 9 | TX_ADDR_INS | RW | MAC address on transmit. | 0 |
|  |  |  | • Set this bit to 1 to overwrite the source MAC address<br>in transmit frames received from the user application<br>with the MAC primary or supplementary address<br>configured in the registers. The TX_ADDR_SEL bit<br>determines the address selection.<br>• Set this bit to 0 to retain the source MAC address in<br>transmit frames received from the user application. |  |
| 10 | HD_ENA | RW | Half-duplex enable.<br>• Set this bit to 1 to enable half-duplex.<br>• Set this bit to 0 to enable full-duplex.<br>• The MAC ignores this bit if you set the ETH_SPEED bit<br>to 1. | 0 |
| 11 | EXCESS_COL | RO | Excessive collision condition.<br>• The MAC sets this bit to 1 when it discards a frame<br>after detecting a collision on 16 consecutive frame<br>retransmissions.<br>• The MAC clears this bit following a hardware or<br>software reset. See the SW_RESET bit description. | 0 |
| 12 | LATE_COL | RO | Late collision condition.<br>• The MAC sets this bit to 1 when it detects a collision<br>after transmitting 64 bytes and discards the frame.<br>• The MAC clears this bit following a hardware or<br>software reset. See the SW_RESET bit description. | 0 |
| 13 | SW_RESET | RW | Software reset. Set this bit to 1 to trigger a software<br>reset. The MAC clears this bit when it completes the<br>software reset sequence.<br>When software reset is triggered, the MAC completes the<br>current transmission or reception, and subsequently<br>disables the transmit and receive logic, flushes the receive<br>FIFO buffer, and resets the statistics counters. | 0 |
| 14 | MHASH_SEL | RW | Hash-code mode selection for multicast address<br>resolution.<br>• Set this bit to 0 to generate the hash code from the<br>full 48-bit destination address.<br>• Set this bit to 1 to generate the hash code from the<br>lower 24 bits of the destination MAC address. | 0 |
| 15 | LOOP_ENA | RW | Local loopback enable. Set this bit to 1 to enable local<br>loopback on the RGMII/GMII/MII of the MAC. The MAC<br>sends transmit frames back to the receive path.<br>This bit is not available in the small MAC variation. | 0 |
| 16 – 18 | TX_ADDR_SEL[2:<br>0] | RW | Source MAC address selection on transmit. If you set the<br>TX_ADDR_INS bit to 1, the value of these bits determines<br>the MAC address the MAC selects to overwrite the source<br>MAC address in frames received from the user application.<br>• 000 = primary address configured in the mac_0 and<br>mac_1 registers.<br>• 100 = supplementary address configured in the<br>smac_0_0 and smac_0_1 registers.<br>• 101 = supplementary address configured in the<br>smac_1_0 and smac_1_1 registers.<br>• 110 = supplementary address configured in the<br>smac_2_0 and smac_2_1 registers.<br>• 111 = supplementary address configured in the<br>smac_3_0 and smac_3_1 registers. | 000 |
| 19 | MAGIC_ENA | RW | Magic packet detection. Set this bit to 1 to enable magic<br>packet detection.<br>This bit is not available in the small MAC variation. | 0 |
| 20 | SLEEP | RW | Sleep mode enable. When the MAGIC_ENA bit is 1, set<br>this bit to 1 to put the MAC to sleep and enable magic<br>packet detection.<br>This bit is not available in the small MAC variation. | 0 |
| 21 | WAKEUP | RO | Node wake-up request. Valid only when the MAGIC_ENA<br>bit is 1.<br>• The MAC sets this bit to 1 when a magic packet is<br>detected.<br>• The MAC clears this bit when the SLEEP bit is set to 0. | 0 |
| 22 | XOFF_GEN | RW | Pause frame generation. Set this bit to 1 to generate a<br>pause frame independent of the status of the receive FIFO<br>buffer. The MAC sets the pause quanta field in the pause<br>frame to the value configured in the pause_quant<br>register. | 0 |
| 23 | CNTL_FRM_ENA | RW | MAC control frame enable on receive.<br>• Set this bit to 1 to accept control frames other than<br>pause frames (opcode = 0x0001) and forward them to<br>the user application.<br>• Set this bit to 0 to discard control frames other than<br>pause frames. | 0 |
| 24 | NO_LGTH_CHECK | RW | Payload length check on receive.<br>• Set this bit to 0 to check the actual payload length of<br>receive frames against the length/type field in receive<br>frames.<br>• Set this bit to 1 to omit length checking.<br>This bit is not available in the small MAC variation | 0<br>1 (for small MAC<br>variation) |
| 25 | ENA_10 | RW | 10-Mbps interface enable. Set this bit to 1 to enable the<br>10-Mbps interface. The MAC asserts the ena_10 signal<br>when you enable the 10-Mbps interface. You can also<br>enable the 10-Mbps interface by asserting the set_10<br>signal. | 0 |
| 26 | RX_ERR_DISC | RW | Erroneous frames processing on receive.<br>• Set this bit to 1 to discard erroneous frames received.<br>This applies only when you enable store and forward<br>operation in the receive FIFO buffer by setting the<br>rx_section_full register to 0.<br>• Set this bit to 0 to forward erroneous frames to the<br>user application with rx_err[0] asserted. | 0 |
| 27 | DISABLE_READ_<br>TIMEOUT | RW | By default, this bit is set to 0. Set this bit to 1 to disable<br>MAC configuration register read timeout.<br>To ensure the configuration register does not wait for read<br>timeout when an error occurs, set this bit to 1. | 0 |
| 28 – 30 | Reserved | — | — | 000 |
| 31 | CNT_RESET | RW | Statistics counters reset. Set this bit to 1 to clear the<br>statistics counters. The MAC clears this bit when the reset<br>sequence completes. | 0 |






















## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
89

<!-- PDF page 90 -->
















## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
90

<!-- PDF page 91 -->


























## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
91

<!-- PDF page 92 -->


#### 5.1.2. Statistics Counters (Dword Offset 0x18 – 0x38)

The following table describes the read-only registers that collect the statistics on the
transmit and receive datapaths. A hardware reset clears these registers; a software
reset also clears these registers except aMacID. The statistics counters roll up when
the counter is full.
The register description uses the following definitions:
• Good frame—error-free frames with valid frame length.
• Error frame—frames that contain errors or whose length is invalid.
• Invalid frame—frames that are not addressed to the MAC function. The MAC
function drops this frame.
**Table 40. Statistics Counters**

| Dword<br>Offset | Name | R/W | Description |
| --- | --- | --- | --- |
| 0x18 –<br>0x19 | aMacID | RO | The MAC address. This register is wired to the primary MAC address<br>in the mac_0 and mac_1 registers. |
| 0x1A | aFramesTransmitt<br>edOK | RO | The number of frames that are successfully transmitted including the<br>pause frames. |
| 0x1B | aFramesReceivedO<br>K | RO | The number of frames that are successfully received including the<br>pause frames. |
| 0x1C | aFrameCheckSeque<br>nceErrors | RO | The number of receive frames with CRC error. |
| 0x1D | aAlignmentErrors | RO | The number of receive frames with alignment error. |
| 0x1E | aOctetsTransmitt<br>edOK | RO | The number of data and padding octets that are successfully<br>transmitted.<br>This register contains the lower 32 bits of the<br>aOctetsTransmittedOK counter. The upper 32 bits of this statistics<br>counter reside at the dword offset 0x0F. |
| 0x1F | aOctetsReceivedO<br>K | RO | The number of data and padding octets that are successfully<br>received, including pause frames.<br>The lower 32 bits of the aOctetsReceivedOK counter. The upper 32<br>bits of this statistics counter reside at the dword offset 0x3D. |
| 0x20 | aTxPAUSEMACCtrlF<br>rames | RO | The number of pause frames transmitted. |
| 0x21 | aRxPAUSEMACCtrlF<br>rames | RO | The number received pause frames received. |
| 0x22 | ifInErrors | RO | The number of errored frames received. |
| 0x23 | ifOutErrors | RO | The number of transmit frames with one the following errors:<br>• FIFO overflow error<br>• FIFO underflow error<br>• Frames that encounter late or excessive collision occasions<br>• Errors defined by the user application |
| 0x24 | ifInUcastPkts | RO | The number of valid unicast frames received. |
| 0x25 | ifInMulticastPkt<br>s | RO | The number of valid multicast frames received. The count does not<br>include pause frames. |
| 0x26 | ifInBroadcastPkt<br>s | RO | The number of valid broadcast frames received. |
| 0x27 | Reserved | — | Unused. |
| 0x28 | ifOutUcastPkts | RO | The number of valid unicast and erroneous frames transmitted, as<br>well as unicast frames transmitted during late and excessive collision<br>occasions. |
| 0x29 | ifOutMulticastPk<br>ts | RO | The number of valid multicast frames transmitted, as well as<br>multicast frames transmitted during late and excessive collision<br>occasions, excluding pause frames. |
| 0x2A | ifOutBroadcastPk<br>ts | RO | The number of valid and erroneous broadcast frames transmitted, as<br>well as broadcast frames transmitted during late and excessive<br>collision occasions. |
| 0x2B | etherStatsDropEv<br>ents | RO | The number of frames that are dropped due to MAC internal errors<br>when FIFO buffer overflow persists. |
| 0x2C | etherStatsOctets | RO | The total number of octets received. This count includes both good<br>and errored frames.<br>This register is the lower 32 bits of etherStatsOctets. The upper<br>32 bits of this statistics counter reside at the dword offset 0x3E. |
| 0x2D | etherStatsPkts | RO | The total number of good and errored frames received. |
| 0x2E | etherStatsUnders<br>izePkts | RO | The number of frames received with length less than 64 bytes,<br>including pause frames. This count does not include errored frames. |
| 0x2F | etherStatsOversi<br>zePkts | RO | The number of frames received that are longer than the value<br>configured in the frm_length register. This count does not include<br>errored frames. |
| 0x30 | etherStatsPkts64<br>Octets | RO | The number of 64-byte frames received. This count includes good and<br>errored frames. |
| 0x31 | etherStatsPkts65<br>to127Octets | RO | The number of received good and errored frames between the length<br>of 65 and 127 bytes. |
| 0x32 | etherStatsPkts12<br>8to255Octets | RO | The number of received good and errored frames between the length<br>of 128 and 255 bytes. |
| 0x33 | etherStatsPkts25<br>6to511Octets | RO | The number of received good and errored frames between the length<br>of 256 and 511 bytes. |
| 0x34 | etherStatsPkts51<br>2to1023Octets | RO | The number of received good and errored frames between the length<br>of 512 and 1023 bytes. |
| 0x35 | etherStatsPkts10<br>24to1518Octets | RO | The number of received good and errored frames between the length<br>of 1024 and 1518 bytes. |
| 0x36 | etherStatsPkts15<br>19toXOctets | RO | The number of received good and errored frames between the length<br>of 1519 and the maximum frame length configured in the<br>frm_length register. |
| 0x37 | etherStatsJabber<br>s | RO | Too long frames with CRC error. |
| 0x38 | etherStatsFragme<br>nts | RO | Too short frames with CRC error. |
| 0x39 | Reserved | — | Unused. |
| Extended Statistics Counters (0x3C – 0x3E) |  |  |  |
| 0x3C | msb_aOctetsTrans<br>mittedOK | RO | Upper 32 bits of the respective statistics counters. By default all<br>statistics counters are 32 bits wide. These statistics counters can be<br>extended to 64 bits by turning on the Enable 64-bit byte counters<br>parameter.<br>To read the counter, read the lower 32 bits first, then followed by the<br>extended statistic counter bits. |
| 0x3D | msb_aOctetsRecei<br>vedOK | RO |  |
| 0x3E | msb_etherStatsOc<br>tets | RO |  |


## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
92

<!-- PDF page 93 -->




## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
93

<!-- PDF page 94 -->


#### 5.1.3. Transmit and Receive Command Registers (Dword Offset 0x3A –

0x3B)
The following table describes the registers that determine how the MAC function
processes transmit and receive frames. A software reset does not change the values in
these registers.
**Table 41. Transmit and Receive Command Registers**

| Dword<br>Offset | Name | R/W | Description |
| --- | --- | --- | --- |
| 0x3A | tx_cmd_stat | RW | Specifies how the MAC function processes transmit frames. When you<br>turn on the Align packet headers to 32-bit boundaries option,<br>this register resets to 0x00040000 upon a hardware reset. Otherwise,<br>it resets to 0x00.<br>• Bits 0 to 16—unused.<br>• Bit 17 (OMIT_CRC)—Set this bit to 1 to omit CRC calculation and<br>insertion on the transmit path. The user application is therefore<br>responsible for providing the correct data and CRC. This bit, when<br>set to 1, always takes precedence over the ff_tx_crc_fwd<br>signal.<br>• Bit 18 (TX_SHIFT16)—Set this bit to 1 if the frames from the user<br>application are aligned on 32-bit boundary. For more information,<br>refer to IP Payload Re-alignment on page 37.<br>This setting applies only when you turn on the Align packet<br>headers to 32-bit boundary option and in MAC variations with<br>32-bit internal FIFO buffers. Otherwise, reading this bit always<br>return a 0.<br>In MAC variations without internal FIFO buffers, this bit is a read-<br>only bit and takes the value of the Align packet headers to 32-<br>bit boundary option.<br>• Bits 19 to 31—unused. |
| 0x3B | rx_cmd_stat | RW | Specifies how the MAC function processes receive frames. When you<br>turn on the Align packet headers to 32-bit boundaries option,<br>this register resets to 0x02000000 upon a hardware reset. Otherwise,<br>it resets to 0x00.<br>• Bits 0 to 24—unused.<br>• Bit 25 (RX_SHIFT16)—Set this bit to 1 to instruct the MAC<br>function to align receive frames on 32-bit boundary. For more<br>information on frame alignment, refer to IP Payload Alignment on<br>page 44.<br>This setting applies only when you turn on the Align packet<br>headers to 32-bit boundary option and in MAC variations with<br>32-bit internal FIFO buffers. Otherwise, reading this bit always<br>return a 0.<br>In MAC variations without internal FIFO buffers, this bit is a read-<br>only bit and takes the value of the Align packet headers to 32-<br>bit boundary option.<br>• Bits 26 to 31—unused. |


## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
94

<!-- PDF page 95 -->


#### 5.1.4. Supplementary Address (Dword Offset 0xC0 – 0xC7)

A software reset has no impact on these registers. MAC supplementary addresses are
not available in 10/100 and 1000 Small MAC variations.
**Table 42. Supplementary Address Registers**

| Dword<br>Offset | Name | R/W | Description | HW<br>Reset |
| --- | --- | --- | --- | --- |
| 0xC0 | smac_0_0 | RW | You can specify up to four 6-byte supplementary addresses:<br>• smac_0_0/1<br>• smac_1_0/1<br>• smac_2_0/1<br>• smac_3_0/1<br>Map the supplementary addresses to the respective registers in<br>the same manner as the primary MAC address. Refer to the<br>description of mac_0 and mac_1.<br>The MAC function uses the supplementary addresses for the<br>following operations:<br>• to filter unicast frames when the promiscuous mode is<br>disabled (refer to Command_Config Register (Dword Offset<br>0x02) on page 88 for the description of the PROMIS_EN bit).<br>• to replace the source address in transmit frames received<br>from the user application when address insertion is enabled<br>(refer to Command_Config Register (Dword Offset 0x02) on<br>page 88 for the description of the TX_ADDR_INS and<br>TX_ADDR_SEL bits).<br>If you do not require the use of supplementary addresses,<br>configure them to the primary address. | 0 |
| 0xC1 | smac_0_1 |  |  |  |
| 0xC2 | smac_1_0 |  |  |  |
| 0xC3 | smac_1_1 |  |  |  |
| 0xC4 | smac_2_0 |  |  |  |
| 0xC5 | smac_2_1 |  |  |  |
| 0xC6 | smac_3_0 |  |  |  |
| 0xC7 | smac_3_1 |  |  |  |


#### 5.1.5. IEEE 1588v2 Feature (Dword Offset 0xD0 – 0xD6)

**Table 43. IEEE 1588v2 MAC Registers**

| Dword<br>Offset | Name | R/W | Description | HW<br>Reset |
| --- | --- | --- | --- | --- |
| 0xD0 | tx_period | RW | Clock period for timestamp adjustment on the transmit<br>datapath. The period register is multiplied by the number of<br>stages separating actual timestamp and the GMII bus.<br>• Bits 0 to 15: Period in fractional nanoseconds<br>(TX_PERIOD_FNS).<br>• Bits 16 to 24: Period in nanoseconds (TX_PERIOD_NS).<br>• Bits 25 to 31: Not used.<br>The default value for the period is 0. For 125 MHz clock, set this<br>register to 8 ns. | 0x0 |
| 0xD1 | tx_adjust_fns | RW | Static timing adjustment in fractional nanoseconds for outbound<br>timestamps on the transmit datapath.<br>• Bits 0 to 15: Timing adjustment in fractional nanoseconds.<br>• Bits 16 to 31: Not used. | 0x0 |
| 0xD2 | tx_adjust_ns | RW | Static timing adjustment in nanoseconds for outbound<br>timestamps on the transmit datapath.<br>• Bits 0 to 15: Timing adjustment in nanoseconds.<br>• Bits 16 to 23: Not used. | 0x0 |
| 0xD3 | rx_period | RW | Clock period for timestamp adjustment on the receive datapath.<br>The period register is multiplied by the number of stages<br>separating actual timestamp and the GMII bus. | 0x0 |
|  |  |  | • Bits 0 to 15: Period in fractional nanoseconds<br>(RX_PERIOD_FNS).<br>• Bits 16 to 24: Period in nanoseconds (RX_PERIOD_NS).<br>• Bits 25 to 31: Not used.<br>The default value for the period is 0. For 125 MHz clock, set this<br>register to 8 ns. |  |
| 0xD4 | rx_adjust_fns | RW | Static timing adjustment in fractional nanoseconds for outbound<br>timestamps on the receive datapath.<br>• Bits 0 to 15: Timing adjustment in fractional nanoseconds.<br>• Bits 16 to 31: Not used. | 0x0 |
| 0xD5 | rx_adjust_ns | RW | Static timing adjustment in nanoseconds for outbound<br>timestamps on the receive datapath.<br>• Bits 0 to 15: Timing adjustment in nanoseconds.<br>• Bits 16 to 23: Not used. | 0x0 |


## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
95

<!-- PDF page 96 -->


#### 5.1.6. Deterministic Latency (Dword Offset 0xE1– 0xE3)

**Table 44. Deterministic Latency Configuration and Status Register**

| Dword<br>Offset | Name | Bit | R/W | Description | HW<br>Reset |
| --- | --- | --- | --- | --- | --- |
| 0xE1 | dl_reset | [1] | RW | Deterministic latency (DL) soft reset.<br>Provides a soft reset to the deterministic latency<br>block.<br>• 0: DL block is not under reset<br>• 1: DL block is being reset<br>Note: This is not a self-clearing reset. | 0x0 |
|  | measure_valid | [0] | RO | Indicates whether the DL measurement values are<br>valid.<br>• 0: Not valid<br>• 1: Valid | 0x0 |
| 0xE2 | tx_delay | [20:0] | RO | TX datapath latency.<br>Displays the TX datapath DL measurement values<br>measured in the i_dl_sampling_clk cycles.<br>measure_valid must be set prior taking the<br>measurement. | 0x0 |
| 0xE3 | rx_delay | [20:0] | RO | RX datapath latency<br>Displays the RX datapath DL measurement values<br>measured in the i_dl_sampling_clk cycles.<br>measure_valid must be set prior taking the<br>measurement. | 0x0 |

Related Information
Deterministic Latency on page 82

#### 5.1.7. IEEE 1588v2 Feature PMA Delay

PMA digital and analog delay of hardware for the IEEE 1588v2 feature and the register
timing adjustment. 1 UI is equivalent to 800 ps.

## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
96

<!-- PDF page 97 -->

**Table 45. IEEE 1588v2 Feature PMA Delay—Hardware**

| Delay | Device | Timing Adjustment | Column 4 |
| --- | --- | --- | --- |
|  |  | TX register | RX register |
| Digital | Stratix V or Arria V GZ | 53 UI | 26 UI |
|  | Arria V GX, Arria V GT, or Arria V SoC | 52 UI | 34 UI |
|  | Cyclone V GX or Cyclone V SoC | 32 UI | 44 UI |
|  | Intel Arria 10 | 43 UI | 24.5 UI |
| Analog | Stratix V | -1.1 ns | 1.75 ns |
|  | Arria V | -1.1 ns | 1.75 ns |
|  | Cyclone V | -1.1 ns | 1.75 ns |

**Table 46. IEEE 1588v2 Feature LVDS I/O Delay—Hardware**

| Delay | Device | Timing Adjustment | Column 4 |
| --- | --- | --- | --- |
|  |  | TX register | RX register |
| Digital | Stratix V or Arria V GZ | 21 UI | 26 UI |
|  | Arria V GX, Arria V GT, or Arria V SoC | 21 UI | 26 UI |
|  | Intel Arria 10 | 21 UI | 26 UI |
|  | Intel Stratix 10 (L-tile and H-tile) | 21 UI | 26 UI |


### 5.2. PCS Configuration Register Space

This section describes the PCS registers. Use the registers to configure the PCS
function or retrieve its status.
Note: In MAC and PCS variations, the PCS registers occupy the MAC register space and you
access these registers via the MAC 32-bit Avalon memory-mapped control interface.
PCS registers are 16 bits wide, they therefore occupy only the lower 16 bits and the
upper 16 bits are set to 0. The offset of the first PCS register in this variation is
mapped to dword offset 0x80.
If you instantiate the IP using the IP Catalog flow, use word addressing to access the
register spaces. When you instantiate MAC and PCS variations, map the PCS registers
to the respective dword offsets in the MAC register space by adding the PCS word
offset to the offset of the first PCS. For example,
• In the PCS only variation, you can access the if_mode register at word offset
0x14.
• In the fMAC and PCS variations, map the if_mode register to the MAC register
space:
— Offset of the first PCS register = 0x80
— if_mode word offset = 0x14
— if_mode dword offset = 0x80 + 0x14 = 0x94

## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
97

<!-- PDF page 98 -->

If you instantiate the MAC and PCS variation using the Platform Designer system,
access the register spaces using byte addressing. Convert the dword offsets to byte
offsets by multiplying the dword offsets by 4. For example,
• For MAC registers:
— comand_config dword offset = 0x02
— comand_config byte offset = 0x02 × 4 = 0x08
• For PCS registers, map the registers to the dword offsets in the MAC register
space before you convert the dword offsets to byte offsets:
— if_mode word offset = 0x14
— if_mode dword offset = 0x80 + 0x14 = 0x94
— if_mode byte offset = 0x94 × 4 = 0x250
**Table 47. PCS Configuration Registers**

| Word<br>Offset | Register Name | R/W | Description | HW Reset |
| --- | --- | --- | --- | --- |
| 0x00 | control | RW | PCS control register. Use this register to control and<br>configure the PCS function. For the bit description, see<br>Control Register (Word Offset 0x00) on page 99. | 0x1140 |
| 0x01 | status | RO | Status register. Provides information on the operation of the<br>PCS function. | 0x0089 |
| 0x02 | phy_identifier | RO | 32-bit PHY identification register. This register is set to the<br>value of the PHY ID parameter. Bits 31:16 are written to<br>word offset 0x02. Bits 15:0 are written to word offset 0x03. | 0x0101 |
| 0x03 |  |  |  | 0x0101 |
| 0x04 | dev_ability | RW | Use this register to advertise the device abilities to a link<br>partner during auto-negotiation. In SGMII MAC mode, the<br>PHY does not use this register during auto-negotiation. For<br>the register bits description in 1000BASE-X and SGMII<br>mode, see 1000BASE-X on page 101 and SGMII PHY Mode<br>Auto Negotiation on page 102. | 0x01A0 |
| 0x05 | partner_abilit<br>y | RO | Contains the device abilities advertised by the link partner<br>during auto-negotiation. For the register bits description in<br>1000BASE-X and SGMII mode, refer to 1000BASE-X on<br>page 101 and SGMII PHY Mode Auto Negotiation on page<br>102, respectively. | 0x0000 |
| 0x06 | an_expansion | RO | Auto-negotiation expansion register. Contains the PCS<br>function capability and auto-negotiation status. | 0x0000 |
| 0x07 | device_next_pa<br>ge | RO | The PCS function does not support these features. These<br>registers are always set to 0x0000 and any write access to<br>the registers is ignored. | 0x0000 |
| 0x08 | partner_next_p<br>age |  |  | 0x0000 |
| 0x09 | master_slave_c<br>ntl |  |  | 0x0000 |
| 0x0A | master_slave_s<br>tat |  |  | 0x0000 |
| 0x0B –<br>0x0E | Reserved | — | — | — |
| 0x0F | extended_statu<br>s | RO | The PCS function does not implement extended status<br>registers. | — |
| Specific Extended Registers |  |  |  |  |
| 0x10 | scratch | RW | Scratch register. Provides a memory location to test register<br>read and write operations. | 0x0000 |
| 0x11 | rev | RO | The PCS function revision. Always set to the current version<br>of the IP. | <IP version<br>number> |
| 0x12 | link_timer | RW | 21-bit auto-negotiation link timer. Set the link timer value<br>from 0 to 16 ms in 8 ns steps (125 MHz clock periods). The<br>reset value sets the link timer to 10 ms.<br>• Bits 15:0 are written to word offset 0x12. Bit 0 of word<br>offset 0x12 is always set to 0, thus any value written to<br>it is ignored.<br>• Bits 20:16 are written to word offset 0x13. The<br>remaining bits are reserved and always set to 0. | 0x8968 |
| 0x13 |  |  |  | 0x0009 |
| 0x14 | if_mode | RW | Interface mode. Use this register to specify the operating<br>mode of the PCS function; 1000BASE-X or SGMII. | 0 |
| 0x17 –<br>0x1F | Reserved | — | — | 0 |

—

## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
98

<!-- PDF page 99 -->


#### 5.2.1. Control Register (Word Offset 0x00)

**Table 48. PCS Control Register Bit Descriptions**

| Bit(s) | Name | R/W | Description |
| --- | --- | --- | --- |
| 0:4 | Reserved | — | — |
| 5 | UNIDIRECTIONAL_EN<br>ABLE | RW | Enables the unidirectional function. This bit depends on bit 12. When bit<br>12 is one, this bit is ignored.<br>When bit 12 is zero, bit 5 indicates the unidirectional function:<br>• A value of 1 enables transmit from media independent interface<br>regardless of whether the PHY has determined that a valid link has<br>been established.<br>• A value of 0 enables transmit from media independent interface only<br>when the PHY has determined that a valid link has been established.<br>The reset value of this bit is zero. |
| 6, 13 | SPEED_SELECTION | RO | Indicates the operating mode of the PCS function. Bits 6 and 13 are set<br>to 1 and 0 respectively. This combination of values represent the gigabit<br>mode.<br>Bit [6, 13]:<br>• 00: 10 Mbps<br>• 01: 100 Mbps<br>• 10: 1 Gigabit<br>• 11: Reserved |
| 7 | COLLISION_TEST | RO | The 1000BASE-X PCS function does not support half-duplex mode. This<br>bit is always set to 0.<br>Ignore this bit if you are using SGMII PCS function. |
| 8 | DUPLEX_MODE | RO | The 1000BASE-X PCS function only supports full-duplex mode. This bit is<br>always set to 1.<br>Ignore this bit if you are using SGMII PCS function. |
| 9 | RESTART_AUTO_<br>NEGOTIATION | RW | Set this bit to 1 to restart the auto-negotiation sequence. For normal<br>operation, set this bit to 0 (reset value). |
| 10 | ISOLATE | RW | Set this bit to 1 to isolate the PCS function from the MAC layer device.<br>For normal operation, set this bit to 0 (reset value). |
| 11 | POWERDOWN | RW | Set this bit to 1 to power down the transceiver quad. The PCS function<br>then asserts the powerdown signal to indicate the state it is in. |
| 12 | AUTO_NEGOTIATION_<br>ENABLE | RW | Set this bit to 1 (reset value) to enable auto-negotiation. |
| 14 | LOOPBACK | RW | PHY loopback. Set this bit to 1 to implement loopback in the GX<br>transceiver. For normal operation, set this bit to 0 (reset value). This bit<br>is ignored if reduced ten-bit interface (RTBI) is implemented.<br>This feature is supported in all device families except the Cyclone IV GX<br>device families. |
| 15 | RESET | RW | Self-clearing reset bit. Set this bit to 1 to generate a synchronous reset<br>pulse which resets all the PCS function state machines, comma detection<br>function, and 8b/10b encoder and decoder. For normal operation, set<br>this bit to 0 (asynchronous reset value). |












## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
99

<!-- PDF page 100 -->












#### 5.2.2. Status Register (Word Offset 0x01)

**Table 49. Status Register Bit Descriptions**

| Bit | Name | R/W | Description |
| --- | --- | --- | --- |
| 0 | EXTENDED_CAPABILI<br>TY | RO | A value of 1 indicates that the PCS function supports extended registers. |
| 1 | JABBER_DETECT | — | Unused. Always set to 0. |
| 2 | LINK_STATUS | RO | A value of 1 indicates that a valid link is established. A value of 0<br>indicates an invalid link.<br>If the link synchronization is lost, a 0 is latched. |
| 3 | AUTO_NEGOTIATION_<br>ABILITY | RO | A value of 1 indicates that the PCS function supports auto-negotiation. |
| 4 | REMOTE_FAULT | — | Unused. Always set to 0. |
| 5 | AUTO_NEGOTIATION_<br>COMPLETE | RO | A value of 1 indicates the following status:<br>• The auto-negotiation process is completed.<br>• The auto-negotiation control registers are valid. |
| 6 | MF_PREAMBLE_SUPPR<br>ESSION | — | Unused. Always set to 0. |
| 7 | UNIDIRECTIONAL_AB<br>ILITY | RO | A value of 1 indicates that the PCS is able to transmit from MII/GMII<br>regardless of whether the PCS has established a valid link. |
| 8 | EXTENDED_STATUS | — | Unused. Always set to 0. |
| 9 | 100BASET2_HALF_DU<br>PLEX | RO | The PCS function does not support 100Base-T2, 10-Mbps, 100BASE-X,<br>and 100Base-T4 operation. Always set to 0. |
| 10 | 100BASET2_FULL_DU<br>PLEX |  |  |
| 11 | 10MBPS_HALF_DUPLE<br>X |  |  |
| 12 | 10MBPS_FULL_DUPLE<br>X |  |  |
| 13 | 100BASE-<br>X_HALF_DUPLEX |  |  |
| 14 | 100BASE-<br>X_FULL_DUPLEX |  |  |
| 15 | 100BASE-T4 |  |  |




























## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
100

<!-- PDF page 101 -->








#### 5.2.3. Dev_Ability and Partner_Ability Registers (Word Offset 0x04 –

0x05)
The definition of each field in the partner_ability registers depends on the mode
in which the PCS function operates.
In this mode, the definition of the fields in the dev_ability register are the same as
the fields in the partner_ability register. The contents of these registers are valid
only when the auto-negotiation completes (AUTO_NEGOTIATION_COMPLETE bit in the
status register = 1).

##### 5.2.3.1. 1000BASE-X

**Table 50. Dev_Ability and Partner_Ability Registers Bits Description in 1000BASE-X**

| Bit(s) | Name | R/W | Description |
| --- | --- | --- | --- |
| 0:4 | Reserved | — | Always set these bits to 0. |
| 5 | FD | RW/RO (1), (2) | Full-duplex mode enable. A value of 1 indicates support for full<br>duplex. |
| 6 | HD |  | Half-duplex mode enable. A value of 1 indicates support for half<br>duplex. |
| 7 | PS1 |  | Pause support.<br>• PS1=0 / PS2=0: Pause is not supported.<br>• PS1=0 / PS2=1: Asymmetric pause toward link partner.<br>• PS1=1 / PS2=0: Symmetric pause.<br>• PS1=1/ PS2=1: Pause is supported on transmit and receive. |
| 8 | PS2 |  |  |
| 9:11 | Reserved | — | Always set these bits to 0. |
| 12 | RF1 | RW/RO (1), (2) | Remote fault condition:<br>• RF1=0 / RF2=0: No error, link is valid (reset condition).<br>• RF1=0 / RF2=1: Offline.<br>• RF1=1 / RF2=0: Failure condition.<br>• RF1=1 / RF2=1: Auto-negotiation error. |
| 13 | RF2 |  |  |
| 14 | ACK | RO | Acknowledge. A value of 1 indicates that the device has received<br>three consecutive matching ability values from its link partner. |
| 15 | NP | RW/RO(1) (2) | Next page. In dev_ability register, this bit is always set to 0. |
| Notes to Table 50 on page 101 :<br>1. All bits in the dev_ability register have RW access.<br>2. All bits in the partner_ability register are read-only. |  |  |  |






















## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide

<!-- PDF page 102 -->


##### 5.2.3.2. SGMII MAC Mode Auto Negotiation

When the SGMII mode and the SGMII MAC mode auto-negotiation are enabled, the
Triple-Speed Ethernet Intel FPGA IP ignores the value in the dev_ability register
and automatically sets the value to 16’h4001 as specified in the SGMII specification
for SGMII auto-negotiation.
When the auto-negotiation is complete, the Triple-Speed Ethernet Intel FPGA IP speed
and the duplex mode will be resolved based on the value in the partner_ability
register. The partner_ability register is received from the link partner during the
auto-negotiation process.
**Table 51. Partner_Ability Register Bits Description in SGMII MAC Mode**

| Bit(s) | Name | R/W | Description |
| --- | --- | --- | --- |
| 9:0 | Reserved | — | — |
| 11:10 | COPPER_SPEED[1:0<br>] | RO | Link partner interface speed:<br>• 00: Copper interface speed is 10 Mbps.<br>• 01: Copper interface speed is 100 Mbps.<br>• 10: Copper interface speed is 1 gigabit.<br>• 11: Reserved. |
| 12 | COPPER_DUPLEX_ST<br>ATUS | RO | Link partner duplex capability:<br>• 1: Copper interface is capable of operating in full-duplex mode.<br>• 0: Copper interface is capable of operating in half-duplex mode. |
| 13 | Reserved | — | — |
| 14 | ACK | RO | Acknowledge. A value of 1 indicates that the link partner has received<br>3 consecutive matching ability values from the device. |
| 15 | COPPER_LINK_STAT<br>US | RO | Copper link partner status:<br>• 1: Copper interface link is up.<br>• 0: Copper interface link is down. |

]











##### 5.2.3.3. SGMII PHY Mode Auto Negotiation

When the SGMII mode and the SGMII PHY mode auto-negotiation is enabled, set the
dev_ability register before the auto-negotiation process so that the link partner
can identify the copper speed, duplex status, and link status.
When the auto-negotiation is complete, Triple-Speed Ethernet Intel FPGA IP speed and
the duplex mode will be resolved based on the value that you set in the dev_ability
register. You can get the value for the dev_ability register from the system level
where the Triple-Speed Ethernet Intel FPGA IP is integrated. If the IP is integrated in
the system level with another IP that resolves the copper speed and duplex
information, use these values to set the dev_ability register.
**Table 52. Dev_Ability Register Bits Description in SGMII PHY Mode**

| Bit(s) | Name | R/W | Description |
| --- | --- | --- | --- |
| 9:0 | Reserved | — | Always set bit 0 to 1 and bits 1–9 to 0. |
| 11:10 | SPEED[1:0] | RW | Link partner interface speed: |
|  |  |  | • 00: Copper interface speed is 10 Mbps.<br>• 01: Copper interface speed is 100 Mbps.<br>• 10: Copper interface speed is 1 gigabit.<br>• 11: Reserved. |
| 12 | COPPER_DUPLEX_ST<br>ATUS | RW | Link partner duplex capability:<br>• 1: Copper interface is capable of operating in full-duplex mode<br>• 0: Copper interface is capable of operating in half-duplex mode<br>• 1 Gbps speed does not support half-duplex mode. |
| 13 | Reserved | — | Always set this bit to 0. |
| 14 | ACK | RO | Acknowledge. Value as specified in the IEEE 802.3z standard. |
| 15 | COPPER_LINK_STAT<br>US | RW | Copper link partner status:<br>• 1: Copper interface link is up.<br>• 0: Copper interface link is down. |


## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
102

<!-- PDF page 103 -->










#### 5.2.4. An_Expansion Register (Word Offset 0x06)

**Table 53. An_Expansion Register Description**

| Bit(s) | Name | R/W | Description |
| --- | --- | --- | --- |
| 0 | LINK_PARTNER_AUT<br>O_NEGOTIATION_AB<br>LE | RO | A value of 1 indicates that the link partner supports auto-negotiation.<br>The reset value is 0. |
| 1 | PAGE_RECEIVE | RO | A value of 1 indicates that a new page is received with new partner<br>ability available in the register partner_ability. The bit is set to 0<br>(reset value) when the system management agent performs a read<br>access. |
| 2 | NEXT_PAGE_ABLE | — | Unused. Always set to 0. |
| 15:3 | Reserved | — | — |








#### 5.2.5. If_Mode Register (Word Offset 0x14)

**Table 54. IF_Mode Register Description**

| Bit(s) | Name | R/W | Description |
| --- | --- | --- | --- |
| 0 | SGMII_ENA | RW | Determines the PCS function operating mode. Setting this bit to 1<br>enables SGMII mode. Setting this bit to 0 enables 1000BASE-X<br>gigabit mode. |
| 1 | USE_SGMII_AN | RW | This bit applies only to SGMII mode. Setting this bit to 1 causes the<br>PCS function to be configured with the link partner abilities advertised<br>during auto-negotiation. If this bit is set to 0, it is recommended for<br>the PCS function to be configured with the SGMII_SPEED and<br>SGMII_DUPLEX bits. |
| 3:2 | SGMII_SPEED[1:0] | RW | SGMII speed. When the PCS function operates in SGMII mode<br>(SGMII_ENA = 1) and programed not to be automatically configured<br>(USE_SGMII_AN = 0), set the speed as follows:<br>• 00: 10 Mbps<br>• 01: 100 Mbps<br>• 10: 1 Gigabit<br>• 11: Reserved |
|  |  |  | These bits are ignored when SGMII_ENA is 0 or USE_SGMII_AN is 1.<br>These bits are only valid if you only enable the SGMII mode and not<br>the auto-negotiation mode. |
| 4 | SGMII_DUPLEX | RW | SGMII half-duplex mode. Setting this bit to 1 enables half duplex for<br>10/100 Mbps speed. This bit is ignored when SGMII_ENA is 0 or<br>USE_SGMII_AN is 1. These bits are only valid if you only enable the<br>SGMII mode and not the auto-negotiation mode. |
| 5 | SGMII_AN_MODE | RW | SGMII auto-negotiation mode:<br>• 1: enable SGMII PHY mode<br>• 0: enable SGMII MAC mode<br>This bit resets to 0, which defaults to SGMII MAC mode. |
| 15:6 | Reserved | — | — |






## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
103

<!-- PDF page 104 -->






### 5.3. Register Initialization

The Triple-Speed Ethernet Intel FPGA IP supports various types of interface commonly
used by the following Ethernet solutions:
• MII/GMII
• RGMII
• 10-bit Interface
• 1000BASE-X
• Management Data Input/Output (MDIO) for external PHY register configuration
When using the Triple-Speed Ethernet Intel FPGA IP with an external interface, you
must understand the requirements and initialize the registers.
Register initialization mainly performed in the following configurations:
• External PHY Initialization using MDIO (Optional)
• PCS Configuration Register Initialization
• MAC Configuration Register Initialization
This section discusses the register initialization for the following examples of the
Ethernet system using different MAC interfaces with recommended initialization
sequences:
• Triple-Speed Ethernet System with MII/GMII or RGMII on page 104
• Triple-Speed Ethernet System with SGMII on page 107
• Triple-Speed Ethernet System with 1000BASE-X Interface on page 108

#### 5.3.1. Triple-Speed Ethernet System with MII/GMII or RGMII


## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
104

<!-- PDF page 105 -->

Figure 45. Triple-Speed Ethernet System with MII/GMII or RGMII with Register
Initialization Recommendation
10/100/1000 Mbps MAC External PHY
MACRegisterSpace
MDIO Space 0
MDIO Space 1 MDIOHost
PHYRegisterSpace
MDIOSlave
Avalon Streaming Interface TX
Avalon Streaming Interface RX
Avalon Memory-Mapped Interface
Copper/Fiber
Interface
MII/GMII/RGMII Interface
MDIO
Use the following recommended initialization sequences for the example shown in the
figure above.

## 1. External PHY Initialization using MDIO

//Assume the External PHY Address is 0x0A
mdio_addr0 = 0x0A
//External PHY Register will Map to MDIO Space 0
Read/write to MDIO space 0 (dword offset 0x80 - 0x9F) = Read/write to PHY
Register 0 to 31

## 2. MAC Configuration Register Initialization

a. Disable MAC Transmit and Receive DatapathDisable the MAC transmit and
receive datapath before performing any changes to configuration.
//Set TX_ENA and RX_ENA bit to 0 in Command Config Register
Command_config Register = 0x00802220
//Read the TX_ENA and RX_ENA bit is set 0 to ensure TX and RX path is
disable
Wait Command_config Register = 0x00802220
b. MAC FIFO Configuration
Tx_section_empty = Max FIFO size - 16
Tx_almost_full = 3
Tx_almost_empty = 8
Rx_section_empty = Max FIFO size - 16
Rx_almost_full = 8
Rx_almost_empty = 8
//Cut Through Mode, Set this Threshold to 0 to enable Store and Forward
Mode
Tx_section_full = 16
//Cut Through Mode, Set this Threshold to 0 to enable Store and Forward
Mode

## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
105

<!-- PDF page 106 -->

Rx_section_full = 16
c. MAC Address Configuration
//MAC address is 00-1C-23-17-4A-CB
mac_0 = 0x17231C00
mac_1 = 0x0000CB4A
d. MAC Function Configuration
//Maximum Frame Length is 1518 bytes
Frm_length = 1518
//Minimum Inter Packet Gap is 12 bytes
Tx_ipg_length = 12
//Maximum Pause Quanta Value for Flow Control
Pause_quant = 0xFFFF
//Set the MAC with the following option:
// 100Mbps, User can get this information from the PHY status/PCS status
//Full Duplex, User can get this information from the PHY status/PCS status
//Padding Removal on Receive
//CRC Removal
//TX MAC Address Insertion on Transmit Packet
//Select mac_0 and mac_1 as the source MAC Address
Command_config Register = 0x00800220
e. Reset MAC
Intel recommends that you perform a software reset when there is a change in
the MAC speed or duplex. The MAC software reset bit self-clears when the
software reset is complete.
//Set SW_RESET bit to 1
Command_config Register = 0x00802220
Wait Command_config Register = 0x00800220
f. Enable MAC Transmit and Receive Datapath
//Set TX_ENA and RX_ENA to 1 in Command Config Register
Command_config Register = 0x00800223
//Read the TX_ENA and RX_ENA bit is set 1 to ensure TX and RX path is
enable
Wait Command_config Register = 0x00800223

## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
106

<!-- PDF page 107 -->


#### 5.3.2. Triple-Speed Ethernet System with SGMII

Figure 46. Triple-Speed Ethernet System with SGMII with Register Initialization
Recommendation
10/100/1000 Mbps MAC External PHY
MACRegisterSpace
MDIO Space 0
MDIO Space 1 MDIOHost
PHYRegisterSpace
MDIOSlave
AvalonStreaming TX
AvalonStreaming RX
AvalonMemory-MappedInterface
Copper/FiberInterface
SGMII Interface (1.25 Gbps)
MDIO
1000BASE-X/SGMII PCS
PCSRegisterSpace
Use the following recommended initialization sequences for the example shown in the
figure above.

## 1. External PHY Initialization using MDIO

Refer to step 1 in Triple-Speed Ethernet System with MII/GMII or RGMII on page
104.

## 2. PCS Configuration Register Initialization

a. Set Auto Negotiation Link Timer
//Set Link timer to 1.6ms for SGMII
link_timer (address offset 0x12) = 0x0D40
Link_timer (address offset 0x13) = 0x03
b. Configure SGMII
//Enable SGMII Interface and Enable SGMII Auto Negotiation
//SGMII_ENA = 1, USE_SGMII_AN = 1
if_mode = 0x0003
c. Enable Auto Negotiation
//Enable Auto Negotiation
//AUTO_NEGOTIATION_ENA = 1, Bit 6,8,13 can be ignore
PCS Control Register = 0x1140
d. PCS Reset
//PCS Software reset is recommended where there any configuration changed
//RESET = 1
PCS Control Register = 0x9140
Wait PCS Control Register RESET bit is clear

## 3. MAC Configuration Register Initialization

Refer to step 2 in Triple-Speed Ethernet System with MII/GMII or RGMII on page
104.

## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
107

<!-- PDF page 108 -->

Note: If 1000BASE-X/SGMII PCS is initialized, set the ETH_SPEED (bit 3) and ENA_10
(bit 25) in command_config register to 0. If half duplex is reported in the PHY/PCS
status register, set the HD_ENA (bit 10) to 1 in command_config register.

#### 5.3.3. Triple-Speed Ethernet System with 1000BASE-X Interface

Figure 47. Triple-Speed Ethernet System with 1000BASE-X Interface with Register
Initialization Recommendation
10/100/1000 Mbps MAC 1000BASE-XOptical Tranceiver (SFP)
MACRegisterSpace
MDIO Space 0
MDIO Space 1 MDIOHost
AvalonStreaming TX
AvalonStreaming RX
AvalonMemory-MappedInterface
FiberInterface
1000BASE-X Interface (1.25 Gbps)
1000BASE-X/SGMII PCS
PCSRegisterSpace
PMA
Use the following recommended initialization sequences for the example shown in the
figure above.

## 1. External PHY Initialization using MDIO

Refer to step 1 in Triple-Speed Ethernet System with MII/GMII or RGMII on page
104.

## 2. PCS Configuration Register Initialization

a. Set Auto Negotiation Link Timer
//Set Link timer to 10ms for 1000BASE-X
link_timer (address offset 0x12) = 0x12D0
link_timer (address offset 0x13) = 0x13
b. Configure SGMII
//1000BASE-X/SGMII PCS is default in 1000BASE-X Mode
//SGMII_ENA = 0, USE_SGMII_AN = 0
if_mode = 0x0000
c. Enable Auto Negotiation
//Enable Auto Negotiation
//AUTO_NEGOTIATION_ENA = 1, Bit 6,8,13 is Read Only
PCS Control Register = 0x1140
d. PCS Reset
//PCS Software reset is recommended where there any configuration changed
//RESET = 1
PCS Control Register = 0x9140
Wait PCS Control Register RESET bit is clear

## 3. MAC Configuration Register Initialization


## 5. Configuration Register Space


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
108

<!-- PDF page 109 -->

Refer to step 2 in Triple-Speed Ethernet System with MII/GMII or RGMII on page
104.
Note: If 1000BASE-X/SGMII PCS is initialized, set the ETH_SPEED (bit 3) and ENA_10
(bit 25) in command_config register to 0. If half duplex is reported in the PHY/PCS
status register, set the HD_ENA (bit 10) to 1 in command_config register.

## 5. Configuration Register Space


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
109

<!-- PDF page 110 -->


## 6. Interface Signals


### 6.1. Interface Signals

The following sections describe the Triple-Speed Ethernet Intel FPGA IP interface
signals:
• 10/100/1000 Ethernet MAC Signals on page 111
• 10/100/1000 Multiport Ethernet MAC Signals on page 119
• 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII PCS Signals on page 122
• 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS and Embedded
PMA Signals (E-Tile) on page 126
• 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS and Embedded
PMA Signals (F-Tile) on page 129
• 10/100/1000 Ethernet MAC Without Internal FIFO Buffers with 1000BASE-X/SGMII
2XTBI PCS Signals on page 131
• 10/100/1000 Ethernet MAC Without Internal FIFO Buffers with IEEE 1588v2 and
1000BASE-X/SGMII 2XTBI PCS Signals on page 133
• 10/100/1000 Ethernet MAC Without Internal FIFO Buffers with IEEE 1588v2,
1000BASE-X/SGMII 2XTBI PCS, SGMII Bridge, and Deterministic Latency Signals
on page 135
• 10/100/1000 Multiport Ethernet MAC with 1000BASE-X/SGMII PCS Signals on
page 138
• 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII PCS and Embedded PMA
Signals on page 140
• 10/100/1000 Multiport Ethernet MAC with 1000BASE-X/SGMII PCS and Embedded
PMA Signals on page 143
• 1000BASE-X/SGMII PCS Signals on page 149
• 1000BASE-X/SGMII 2XTBI PCS Signals on page 153
• 1000BASE-X/SGMII PCS and PMA Signals on page 155
Note: To view all the interface signal names, turn on Show Signals in the Block Diagram
tab in the Triple-Speed Ethernet Intel FPGA IP parameter editor interface. Otherwise,
only the connection signal names are shown.

# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 111 -->


#### 6.1.1. 10/100/1000 Ethernet MAC Signals

Figure 48. 10/100/1000 Ethernet MAC Function with Internal FIFO Buffers Signals
10/100/1000 Ethernet MAC
PHY Management Signals
mdio_in
mdc
mdio_oen
mdio_out
Pause and Magic Packet Signals
xon_gen
xoff_gen
magic_wakeup
magic_sleep_n
ff_rx_clk
MACStatus Signals
ClockSignalsrx_clk
tx_clk
rx_clkena
tx_clkena
Reset Signalreset
n
2
MAC Transmit Interface Signals ff_tx_crc_fwd
ff_tx_data[DATAWIDTH-1:0]
ff_tx_eop
ff_tx_err
ff_tx_sop
ff_tx_wren
tx_ff_uflow
ff_tx_clk
ff_tx_rdy
ff_tx_septy
ff_tx_mod[1:0]
ff_tx_a_full
ff_tx_a_empty
2
n
6
18
4
MAC Receive Interface Signals
ff_rx_data[DATAWIDTH-1:0]
ff_rx_mod[1:0]
ff_rx_eop
ff_rx_sop
rx_err[5:0]
rx_err_stat[17:0]
rx_frm_type[3:0]
ff_rx_dsav
ff_rx_rdy
ff_rx_dval
ff_rx_a_full
ff_rx_a_empty
32
32
MAC Control InterfaceSignals
clk
reg_addr[7:0]
reg_rd
reg_wr
reg_data_out[31:0]
reg_data_in[31:0]
reg_busy
8
4
4
MII Signals
m_rx_d[3:0]
m_rx_en
m_rx_err
m_rx_col
m_rx_crs
m_tx_d[3:0]
m_tx_en
m_tx_err
8
GMII Signals
gm_rx_d[7:0]
gm_rx_dv
gm_rx_err
gm_tx_d[7:0]
gm_tx_en
gm_tx_err
8
4
4
RGMII Signalsrgmii_out[3:0]
tx_control
rgmii_in[3:0]
rx_control
ECC Status Signalmac_eccstatus[1:0]
set_10_n
set_1000_n
ena_10_n
eth_mode_n
(1)
(1)
Clock EnablerSignals
Note to 10/100/1000 Ethernet MAC Function with Internal FIFO Buffers Signals:

## 1. The DATAWIDTH value depends on the FIFO width that you select in the parameter

editor. Options available are 8 and 32 bits.

##### 6.1.1.1. Clock and Reset Signals

Data transfers on the MAC Ethernet-side interface are synchronous to the receive and
transmit clocks.

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
111

<!-- PDF page 112 -->

**Table 55. GMII/RGMII/MII Clock Signals**

| Name | I/O | Description |
| --- | --- | --- |
| tx_clk<br>(In Platform Designer:<br>pcs_mac_tx_clock_co<br>nnection) | I | GMII/RGMII/MII transmit clock. Provides the timing reference for all GMII / MII<br>transmit signals. The values of gm_tx_d[7:0], gm_tx_en, gm_tx_err, and of<br>m_tx_d[3:0], m_tx_en, m_tx_err are valid on the rising edge of tx_clk. |
| rx_clk<br>(In Platform Designer:<br>pcs_mac_rx_clock_co<br>nnection) | I | GMII/RGMII/MII receive clock. Provides the timing reference for all rx related<br>signals. The values of gm_rx_d[7:0], gm_rx_dv, gm_rx_err, and of<br>m_rx_d[3:0], m_rx_en, m_rx_err are valid on the rising edge of rx_clk. |

**Table 56. Reset Signal**

| Name | I/O | Description |
| --- | --- | --- |
| reset | I | Assert this signal to reset all logic in the MAC and PCS control interface. The signal<br>must be asserted for at least three clock cycles. |


##### 6.1.1.2. Clock Enabler Signals

**Table 57. Clock Enabler Signals**

| Name | I/O | Description |
| --- | --- | --- |
| tx_clkena | I | Clock enable from the PHY IP. When you turn on the Use clock enable for MAC<br>parameter, this signal is used together with tx_clk and rx_clk to generate 125<br>MHz, 25 MHz, and 2.5 MHz clocks. (14) |
| rx_clkena | I | Clock enable from the PHY IP. When you turn on the Use clock enable for MAC<br>parameter, this signal is used together with tx_clk and rx_clk to generate 125<br>MHz, 25 MHz, and 2.5 MHz clocks. (15) |


##### 6.1.1.3. MAC Control Interface Signals

The MAC control interface is an Avalon memory-mapped slave port that provides
access to the register space.
**Table 58. MAC Control Interface Signals**

| Name | Avalon<br>Memory-<br>Mapped<br>Signal Type | I/O | Description |
| --- | --- | --- | --- |
| clk | clk | I | Register access reference clock. Set the signal to a value less than<br>or equal to 125 MHz. |
| reg_wr | write | I | Register write enable. |
| reg_rd | read | I | Register read enable. |
| reg_addr[7:0] | address | I | 32-bit word-aligned register address. |
| reg_data_in[31:0] | writedata | I | Register write data. Bit 0 is the least significant bit. |
| reg_data_out[31:0] | readdata | O | Register read data. Bit 0 is the least significant bit. |
| reg_busy | waitreques<br>t | O | Register interface busy. Asserted during register read or register<br>write access; deasserted when the current register access<br>completes.<br>This signal can be high or low during idle cycles and reset.<br>Therefore, the user application must not make any assumption of<br>its assertion state during these periods. |

(14) For configurations without internal FIFO, this signal is called tx_clkena_<n>.
(15) For configurations without internal FIFO, this signal is called rx_clkena_<n>.

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
112

<!-- PDF page 113 -->


##### 6.1.1.4. MAC Status Signals

The MAC status signals which allow you to set the transfer mode of the Ethernet-side
**Table 59. MAC Status Signals**

| Name | I/O | Description |
| --- | --- | --- |
| eth_mode | O | Ethernet mode. This signal is set to 1 when the MAC function is configured to<br>operate at 1000 Mbps; set to 0 when it is configured to operate at 10/100 Mbps. |
| ena_10 | O | 10 Mbps enable. This signal is set to 1 to indicate that the PHY interface should<br>operate at 10 Mbps. Valid only when the eth_mode signal is set to 0. |
| set_1000 | I | Gigabit mode selection. Can be driven to 1 by an external device, for example a<br>PHY device, to set the MAC function to operate in gigabit. When set to 0, the MAC<br>is set to operate in 10/100 Mbps. This signal is ignored when the ETH_SPEED bit in<br>the command_config register is set to 1. |
| set_10 | I | 10 Mbps selection. Can be driven to 1 by an external device, for example a PHY<br>device, to indicate that the MAC function is connected to a 10-Mbps PHY device.<br>When set to 0, the MAC function is set to operate in 100-Mbps or gigabit mode.<br>This signal is ignored when the ETH_SPEED or ENA_10 bit in the<br>command_config register is set to 1. The ENA_10 bit has a higher priority than<br>this signal. |


##### 6.1.1.5. MAC Receive Interface Signals

**Table 60. MAC Receive Interface Signals**

| Name | Avalon<br>Streaming<br>Signal Type | I/O | Description |
| --- | --- | --- | --- |
| Avalon Streaming Signals |  |  |  |
| ff_rx_clk<br>(In Platform Designer:<br>receive_clock_conne<br>ction) | clk | I | Receive clock. All signals on the Avalon streaming receive interface<br>are synchronized on the rising edge of this clock. Set this clock to<br>the frequency required to get the desired bandwidth on this<br>interface. This clock can be completely independent from rx_clk. |
| ff_rx_dval | valid | O | Receive data valid. When asserted, this signal indicates that the<br>data on the following signals are valid: ff_rx_data[(DATAWIDTH<br>-1):0], ff_rx_sop, ff_rx_eop, rx_err[5:0],<br>rx_frm_type[3:0], and rx_err_stat[17:0]. |
| ff_rx_data<br>[(DATAWIDTH-1):0] | data | O | Receive data. When DATAWIDTH is 32, the first byte received is<br>ff_rx_data[31:24] followed by ff_rx_data[23:16] and so<br>forth. |
| ff_rx_mod[1:0] | empty | O | Receive data modulo. Indicates invalid bytes in the final frame<br>word:<br>• 11: ff_rx_data[23:0] is not valid<br>• 10: ff_rx_data[15:0] is not valid<br>• 01: ff_rx_data[7:0] is not valid<br>• 00: ff_rx_data[31:0] is valid<br>This signal applies only when DATAWIDTH is set to 32. |
| ff_rx_sop | startofpac<br>ket | O | Receive start of packet. Asserted when the first byte or word of a<br>frame is driven on ff_rx_data[(DATAWIDTH-1):0]. |
| ff_rx_eop | endofpacke<br>t | O | Receive end of packet. Asserted when the last byte or word of<br>frame data is driven on ff_rx_data[(DATAWIDTH-1):0]. |
| ff_rx_rdy | ready | I | Receive application ready. Assert this signal on the rising edge of<br>ff_rx_clk when the user application is ready to receive data<br>from the MAC function. |
| rx_err[5:0] | error | O | Receive error. Asserted with the final byte in the frame to indicate<br>that an error was detected when receiving the frame. See Table 62<br>on page 115 for the bit description. |
| Component-Specific Signals |  |  |  |
| ff_rx_dsav | — | O | Receive frame available. When asserted, this signal indicates that<br>the internal receive FIFO buffer contains some data to be read but<br>not necessarily a complete frame. The user application may want<br>to start reading from the FIFO buffer.<br>This signal remains deasserted in the store and forward mode. |
| rx_frm_type[3:0] | — | O | Frame type. See Table 61 on page 114 for the bit description. |
| ff_rx_a_full | — | O | Asserted when the FIFO buffer reaches the almost-full threshold. |
| ff_rx_a_empty | — | O | Asserted when the FIFO buffer goes below the almost-empty<br>threshold. |
| rx_err_stat[17:0] | — | O | rx_err_stat[17]: One indicates that the receive frame is a<br>stacked VLAN frame.<br>rx_err_stat[16]: One indicates that the receive frame is either<br>a VLAN or stacked VLAN frame.<br>rx_err_stat[15:0]: The value of the length/type field of the<br>receive frame. |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
113

<!-- PDF page 114 -->

**Table 61. rx_frm_type Bit Description**

| Bit | Description |
| --- | --- |
| 3 | Indicates VLAN frames. Asserted with ff_rx_sop and remains asserted until the end of<br>the frame. |
| 2 | Indicates broadcast frames. Asserted with ff_rx_sop and remains asserted until the end<br>of the frame. |
| 1 | Indicates multicast frames. Asserted with ff_rx_sop and remains asserted until the end<br>of the frame. |
| 0 | Indicates unicast frames. Asserted with ff_rx_sop and remains asserted until the end of<br>the frame. |










## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
114

<!-- PDF page 115 -->

**Table 62. rx_err Bit Description**

| Bit | Description |
| --- | --- |
| 5 | Collision error. Asserted when the frame was received with a collision. |
| 4 | Corrupted receive frame caused by PHY or PCS error. Asserted when the error is detected<br>on the MII/GMII/RGMII. |
| 3 | Truncated receive frame. Asserted when the receive frame is truncated due to an overflow<br>in the receive FIFO buffer. |
| 2 (16) | CRC error. Asserted when the frame is received with a CRC-32 error. This error bit applies<br>only to frames with a valid length. Refer to Length Checking on page 43. |
| 1 (16) | Invalid length error. Asserted when the receive frame has an invalid length as defined by<br>the IEEE Standard 802.3. For more information on the frame length, refer to Length<br>Checking on page 43. |
| 0 | Receive frame error. Indicates that an error has occurred. It is the logical OR of<br>rx_err[5:1]. |














##### 6.1.1.6. MAC Transmit Interface Signals

**Table 63. MAC Transmit Interface Signals**

| Name | Avalon<br>Streaming<br>Signal Type | I/O | Description |
| --- | --- | --- | --- |
| Avalon Streaming Signals |  |  |  |
| ff_tx_clk<br>(In Platform Designer:<br>transmit_clock_conn<br>ection) | clk | I | Transmit clock. All transmit signals are synchronized on the rising<br>edge of this clock.<br>Set this clock to the required frequency to get the desired<br>bandwidth on the Avalon streaming transmit interface. This clock<br>can be completely independent from tx_clk. |
| ff_tx_wren | valid | I | Transmit data write enable. Assert this signal to indicate that the<br>data on the following signals are valid:<br>ff_tx_data[(DATAWIDTH-1):0], ff_tx_sop, and ff_tx_eop.<br>In cut-through mode, keep this signal asserted throughout the<br>frame transmission. Otherwise, the frame is truncated and<br>forwarded to the Ethernet-side interface with an error. |
| ff_tx_data[(DATAWID<br>TH-1):0] | data | I | Transmit data. DATAWIDTH can be either 8 or 32 depending on the<br>FIFO data width configured. When DATAWIDTH is 32, the first byte<br>transmitted is ff_tx_data[31:24] followed by<br>ff_tx_data[23:16] and so forth. |
| ff_tx_mod[1:0] | empty | I | Transmit data modulo. Indicates invalid bytes in the final frame<br>word:<br>• 11: ff_tx_data[23:0] is not valid<br>• 10: ff_tx_data[15:0] is not valid<br>• 01: ff_tx_data[7:0] is not valid<br>• 00: ff_tx_data[31:0] is valid<br>This signal applies only when DATAWIDTH is set to 32. |
| ff_tx_sop | startofpac<br>ket | I | Transmit start of packet. Assert this signal when the first byte in<br>the frame (the first byte of the destination address) is driven on<br>ff_tx_data. |
| ff_tx_eop | endofpacke<br>t | I | Transmit end of packet. Assert this signal when the last byte in the<br>frame (the last byte of the FCS field) is driven on ff_tx_data. |
| ff_tx_err | error | I | Transmit frame error. Assert this signal with the final byte in the<br>frame to indicate that the transmit frame is invalid. The MAC<br>function forwards the invalid frame to the GMII with an error. |
| ff_tx_rdy | ready | O | MAC ready. When asserted, the MAC function is ready to accept<br>data from the user application. |
| Component-Specific Signals |  |  |  |
| ff_tx_crc_fwd | — | I | Transmit CRC insertion. Set this signal to 0 when ff_tx_eop is set<br>to 1 to instruct the MAC function to compute a CRC and insert it<br>into the frame. If this signal is set to 1, the user application is<br>expected to provide the CRC. |
| tx_ff_uflow | — | O | Asserted when an underflow occurs on the transmit FIFO buffer. |
| ff_tx_septy | — | O | Deasserted when the FIFO buffer is filled to or above the section-<br>empty threshold defined in the tx_section_empty register. User<br>applications can use this signal to indicate when to stop writing to<br>the FIFO buffer and initiate backpressure. |
| ff_tx_a_full | — | O | Asserted when the transmit FIFO buffer reaches the almost- full<br>threshold. |
| ff_tx_a_empty | — | O | Asserted when the transmit FIFO buffer goes below the almost-<br>empty threshold. |

(16) Bits 1 and 2 are not mutually exclusive. Ignore CRC error rx_err[2] signal if it is asserted at
the same time as the invalid length error rx_err[1] signal.

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
115

<!-- PDF page 116 -->


##### 6.1.1.7. Pause and Magic Packet Signals

The pause and magic packet signals are component-specific signals.
**Table 64. Pause and Magic Packet Signals**

| Name | I/O | Description |
| --- | --- | --- |
| xon_gen | I | Assert this signal for at least 1 tx_clk clock cycle to trigger the generation of a<br>pause frame with a 0 pause quanta. The MAC function generates the pause frame<br>independent of the status of the receive FIFO buffer.<br>This signal is not in use in the following conditions:<br>• Ignored when the xon_gen bit in the command_config register is set to 1.<br>• Absent when the Enable full duplex flow control option is turned off. |
| xoff_gen | I | Assert this signal for at least one tx_clk clock cycle to trigger the generation of a<br>pause frame with a pause quanta configured in the pause_quant register. The<br>MAC function generates the pause frame independent of the status of the receive<br>FIFO buffer.<br>This signal is not in use in the following conditions:<br>• Ignored if the xoff_gen bit in the command_config register is set to 1.<br>• Absent when the Enable full duplex flow control option is turned off. |
| magic_sleep_n | I | Assert this active-low signal to put the node into a power-down state.<br>If magic packets are supported (the MAGIC_ENA bit in the command_config<br>register is set to 1), the receiver logic stops writing data to the receive FIFO buffer<br>and the magic packet detection logic is enabled. Setting this signal to 1 restores<br>the normal frame reception mode. |
|  |  | This signal is present only if the Enable magic packet detection option is turned<br>on. |
| magic_wakeup | O | If the MAC function is in the power-down state, the MAC function asserts this<br>signal to indicate that a magic packet has been detected and the node is requested<br>to restore its normal frame reception mode.<br>This signal is present only if the Enable magic packet detection option is turned<br>on. |


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
116

<!-- PDF page 117 -->


##### 6.1.1.8. MII/GMII/RGMII Signals

**Table 65. GMII/RGMII/MII Signals**

| Name | I/O | Description |
| --- | --- | --- |
| GMII Transmit |  |  |
| gm_tx_d[7:0] | I | GMII transmit data bus. |
| gm_tx_en | O | Asserted to indicate that the data on the GMII transmit data bus is valid. |
| gm_tx_err | O | Asserted to indicate to the PHY that the frame sent is invalid. |
| GMII Receive |  |  |
| gm_rx_d[7:0] | I | GMII receive data bus. |
| gm_rx_dv | I | Assert this signal to indicate that the data on the GMII receive data bus is valid.<br>Keep this signal asserted during frame reception, from the first preamble byte until<br>the last byte of the CRC field is received. |
| gm_rx_err | I | The PHY asserts this signal to indicate that the receive frame contains errors. |
| RGMII Transmit |  |  |
| rgmii_out[3:0] | O | RGMII transmit data bus. Drives gm_tx_d[3:0] on the positive edge of tx_clk<br>and gm_tx_d[7:4] on the negative edge of tx_clk. |
| tx_control | O | Control output signal. Drives gm_tx_en on the positive edge of tx_clk and a<br>logical derivative of (gm_tx_en XOR gm_tx_err) on the negative edge of<br>tx_clk. |
| RGMII Receive |  |  |
| rgmii_in[3:0] | I | RGMII receive data bus. Expects gm_rx_d[3:0] on the positive edge of rx_clk<br>and gm_rx_d[7:4] on the negative edge of rx_clk. |
| rx_control | I | RGMII control input signal. Expects gm_rx_dv on the positive edge of rx_clk and<br>a logical derivative of (gm_rx_dv XOR gm_rx_err) on the negative edge of<br>rx_clk. |
| MII Transmit |  |  |
| m_tx_d[3:0] | O | MII transmit data bus. |
| m_tx_en | O | Asserted to indicate that the data on the MII transmit data bus is valid. |
| m_tx_err | O | Asserted to indicate to the PHY device that the frame sent is invalid. |
| MII Receive |  |  |
| m_rx_d[3:0] | I | MII receive data bus. |
| m_rx_en | I | Assert this signal to indicate that the data on the MII receive data bus is valid.<br>Keep this signal asserted during frame reception, from the first preamble byte until<br>the last byte of the CRC field is received. |
| m_rx_err | I | The PHY asserts this signal to Indicate that the receive frame contains errors. |
| MII PHY Status |  |  |
| m_rx_col | I | Collision detection. The PHY asserts this signal to indicate a collision during frame<br>transmission. This signal is not used in full- duplex or gigabit mode. |
| m_rx_crs | I | Carrier sense detection. The PHY asserts this signal to indicate that it has detected<br>transmit or receive activity on the Ethernet line. This signal is not used in full-<br>duplex or gigabit mode. |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
117

<!-- PDF page 118 -->


##### 6.1.1.9. PHY Management Signals

**Table 66. PHY Management Interface Signals**

| Name | I/O | Description |
| --- | --- | --- |
| mdio_in | I | Management data input. |
| mdio_out | O | Management data output. |
| mdio_oen | O | An active-low signal that enables mdio_in or mdio_out. For more information<br>about the MDIO connection, refer to MDIO Connection on page 55. |
| mdc | O | Management data clock. Generated from the Avalon memory-mapped interface<br>clock signal, clk. Specify the division factor using the Host clock divisor<br>parameter such that the frequency of this clock does not exceed 2.5 MHz. For<br>more information about the parameters, refer to Ethernet MAC Options on page<br>28.<br>A data bit is shifted in/out on each rising edge of this clock. All fields are shifted in<br>and out starting from the most significant bit. |


##### 6.1.1.10. ECC Status Signals

**Table 67. ECC Status Signals**

| Name | I/O | Description |
| --- | --- | --- |
| mac_eccstatus[1:0] | O | Indicates the ECC status. This signal is synchronized to the reg_clk clock domain.<br>• 11: An uncorrectable error occurred and the error data appears at the output.<br>• 10: A correctable error occurred and the error has been corrected at the output.<br>However, the memory array has not been updated.<br>• 01: Not valid.<br>• 00: No error. |


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
118

<!-- PDF page 119 -->


#### 6.1.2. 10/100/1000 Multiport Ethernet MAC Signals

Figure 49. 10/100/1000 Multiport Ethernet MAC Function without Internal FIFO Buffers
Signals
Multi-Port MAC
PHY Management Signals
mdio_in
mdc
mdio_oen
mdio_out
Pause and Magic Packet Signals
mac_tx_clk_n
mac_rx_clk_n
ClockSignals
xon_gen_n
xoff_gen_n
magic_wakeup_n
magic_sleep_n_n
MAC Status Signals
set_10_n
set_1000_n
ena_10_n
eth_mode_n
Reset Signalreset
ClockSignals
rx_clk_n
tx_clk_n

# 8 data_tx_data_n[7:0]

data_tx_eop_n
data_tx_error_n
data_tx_sop_n
data_tx_valid_n
data_tx_ready_n
MAC Transmit Interface Signals
tx_crc_fwd_n
tx_ff_uflow_n
MAC Receive Interface Signals
5
MAC Packet ClassificationSignals
pkt_class_valid_n
pkt_class_data_n[4:0]
n rx_afull_channel[CHANNEL_WIDTH-1:0]
rx_afull_data[1:0]
rx_afull_validMAC FIFO Status Signals
rx_afull_clk
4
4
MII Signals
m_rx_dv_n
m_rx_err_nm_col_n
m_crs_n
m_tx_en_n
m_tx_err_n
4
4
RGMII Signalsrgmii_out_n[3:0]
8
8
GMII Signals
gm_rx_d_n[7:0]
gm_rx_dv_n
gm_rx_err_n
gm_tx_d_n[7:0]
gm_tx_en_n
gm_tx_err_n
5

# 8 data_rx_data_n[7:0]

data_rx_eop_n
data_rx_sop_n
data_rx_error_n[4:0]
data_rx_ready_n
data_rx_valid_n
2
32
32
MAC Control InterfaceSignals
clk
reg_addr[7:0]
reg_rd
reg_wr
reg_data_out[31:0]
reg_data_in[31:0]
reg_busy
8
mac_eccstatus[1:0]
rx_clkena_ntx_clkena_n
m_tx_d_n[3:0]
ECC StatusSignal
rgmii_in_n[3:0]rx_control_n
tx_control_n
m_rx_d_n[3:0]
Clock EnablerSignals

##### 6.1.2.1. Multiport MAC Clock and Reset Signals

**Table 68. Clock Signals**

| Name | Avalon<br>Streaming<br>Signal Type | I/O | Description |
| --- | --- | --- | --- |
| mac_rx_clk_n | clk | O | Receive MAC clock (2.5/25/125 MHz) for the Avalon streaming<br>receive data and receive packet classification interfaces. |
| mac_tx_clk_n | clk | O | Transmit MAC clock (2.5/25/125 MHz) for the Avalon streaming<br>transmit data interface. |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
119

<!-- PDF page 120 -->


##### 6.1.2.2. Multiport MAC Receive Interface Signals

**Table 69. MAC Receive Interface Signals**

| Name | Avalon<br>Streaming<br>Signal Type | I/O | Description |
| --- | --- | --- | --- |
| data_rx_valid_n | valid | O | Receive data valid. When asserted, this signal indicates that the<br>data on the following signals are valid: data_rx_data_n,<br>data_rx_sop_n, data_rx_eop_n, and data_rx_error_n. |
| data_rx_data_n[7:0] | data | O | Receive data. |
| data_rx_sop_n | startofpac<br>ket | O | Receive start of packet. Asserted when the first byte or word of a<br>frame is driven on data_rx_data_n. |
| data_rx_eop_n | endofpacke<br>t | O | Receive end of packet. Asserted when the last byte or word of<br>frame data is driven on data_rx_data_n. |
| data_rx_ready_n | ready | I | Receive application ready. Assert this signal on the rising edge of<br>data_rx_clk_n when the user application is ready to receive<br>data from the MAC function.<br>If the user application is not ready to receive data, the packet is<br>dropped or truncated with an error. |
| data_rx_error_n[4:0<br>] | error | O | Receive error. Asserted with the final byte in the frame to indicate<br>that an error was detected when receiving the frame. For the<br>description of each bit, refer to the description of bits 5 to 1 in MAC<br>Receive Interface Signals on page 113 . Bit 4 of this signal maps to<br>bit 5 in the table and so forth. |

]

##### 6.1.2.3. Multiport MAC Transmit Interface Signals

**Table 70. MAC Transmit Interface Signals**

| Name | Avalon<br>Streaming<br>Signal Type | I/O | Description |
| --- | --- | --- | --- |
| Avalon Streaming Signals |  |  |  |
| data_tx_valid_n | valid | I | Transmit data valid. Assert this signal to indicate that the data on<br>the following signals are valid: data_tx_data_n,<br>data_tx_sop_n, data_tx_eop_n, and data_tx_error_n. |
| data_tx_data_n[7:0] | data | I | Transmit data. |
| data_tx_sop_n | startofpac<br>ket | I | Transmit start of packet. Assert this signal when the first byte in<br>the frame is driven on data_tx_data_n. |
| data_tx_eop_n | endofpacke<br>t | I | Transmit end of packet. Assert this signal when the last byte in the<br>frame (the last byte of the FCS field) is driven on<br>data_tx_data_n. |
| data_tx_error_n[4:0] | error | I | Transmit frame error. Assert this signal with the final byte in the<br>frame to indicate that the transmit frame is invalid. The MAC<br>function then forwards the frame to the GMII with error. |
| data_tx_ready_n | ready | O | MAC ready. When asserted, this signal indicates that the MAC<br>function is ready to accept data from the user application. |
| Component-Specific Signal |  |  |  |
| tx_crc_fwd_n | — | I | Transmit CRC insertion. Assert this active-low signal when<br>data_tx_eop_n is asserted for the MAC function to compute the<br>CRC and insert it into the frame. Otherwise, the user application is<br>expected to provide the CRC. |


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
120

<!-- PDF page 121 -->


##### 6.1.2.4. Multiport MAC Packet Classification Signals

The MAC packet classification interface is an Avalon streaming source port that
streams out receive packet classifications.
**Table 71. MAC Packet Classification Signals**

| Name | Avalon<br>Streaming<br>Signal Type | I/O | Description |
| --- | --- | --- | --- |
| pkt_class_valid_n | valid | O | When asserted, this signal indicates that the data on the following<br>signals are valid: data_tx_data_n, data_tx_sop_n,<br>data_tx_eop_n, and data_tx_error_n. |
| pkt_class_data_n[4:0<br>] | data | O | Classification presented at the beginning of each packet:<br>Bit 4—Set to 1 for unicast frames.<br>Bit 3—Set to 1 for broadcast frames.<br>Bit 2—Set to 1 for multicast frames.<br>Bit 1—Set to 1 for VLAN frames.<br>Bit 0—Set to 1 for stacked VLAN frames. |

]

##### 6.1.2.5. Multiport MAC FIFO Status Signals

The MAC FIFO status interface is an Avalon streaming sink port which streams in
information on the fill level of the external FIFO buffer to the MAC function.
**Table 72. MAC FIFO Status Signals**

| Signal Name | Avalon<br>Streaming<br>Signal Type | I/O | Description |
| --- | --- | --- | --- |
| rx_afull_valid_n | valid | I | Assert this signal to indicate that the fill level of the external FIFO<br>buffer, rx_afull_data_n[1:0], is valid. |
| rx_afull_data_n[1:0] | data | I | Carries the fill level of the external FIFO buffer:<br>rx_afull_data_n[1]—Set to 1 if the external receive FIFO buffer<br>reaches the initial warning level indicating that it is almost full.<br>Upon detecting this, the MAC function generates pause frames.<br>rx_afull_data_n[0]—Set to 1 if the external receive FIFO buffer<br>reaches the critical level before it overflows. The FIFO buffer can<br>be considered overflow if this bit is set to 1 in the middle of a<br>packet transfer. |
| rx_afull_channel[(C<br>HANNEL_WIDTH-1):0] | channel | I | The port number the status applies to. |
| rx_afull_clk | clk | I | The clock that drives the MAC FIFO status interface. |

**Table 73. References**

| Interface Signal | Section |
| --- | --- |
| Clock and reset signals | Clock and Reset Signals on page 111 |
| MAC control interface | MAC Control Interface Signals on page 112 |
| MAC transmit interface | MAC Transmit Interface Signals on page 115 |
| MAC receive interface | MAC Receive Interface Signals on page 113 |
| Status signals | MAC Status Signals on page 113 |
| Pause and magic packet signals | Pause and Magic Packet Signals on page 116 |
| MII/GMII/RGMII interface | MII/GMII/RGMII Signals on page 117 |
| PHY management signals | PHY Management Signals on page 118 |
| ECC status signals | ECC Status Signals on page 118 |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
121

<!-- PDF page 122 -->


#### 6.1.3. 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII PCS Signals

Figure 50. 10/100/1000 Ethernet MAC Function with Internal FIFO Buffers, with
1000BASE-X/SGMII PCS Signals
10/100/1000 Ethernet MAC with 1000 Base-X PCS/SGMII
Reset
Signalreset
LED
led_an
led_crs
led_col
led_char_err
led_link
led_disp_err
led_panel_link
mdio_in
mdc
mdio_oen
mdio_out
SERDES
Control
sd_loopback
powerdown
Pause and Magic
Packet Signals
xon_gen
xoff_gen
magic_wakeup
magic_sleep_n
n
2
MAC Transmit
ff_tx_crc _fwd
ff_tx_eop
ff_tx_err
ff_tx_sop
ff_tx_wren
tx_ff_uflow
ff_tx_clk
ff_tx_rdy
ff_tx_septy
ff_tx_mod[1:0]
ff_tx_a_full
ff_tx_a_empty
n
2
6
18
4
MAC Receive
ff_rx_mod[1:0]
ff_rx_eop
ff_rx_sop
rx_err[5:0]
rx_err_stat[17:0]
rx_frm_type[3:0]
ff_rx_dsav
ff_rx_rdy
ff_rx_clk
ff_rx_dval
ff_rx_a_full
ff_rx_a_empty
8
32
32
MAC Control
clk
address[7:0]
read
write
readdata[31:0]
writedata[31:0]
waitrequest
Ten Bit
tbi_rx_clk
tbi_rx_d[9:0]
tbi_tx_clk
tbi_tx_d[9:0]
10
10
pcs_eccstatus[1:0]
Intel Arria 10
Transceiver
Native PHY
tx_serial_clk
rx_cdr_refclk
tx_analogreset
tx_digitalreset
rx_analogreset
rx_digitalreset
tx_cal_busy
rx_cal_busy
rx_set_locktodata
rx_set_locktoref
rx_is_locktodata
rx_is_locktoref
ff_rx_data[DATAWIDTH -1:0]
ff_tx_data[DATAWIDTH -1:0](1)
(1)

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
122

<!-- PDF page 123 -->

Note to 10/100/1000 Ethernet MAC Function with Internal FIFO Buffers, with
1000BASE-X/SGMII PCS Signals:

## 1. The DATAWIDTH value depends on the FIFO width that you select in the parameter

editor. Options available are 8 and 32 bits.

##### 6.1.3.1. TBI Interface Signals

If the core variation does not include an embedded PMA, the PCS block provides a
125-MHz ten-bit interface (TBI) to an external SERDES chip.
**Table 74. TBI Interface Signals for External SERDES Chip**

| Name | I/O | Description |
| --- | --- | --- |
| tbi_tx_d[9:0] | O | TBI transmit data. The PCS function transmits data on this bus synchronous to<br>tbi_tx_clk. |
| tbi_tx_clk | I | 125-MHz TBI transmit clock from external SERDES, typically sourced by the local<br>reference clock oscillator. |
| tbi_rx_clk | I | 125-MHz TBI receive clock from external SERDES, typically sourced by the line<br>clock recovered from the encoded line stream. |
| tbi_rx_d[9:0] | I | TBI receive data. This bus carries the data from the external SERDES. Synchronize<br>the bus with tbi_rx_clk. The data can be arbitrary aligned. |


##### 6.1.3.2. Status LED Control Signals

**Table 75. Status LED Interface Signals**

| Name | I/O | Description | Column 4 |
| --- | --- | --- | --- |
| led_link | O | When asserted, this signal indicates a successful link synchronization. |  |
| led_panel_link | O | When asserted, this signal indicates the following behavior: |  |
|  |  | Mode | Signal Behavior |
|  |  | 1000 Base-X without auto negotiation | Similar to led_link |
|  |  | SGMII mode without auto negotiation | Similar to led_link |
|  |  | 1000 Base-X with auto negotiation | Similar to led_an |
|  |  | SGMII mode with MAC mode auto negotiation | Similar to led_an and<br>partner_ability<br>[15] |
|  |  | SGMII mode with PHY mode auto negotiation | Similar to led_an and<br>dev_ability [15] |
| led_crs | O | When asserted, this signal indicates some activities on the transmit and receive<br>paths. When deasserted, it indicates no traffic on the paths. |  |
| led_col | O | When asserted, this signal indicates that a collision was detected during frame<br>transmission. This signal is always deasserted when the PCS function operates in<br>standard 1000BASE-X mode or in full-duplex mode when SGMII is enabled. |  |
| Name | I/O | Description |  |
| led_an | O | Auto-negotiation status. The PCS function asserts this signal when an auto-<br>negotiation completes. |  |
| led_char_err | O | 10-bit character error. Asserted for one tbi_rx_clk cycle when an erroneous 10-<br>bit character is detected. |  |
| led_disp_err | O | 10-bit running disparity error. Asserted for one tbi_rx_clk cycle when a disparity<br>error is detected. A running disparity error indicates that more than the previous<br>and perhaps the current received group had an error. |  |






## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
123

<!-- PDF page 124 -->


##### 6.1.3.3. SERDES Control Signals

**Table 76. SERDES Control Signal**

| Name | I/O | Description |
| --- | --- | --- |
| powerdown | O | Power-down enable. Asserted when the PCS function is in power-down mode;<br>deasserted when the PCS function is operating in normal mode. This signal is<br>implemented only when an external SERDES is used. |
| sd_loopback | O | SERDES Loopback Control. Asserted when the PCS function operates in loopback<br>mode. You can use this signal to configure an external SERDES device to operate<br>in loopback mode. |


##### 6.1.3.4. Intel Arria 10 Transceiver Native PHY Signals

**Table 77. Intel Arria 10 Transceiver Native PHY Signals**

| Name | I/O | Description |
| --- | --- | --- |
| tx_serial_clk | I | Serial clock input from the transceiver PLL. The frequency of this clock is 1250 MHz<br>and the division factor is fixed to divide by 2. |
| rx_cdr_refclk | I | Reference clock input to the receive clock data recovery (CDR) circuitry. The<br>frequency of this clock is 125 MHz. |
| tx_analogreset | I | Resets the analog transmit portion of the transceiver PHY. |
| tx_digitalreset | I | Resets the digital transmit portion of the transceiver PHY. |
| rx_analogreset | I | Resets the analog receive portion of the transceiver PHY. |
| rx_digitalreset | I | Resets the digital receive portion of the transceiver PHY. |
| tx_cal_busy | O | When asserted, this signal indicates that the transmit channel is being calibrated. |
| rx_cal_busy | O | When asserted, this signal indicates that the receive channel is being calibrated. |
| rx_set_locktodata | I | Force the receiver CDR to lock to the incoming data. |
| rx_set_locktoref | I | Force the receiver CDR to lock to the phase and frequency of the input reference<br>clock. |
| rx_is_lockedtodata | O | When asserted, this signal indicates that the CDR PLL is locked to the incoming<br>data rx_serial_data. |
| rx_is_lockedtoref | O | When asserted, this signal indicates that the CDR PLL is locked to the incoming<br>reference clock, rx_cdr_refclk. |

Related Information
Intel Arria 10 Transceiver PHY User Guide
More information about Gigabit Ethernet (GbE) and GbE with 1588, the connection
guidelines for a PHY design, and how to implement GbE/GbE with 1588 in Intel
Arria 10 Transceivers

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
124

<!-- PDF page 125 -->


##### 6.1.3.5. ECC Status Signals

**Table 78. ECC Status Signals**

| Name | I/O | Description |
| --- | --- | --- |
| pcs_eccstatus[1:0] | O | Indicates the ECC status. This signal is synchronized to the reg_clk clock domain.<br>11: An uncorrectable error occurred and the error data appears at the output.<br>10: A correctable error occurred and the error has been corrected at the output.<br>However, the memory array has not been updated.<br>01: Not valid.<br>00: No error. |

For more information on the signals, refer to the respective sections shown in Table 73
on page 121.

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
125

<!-- PDF page 126 -->


#### 6.1.4. 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS

and Embedded PMA Signals (E-Tile)
Figure 51. 10/100/1000 Ethernet MAC Function with Internal FIFO Buffers, and
1000BASE-X/SGMII 2XTBI PCS Signals With Embedded PMA Signals (E-Tile)
Reset
Signalreset
Status LED Signals
led_an
led_crs
led_col
led_char_err
led_link
led_disp_err
tx_clk_125
rx_clk_125MII/GMII Clock Signals
MACControl InterfaceSignals
reg_addr[7:0]
reg_rd
reg_wr
reg_data_out[31:0]
reg_data_in[31:0]
reg_busy
8
32
32
10/100/1000MB Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS
with Embedded PMA
led_panel_link
E-tile Transceiver
Native PHY
Interface
Signals
pll_refclk0rx_serial_data
rx_serial_data_n
rx_is_lockedtodata
rx_ready
MAC Transmit
Interface Signals
MAC Receive
Interface Signals
2
n
ff_tx_err
ff_tx_wren
ff_tx_crc_fwdtx_ff_uflow
ff_tx_rdy
ff_tx_septy
ff_tx_a_full
ff_tx_a_empty
ff_tx_clkff_tx_data[DATAWIDTH -1:0]
ff_tx_mod[1:0]
ff_tx_sop
ff_tx_eop
n
2
6
18
4
ff_rx_eop
rx_err[5:0]
rx_err_stat[17:0]
rx_frm_type[3:0]
ff_rx_dval
ff_rx_a_full
ff_rx_a_empty
ff_rx_clkff_rx_rdy
ff_rx_data[DATAWIDTH -1:0]
ff_rx_mod[1:0]
ff_rx_sop
Pause and Magic Packet Signals
xon_gen
xoff_gen
magic_wakeup
magic_sleep_n
PHY Management Signals
mdio_in
mdc
mdio_oen
mdio_out
tx_clk_62_5rx_clk_62_5
tx_serial_data
tx_serial_data_n
clk
ff_rx_dsav
(1)
(1)
tx_ready
Note to 10/100/1000 Ethernet MAC Function with Internal FIFO Buffers, and
1000BASE-X/SGMII 2XTBI PCS Signals With Embedded PMA Signals:

## 1. The DATAWIDTH value depends on the FIFO width that you select in the parameter

editor. Options available are 8 and 32 bits.

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
126

<!-- PDF page 127 -->

**Table 79. References**

| Interface Signal | Section |
| --- | --- |
| Reset signals | Table 56 on page 112 |
| MAC control interface signals | MAC Control Interface Signals on page 112 |
| Pause and magic packet signals | Pause and Magic Packet Signals on page 116 |
| Status LED control signals | Status LED Control Signals on page 123 |
| MAC transmit interface signals | MAC Transmit Interface Signals on page 115 |
| MAC receive interface signals | MAC Receive Interface Signals on page 113 |
| PHY management | PHY Management Signals on page 118 |
| IEEE 1588v2 Time-of-Day (TOD) clock | IEEE 1588v2 Time-of-Day (TOD) Clock Interface Signals on page 147 |
| IEEE 1588v2 PCS phase management clock | IEEE 1588v2 PCS Phase Measurement Clock Signal on page 147 |
| IEEE 1588v2 TX insert control timestamp<br>interface signals | IEEE 1588v2 TX Insert Control Timestamp Signals on page 146 |
| IEEE 1588v2 TX timestamp request signals | IEEE 1588v2 TX Timestamp Request Signals on page 145 |
| IEEE 1588v2 TX timestamp interface signals | IEEE 1588v2 TX Timestamp Signals on page 145 |
| IEEE 1588v2 RX timestamp interface signals | IEEE 1588v2 RX Timestamp Signals on page 144 |


##### 6.1.4.1. GMII Clock Signals

**Table 80. GMII Clocks**

| Name | I/O | Description |
| --- | --- | --- |
| rx_clk_125 | I | 125 MHz receive clock for the RX datapath on MAC side |
| tx_clk_125 | I | 125 MHz transmit clock for the TX datapath on MAC side. |
| rx_clk_62_5<br>(In Platform Designer:<br>pcs_receive_clock_half_connection) | I | 62.5 MHz receive clock for the RX datapath on PCS side.<br>Intel recommends that this clock and rx_clk_125 share the<br>same clock source. This clock must be synchronous to<br>rx_clk_125. Their rising edges must align and must have 0<br>ppm and phase shift. |
| tx_clk_62_5<br>(In Platform Designer:<br>pcs_transmit_clock_half_connection) | I | 62.5 MHz transmit clock for the TX datapath on PCS side.<br>Intel recommends that this clock and tx_clk_125 share the<br>same clock source. This clock must be synchronous to<br>tx_clk_125. Their rising edges must align and must have 0<br>ppm and phase shift. |

For more information about the clock signals, refer to Clocking Scheme of MAC with
2XTBI PCS and Embedded PMA on page 175.

##### 6.1.4.2. E-Tile Transceiver Native PHY Signals

**Table 81. E-Tile Transceiver Native PHY Signals**

| Name | I/O | Description |
| --- | --- | --- |
| pll_refclk0 | I | Reference clock for the E-tile Native PHY transceiver. Set this clock to 156.25 MHz. |
| rx_serial_data | I | Positive signal for the receiver serial data. |
| rx_serial_data_n | I | Negative signal for the receiver serial data. |
| rx_is_lockedtodata | O | When asserted, this signal indicates that the CDR PLL is locked to the incoming<br>rx_serial data. |
| tx_serial_data | O | Positive signal for the transmitter serial data. |
| tx_serial_data_n | O | Negative signal for the transmitter serial data. |
| rx_ready | O | Status signal from E-tile Native PHY. It is asserted when Native PHY RX datapath<br>resets sequencing is complete. |
| tx_ready | O | Status signal from E-tile Native PHY. It is asserted when Native PHY TX datapath<br>resets sequencing is complete. |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
127

<!-- PDF page 128 -->

Note: For Intel Stratix 10 E-tile and Intel Agilex devices, the reconfig_avmm interface
signals are present when the reconfiguration feature is enabled. Refer to the E-Tile
Transceiver PHY User Guide for more information on the interface signals.
Related Information
E-Tile Transceiver PHY User Guide

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
128

<!-- PDF page 129 -->


#### 6.1.5. 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS

and Embedded PMA Signals (F-Tile)
Figure 52. 10/100/1000 Ethernet MAC Function with Internal FIFO Buffers, and
1000BASE-X/SGMII 2XTBI PCS Signals With Embedded PMA Signals (F-Tile)
Reset
Signalreset
Status LED Signals
led_an
led_crs
led_col
led_char_err
led_link
led_disp_err
tx_clk_125
rx_clk_125MII/GMII Clock Signals
MACControl InterfaceSignals
reg_addr[7:0]
reg_rd
reg_wr
reg_data_out[31:0]
reg_data_in[31:0]
reg_busy
8
32
32
10/100/1000MB Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS
with Embedded PMA (F-Tile)
led_panel_link
in_refclk_fgt_0_in_refclk_fgt_0rx_serial_data
rx_serial_data_n
rx_is_lockedtodata
rx_ready
MAC Transmit
Interface Signals
MAC Receive
Interface Signals
2
n
ff_tx_err
ff_tx_wren
ff_tx_crc_fwdtx_ff_uflow
ff_tx_rdy
ff_tx_septy
ff_tx_a_full
ff_tx_a_empty
ff_tx_clkff_tx_data[DATAWIDTH -1:0]
ff_tx_mod[1:0]
ff_tx_sop
ff_tx_eop
n
2
6
18
4
ff_rx_eop
rx_err[5:0]
rx_err_stat[17:0]
rx_frm_type[3:0]
ff_rx_dval
ff_rx_a_full
ff_rx_a_empty
ff_rx_clkff_rx_rdy
ff_rx_data[DATAWIDTH -1:0]
ff_rx_mod[1:0]
ff_rx_sop
Pause and Magic Packet Signals
xon_gen
xoff_gen
magic_wakeup
magic_sleep_n
PHY Management Signals
mdio_in
mdc
mdio_oen
mdio_out
tx_clk_62_5
rx_clk_62_5
tx_serial_data
tx_serial_data_n
clk
ff_rx_dsav
(1)
tx_ready
phyip_reset_tx_in
phyip_reset_rx_in
phyip_reset_tx_ack_o
phyip_reset_rx_ack_o
(1)
F-Tile TransceiverDirect PHYInterfaceSignals
Note to Figure 52 on page 129:

## 1. The DATAWIDTH value depends on the FIFO width that you select in the parameter

editor. Options available are 8 and 32 bits.

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
129

<!-- PDF page 130 -->

**Table 82. References**

| Interface Signal | Section |
| --- | --- |
| Clock and reset signals | Table 56 on page 112 |
| MAC control interface signals | MAC Control Interface Signals on page 112 |
| Pause and magic packet signals | Pause and Magic Packet Signals on page 116 |
| Status LED control signals | Status LED Control Signals on page 123 |
| MAC transmit interface signals | MAC Transmit Interface Signals on page 115 |
| MAC receive interface signals | MAC Receive Interface Signals on page 113 |
| PHY management | PHY Management Signals on page 118 |


##### 6.1.5.1. F-Tile Transceiver Direct PHY Signals

**Table 83. F-Tile Transceiver Direct PHY Signals**

| Name | I/O | Description |
| --- | --- | --- |
| in_refclk_fgt_0_in_<br>refclk_fgt_0 | I | 156.25 MHz reference clock input to F-tile Direct PHY. |
| phyip_reset_tx_in | I | TX reset input for TX transceivers and TX datapath of F-tile. |
| phyip_reset_rx_in | I | RX reset input for RX transceivers and RX datapath of F-tile. |
| phyip_reset_tx_ack_<br>o | O | TX fully in reset indicator. |
| phyip_reset_rx_ack_<br>o | O | RX fully in reset indicator. |
| rx_serial_data | I | Positive signal for the receiver serial data. |
| rx_serial_data_n | I | Negative signal for the receiver serial data. |
| rx_is_lockedtodata | O | When asserted, this signal indicates that the CDR PLL is locked to the incoming<br>rx_serial data. |
| tx_serial_data | O | Positive signal for the transmitter serial data. |
| tx_serial_data_n | O | Negative signal for the transmitter serial data. |
| tx_ready | O | Status signal from F-tile Native PHY. It is asserted when Native PHY TX datapath<br>resets sequencing is complete. |
| rx_ready | O | Status signal from F-tile Native PHY. It is asserted when Native PHY RX datapath<br>resets sequencing is complete. |

Note: For Intel Agilex F-tile devices, the reconfig_avmm interface signals are present when
the reconfiguration feature is enabled.

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
130

<!-- PDF page 131 -->


#### 6.1.6. 10/100/1000 Ethernet MAC Without Internal FIFO Buffers with

1000BASE-X/SGMII 2XTBI PCS Signals
Figure 53. 10/100/1000 Ethernet MAC Function Without Internal FIFO Buffers with
1000BASE-X/SGMII 2XTBI PCS Signals
Reset
Signalreset
Status LED Signals
tx_clk_125
rx_clk_125MII/GMII Clock Signals
MACControl InterfaceSignals
reg_addr[7:0]
reg_rd
reg_wr
reg_data_out[31:0]
reg_data_in[31:0]
reg_busy
8
32
32
10/100/1000MB Ethernet MAC Without Internal FIFO Buffers
with 1000BASE-X/SGMII 2XTBI PCS
Magic Packet Signals magic_wakeup_n
magic_sleep_n_n
tx_clk_62_5
rx_clk_62_5
clk
2x Ten-bitInterface Signals
n rx_afull_data[1:0]
rx_afull_valid
MAC FIFO Status Signals
rx_afull_clk
rx_afull_channel
MAC Transmit Interface Signals
8
tx_crc_fwd_n
8
5
MAC Receive Interface Signals
5
MAC Packet ClassificationSignals
pkt_class_valid_n
pkt_class_data_n[4:0]
data_rx_data_n[7:0]data_rx_sop_ndata_rx_eop_n
data_rx_error_n[4:0]
data_rx_ready_n
data_rx_valid_n
data_tx_data_n[7:0]
data_tx_sop_n
data_tx_eop_n
data_tx_error_n
data_tx_ready_n
data_tx_valid_n
mac_rx_clk_nClockSignals
tbi2x_rx_clk_n
tbi2x_rx_d_n[19:0]20
20
tbi2x_tx_clk_n
tbi2x_tx_d_n[19:0]
led_an_n
led_crs_n
led_col_n
led_panel_link_n
led_link_n
led_char_err_n
led_disp_err_n
mac_tx_clk_n
**Table 84. References**

| Interface Signal | Section |
| --- | --- |
| Clock and reset signals | Table 56 on page 112 |
| MAC receive interface signals | Multiport MAC Receive Interface Signals on page 120 |
| MAC transmit interface signals | Multiport MAC Transmit Interface Signals on page 120 |
| MAC packet classification signals | Multiport MAC Packet Classification Signals on page 121 |
| MAC FIFO status signals | Multiport MAC FIFO Status Signals on page 121 |
| Magic packet signals | Pause and Magic Packet Signals on page 116 |
| Status LED signals | Status LED Control Signals on page 123 |
| MAC control interface signals | MAC Control Interface Signals on page 112 |
| Ten-bit interface signals | TBI Interface Signals on page 154 |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
131

<!-- PDF page 132 -->


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
132

<!-- PDF page 133 -->


#### 6.1.7. 10/100/1000 Ethernet MAC Without Internal FIFO Buffers with

IEEE 1588v2 and 1000BASE-X/SGMII 2XTBI PCS Signals
Figure 54. 10/100/1000 Ethernet MAC Function Without Internal FIFO Buffers with
IEEE 1588v2 and 1000BASE-X/SGMII 2XTBI PCS Signals
ResetSignalreset
tx_clk_125rx_clk_125MII/GMII Clock Signals
MACControl InterfaceSignals
reg_addr[7:0]
reg_rdreg_wr
reg_data_out[31:0]reg_data_in[31:0]
reg_busy
8
32
32
10/100/1000MB Ethernet MAC Without Internal FIFO Bufferswith IEEE 1588v2 and 1000BASE-X/SGMII 2XTBI PCS
Magic Packet Signals magic_wakeup_nmagic_sleep_n_n
tx_clk_62_5rx_clk_62_5
clk
2x Ten-bit Interface Signals
tbi2x_rx_clk_ntbi2x_rx_d_n[19:0]20
20
tbi2x_tx_clk_ntbi2x_tx_d_n[19:0]
n rx_afull_data[1:0]rx_afull_validMAC FIFO Status Signals rx_afull_clk
rx_afull_channel
MAC Transmit Interface Signals
8
tx_crc_fwd_n
8
5
MAC Receive Interface Signals
5
MAC Packet ClassificationSignals pkt_class_valid_npkt_class_data_n[4:0]
data_rx_data_n[7:0]data_rx_sop_ndata_rx_eop_ndata_rx_error_n[4:0]data_rx_ready_ndata_rx_valid_n
data_tx_data_n[7:0]data_tx_sop_ndata_tx_eop_ndata_tx_error_n
data_tx_ready_ndata_tx_valid_n
ClockSignals
IEEE 1588v2
tx_egress_timestamp_request_valid_n
tx_time_of_day_96b_data_n[95:0]tx_time_of_day_64b_data_n[63:0]rx_time_of_day_96b_data_n[95:0]rx_time_of_day_64b_data_n[63:0]pcs_phase_measure_clk
Signals
tx_egress_timestamp_96b_data_n[95:0]tx_egress_timestamp_96b_fingerprint_n[3:0]
tx_egress_timestamp_64b_data_n[63:0]tx_egress_timestamp_64b_valid_n
tx_egress_timestamp_64b_fingerprint_n[3:0]
tx_egress_timestamp_96b_valid_n
rx_egress_timestamp_96b_data_n[95:0]rx_egress_timestamp_96b_valid_n
rx_egress_timestamp_64b_data_n[63:0]rx_egress_timestamp_64b_valid_n
tx_egress_timestamp_request_fingerprint_n[3:0]
tx_etstamp_ins_ctrl_timestamp_insert_ntx_etstamp_ins_ctrl_residence_time_update_ntx_etstamp_ins_ctrl_checksum_zero_ntx_etstamp_ins_ctrl_checksum_correct_ntx_etstamp_ins_ctrl_residence_time_calc_format_ntx_etstamp_ins_ctrl_timestamp_format_ntx_etstamp_ins_ctrl_offset_timestamp_n[15:0]tx_etstamp_ins_ctrl_offset_correction_field_n[15:0]tx_etstamp_ins_ctrl_offset_checksum_field_n[15:0]tx_etstamp_ins_ctrl_offset_checksum_correction_n[15:0]tx_etstamp_ins_ctrl_ingress_timestamp_96b_n[95:0]tx_etstamp_ins_ctrl_ingress_timestamp_64b_n[63:0]
4
161616169664
96
64
9664
4
64
96
96
64
4
Status LED Signals
led_an_nled_crs_nled_col_n
led_panel_link_nled_link_nled_char_err_n
led_disp_err_n
mac_rx_clk_nmac_tx_clk_n

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
133

<!-- PDF page 134 -->

**Table 85. References**

| Interface Signal | Section |
| --- | --- |
| Clock and reset signals | Table 56 on page 112 |
| MAC receive interface signals | Multiport MAC Receive Interface Signals on page 120 |
| MAC transmit interface signals | Multiport MAC Transmit Interface Signals on page 120 |
| MAC packet classification signals | Multiport MAC Packet Classification Signals on page 121 |
| MAC FIFO status signals | Multiport MAC FIFO Status Signals on page 121 |
| Magic packet signals | Pause and Magic Packet Signals on page 116 |
| Status LED signals | Status LED Control Signals on page 123 |
| MAC control interface signals | MAC Control Interface Signals on page 112 |
| Ten-bit interface signals | TBI Interface Signals on page 154 |
| IEEE 1588v2 RX timestamp signals | IEEE 1588v2 RX Timestamp Signals on page 144 |
| IEEE 1588v2 TX timestamp signals | IEEE 1588v2 TX Timestamp Signals on page 145 |
| IEEE 1588v2 TX timestamp request signals | IEEE 1588v2 TX Timestamp Request Signals on page 145 |
| IEEE 1588v2 TX insert control timestamp<br>signals | IEEE 1588v2 TX Insert Control Timestamp Signals on page 146 |
| IEEE 1588v2 TOD clock interface signals | IEEE 1588v2 Time-of-Day (TOD) Clock Interface Signals on page 147 |
| IEEE 1588v2 PCS phase measurement clock<br>signal | IEEE 1588v2 PCS Phase Measurement Clock Signal on page 147 |


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
134

<!-- PDF page 135 -->


#### 6.1.8. 10/100/1000 Ethernet MAC Without Internal FIFO Buffers with

IEEE 1588v2, 1000BASE-X/SGMII 2XTBI PCS, SGMII Bridge, and
Deterministic Latency Signals
Figure 55. 10/100/1000 Ethernet MAC Function Without Internal FIFO Buffers with
IEEE 1588v2, 1000BASE-X/SGMII 2XTBI PCS, SGMII Bridge, and Determistic
Latency Signals
ResetSignal
reset
tx_clk_125rx_clk_125
MII/GMII Clock Signals
MACControl InterfaceSignals
reg_addr[7:0]
reg_rdreg_wr
reg_data_out[31:0]reg_data_in[31:0]
reg_busy
8
32
32
10/100/1000MB Ethernet MAC Without Internal FIFO Buffers withIEEE 1588v2, 1000BASE-X/SGMII 2XTBI PCS, SGMII Bridge, and Deterministic Latency
Magic Packet Signals magic_wakeup_0magic_sleep_n_0
tx_clk_62_5rx_clk_62_5
clk
2x Ten-bit Interface Signals
tbi2x_rx_clktbi2x_tx_clk
n rx_afull_data[1:0]rx_afull_validMAC FIFO Status Signals rx_afull_clk
rx_afull_channel
MAC Transmit Interface Signals
8
tx_crc_fwd_0
8
5
MAC Receive Interface Signals
5
MAC Packet ClassificationSignals pkt_class_valid_0pkt_class_data_0[4:0]
data_rx_data_0[7:0]data_rx_sop_0data_rx_eop_0data_rx_error_0[4:0]data_rx_ready_0data_rx_valid_0
data_tx_data_0[7:0]data_tx_sop_0data_tx_eop_0data_tx_error_0
data_tx_ready_0data_tx_valid_0
ClockSignals
IEEE 1588v2
tx_egress_timestamp_request_valid_0
tx_time_of_day_96b_data_0[95:0]tx_time_of_day_64b_data_0[63:0]rx_time_of_day_96b_data_0[95:0]rx_time_of_day_64b_data_0[63:0]pcs_phase_measure_clk
Signals
tx_egress_timestamp_96b_data_0[95:0]tx_egress_timestamp_96b_fingerprint_0[3:0]
tx_egress_timestamp_64b_data_0[63:0]tx_egress_timestamp_64b_valid_0
tx_egress_timestamp_64b_fingerprint_0[3:0]
tx_egress_timestamp_96b_valid_0
rx_egress_timestamp_96b_data_0[95:0]rx_egress_timestamp_96b_valid_0
rx_egress_timestamp_64b_data_0[63:0]rx_egress_timestamp_64b_valid_0
tx_egress_timestamp_request_fingerprint_0[3:0]
tx_etstamp_ins_ctrl_timestamp_insert_0tx_etstamp_ins_ctrl_residence_time_update_0tx_etstamp_ins_ctrl_checksum_zero_0tx_etstamp_ins_ctrl_checksum_correct_0tx_etstamp_ins_ctrl_residence_time_calc_format_0tx_etstamp_ins_ctrl_timestamp_format_0tx_etstamp_ins_ctrl_offset_timestamp_0[15:0]tx_etstamp_ins_ctrl_offset_correction_field_0[15:0]tx_etstamp_ins_ctrl_offset_checksum_field_0[15:0]tx_etstamp_ins_ctrl_offset_checksum_correction_0[15:0]tx_etstamp_ins_ctrl_ingress_timestamp_96b_0[95:0]tx_etstamp_ins_ctrl_ingress_timestamp_64b_0[63:0]
4
161616169664
96
64
9664
4
64
96
96
64
4
Status LED Signals
led_an_nled_crs_nled_col_n
led_panel_link_nled_link_nled_char_err_n
led_disp_err_n
mac_rx_clk_0mac_tx_clk_0
i_dl_sampling_clk
o_sl_tx_pma[79:0]i_sl_rx_pma[79:0]
i_sl_rx_hard_fifo_pemptyo_sl_hard_fifo_rd_eni_tx_pma_readyi_rx_pma_readyi_tx_readyi_rx_ready
o_sl_latency_sclko_sl_tx_rx_dl_measure_seli_sl_tx_dl_async_pulsei_sl_rx_dl_async_pulse
DeterministicLatencySignals
reset_tx_clkreset_rx_clk
tx_clkrx_clk

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
135

<!-- PDF page 136 -->

**Table 86. References**

| Interface Signal | Section |
| --- | --- |
| Clock and reset signals | Table 56 on page 112 |
| MAC receive interface signals | Multiport MAC Receive Interface Signals on page 120 |
| MAC transmit interface signals | Multiport MAC Transmit Interface Signals on page 120 |
| MAC packet classification signals | Multiport MAC Packet Classification Signals on page 121 |
| MAC FIFO status signals | Multiport MAC FIFO Status Signals on page 121 |
| Magic packet signals | Pause and Magic Packet Signals on page 116 |
| Status LED signals | Status LED Control Signals on page 123 |
| MAC control interface signals | MAC Control Interface Signals on page 112 |
| Ten-bit interface signals | TBI Interface Signals on page 154 |
| IEEE 1588v2 RX timestamp signals | IEEE 1588v2 RX Timestamp Signals on page 144 |
| IEEE 1588v2 TX timestamp signals | IEEE 1588v2 TX Timestamp Signals on page 145 |
| IEEE 1588v2 TX timestamp request signals | IEEE 1588v2 TX Timestamp Request Signals on page 145 |
| IEEE 1588v2 TX insert control timestamp<br>signals | IEEE 1588v2 TX Insert Control Timestamp Signals on page 146 |
| IEEE 1588v2 TOD clock interface signals | IEEE 1588v2 Time-of-Day (TOD) Clock Interface Signals on page 147 |
| IEEE 1588v2 PCS phase measurement clock<br>signal | IEEE 1588v2 PCS Phase Measurement Clock Signal on page 147 |


##### 6.1.8.1. Deterministic Latency Clock Signals

**Table 87. Deterministic Latency Clock Signals**

| Name | I/O | Width | Description |
| --- | --- | --- | --- |
| i_dl_sampling_clk | I | 1 | Sampling clock for deterministic latency logic. The<br>default frequency value is 228.571429 MHz. |


##### 6.1.8.2. Deterministic Latency Datapath Signals

**Table 88. Deterministic Latency Clock Signals**

| Name | I/O | Width | Description |
| --- | --- | --- | --- |
| o_sl_tx_pma | O | 80 | TX data to E-tile Native PHY (PMA side). Connect this<br>signal to tx_parallel_data of E-tile Native PHY. |
| i_sl_rx_pma | I | 80 | RX data from E-tile Native PHY (PMA side). Connect<br>this signal to rx_parallel_data of E-tile Native<br>PHY. |

Related Information
Port Information, E-Tile Transceiver PHY User Guide

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
136

<!-- PDF page 137 -->


##### 6.1.8.3. Deterministic Latency Control and Status Interface Signals

**Table 89. Deterministic Latency Control and Status Interface Signals**

| Name | I/O | Width | Description |
| --- | --- | --- | --- |
| i_sl_rx_hard_fifo_pempt<br>y | I | 1 | PMA RX FIFO partial empty status signal. This signal<br>asserts when the fill level reaches the number of<br>unwritten entries in the FIFO buffer before the buffer<br>is empty. |
| o_sl_hard_fifo_rd_en | O | 1 | Read enable signal to the PMA. When asserted, this<br>signal indicates that the data can be read from the<br>RX PMA interface. |
| i_tx_pma_ready | I | 1 | Ready status signal of the transmitter PMA. |
| i_rx_pma_ready | I | 1 | Ready status signal of the receiver PMA. |
| i_tx_ready | I | 1 | Ready status signal of the TX transceiver channel. |
| i_rx_ready | I | 1 | Ready status signal of the RX transceiver channel. |


##### 6.1.8.4. Deterministic Latency Interface Signals

**Table 90. Deterministic Latency Interface Signals**

| Name | I/O | Width | Description |
| --- | --- | --- | --- |
| o_sl_latency_sclk | O | 1 | This signal is mapped to latency_sclk of E-tile<br>Native PHY IP. Clock signal for latency measurement<br>of the deterministic latency (DL) application.<br>The TX and RX asynchronous pulse is output from<br>this signal in the DL module.<br>This signal is wired to TX and RX asynchronous pulse<br>path in the Native PHY, and is used to determine the<br>round-trip delay of the asynchronous-pulse path.<br>Dividing the round-trip delay by 2 gives the 1-way<br>delay of the asynchronous pulse. |
| o_sl_tx_rx_dl_measure_s<br>el | O | 1 | Multiplexer select signal for the transmitter and<br>receiver latency measurement. This signal is<br>mapped to both tx_dl_measure_sel and<br>rx_dl_measure_sel of E-tile Native PHY IP.<br>• 1 is for the datapath latency.<br>• 0 is for the wire delay. |
| i_sl_tx_dl_async_pulse | I | 1 | Asynchronous input pulse signal for the transmitter<br>latency measurement of the deterministic latency<br>application. This signal is mapped to<br>tx_dl_async_pulse of E-tile Native PHY IP. |
| i_sl_rx_dl_async_pulse | I | 1 | Asynchronous input pulse signal for the receiver<br>latency measurement of the deterministic latency<br>application. This signal is mapped to<br>rx_dl_async_pulse of E-tile Native PHY IP. |


##### 6.1.8.5. IEEE 1588v2 PCS TX PTP Alignment Interface Signals

**Table 91. IEEE 1588v2 PCS TX PTP Alignment Interface Signals**

| Name | I/O | Width | Description |
| --- | --- | --- | --- |
| tx_ptp_alignment | I | 1 | Unused. Tie off this signal with 1'b0. |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
137

<!-- PDF page 138 -->


#### 6.1.9. 10/100/1000 Multiport Ethernet MAC with 1000BASE-X/SGMII PCS

Signals
Figure 56. 10/100/1000 Multiport Ethernet MAC Function without Internal FIFO Buffers
with 1000BASE-X/SGMII PCS Signals
PHY Management Signals
mdio_in
mdc
mdio_oen
mdio_out
Reset Signalreset
Status LED Signals
led_an_n
led_crs_n
led_col_n
led_char_err_n
led_link_n
led_disp_err_n
led_panel_link_n
SERDESControlSignals
sd_loopback_n
powerdown_n
Pause and Magic Packet Signals
xon_gen_n
xoff_gen_n
magic_wakeup_n
magic_sleep_n_n
8
5
mac_tx_clk_nmac_rx_clk_nClockSignals
data_rx_data_n[7:0]
data_rx_eop_n
data_rx_sop_n
data_rx_error_n[4:0]
data_rx_ready_n
data_rx_valid_n
MAC Receive Interface Signals
MAC Transmit Interface Signals
data_tx_data_n[7:0]
data_tx_eop_n
data_tx_error_n
data_tx_sop_n
data_tx_valid_ndata_tx_ready_n
tx_crc_fwd_ntx_ff_uflow_n
8
MAC Packet ClassificationSignals
pkt_class_valid_n
pkt_class_data_n[4:0]5
n rx_afull_data[1:0]
rx_afull_valid
MAC FIFO Status Signals
rx_afull_clk
Ten Bit Interface Signals
tbi_rx_clk_n
tbi_rx_d_n[9:0]
tbi_tx_clk_n
tbi_tx_d_n[9:0]
10
10
32
32
MAC Control InterfaceSignals
clk
reg_rd
reg_wr
reg_data_out[31:0]
reg_data_in[31:0]
reg_busy
8
rx_afull_channel[CHANNEL_WIDTH-1:0]
reg_addr[(log2 MAX_CHANNELS+7):0][7:0]
ECC StatusSignalpcs_eccstatus[1:0]
Multi-Port MAC with 1000BASE-X/SGMII PCS
**Table 92. References**

| Interface Signal | Section |
| --- | --- |
| Clock and reset signals | Clock and Reset Signals on page 111 |
| MAC control interface signals | MAC Control Interface Signals on page 112 |
| MAC transmit interface signals | MAC Transmit Interface Signals on page 115 |
| MAC receive interface signals | MAC Receive Interface Signals on page 113 |
| MAC packet classification signals | Multiport MAC Packet Classification Signals on page 121 |
| MAC FIFO status signals | Multiport MAC FIFO Status Signals on page 121 |
| Pause and magic packet signals | Pause and Magic Packet Signals on page 116 |
| PHY management signals | PHY Management Signals on page 118 |
| Ten-bit interface signals | TBI Interface Signals on page 123 |
| Status LED signals | Status LED Control Signals on page 123 |
| SERDES control signals | SERDES Control Signals on page 124 |


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
138

<!-- PDF page 139 -->


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
139

<!-- PDF page 140 -->


#### 6.1.10. 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII PCS and

Embedded PMA Signals
Figure 57. 10/100/1000 Ethernet MAC Function with Internal FIFO Buffers, and
1000BASE-X/SGMII PCS With Embedded PMA Signals
Status LED Signals
led_anled_crs
led_col
led_char_err
led_link
led_disp_errled_panel_link
PHYManagement Signals
mdio_inmdcmdio_oen
mdio_out

## 1.25 GbpsSerial Signals

ref_clk
rx_p
tx_p
Reset Signalreset
ECC StatusSignalmac_eccstatus[1:0]
TransceiverNative PHYSignalcdr_ref_clk_n
Pause and Magic Packet Signals
xon_genxoff_gen
magic_wakeupmagic_sleep_n
n
2
MAC Transmit Interface Signals ff_tx_crc_fwd
ff_tx_data[DATAWIDTH -1:0]
ff_tx_eopff_tx_err
ff_tx_sop
ff_tx_wren
tx_ff_uflow
ff_tx_rdy
ff_tx_septy
ff_tx_mod[1:0]
ff_tx_a_full
ff_tx_a_empty
ff_tx_clk
ff_rx_clk
MAC Receive Interface Signals
ff_rx_data[DATAWIDTHff_rx_mod[1:0]
ff_rx_eopff_rx_sop
rx_err[5:0]rx_err_stat[17:0]
rx_frm_type[3:0]
ff_rx_dsav
ff_rx_rdy
ff_rx_dval
ff_rx_a_full
n
2
6
18
4
SERDESControlSignals
pcs_pwrdn_out
gxb_pwrdn_in
gxb_cal_blk_clk
reconfig_clk
reconfig_togxb
reconfig_fromgxb
rx_recovclkout
32
32
MAC Control InterfaceSignals
clk
reg_addr[7:0]
reg_rd
reg_wr
reg_data_out[31:0]
reg_data_in[31:0]
reg_busy
8
10/100/1000 Ethernet MAC and 1000BASE-X/SGMII PCS
with Embedded PMA
(2)
-1:0](2)
(1)
ff_rx_a_empty
Note to Figure 57 on page 140:

## 1. The SERDES control signals are present in variations targeting devices with GX

transceivers. For device families prior to the Stratix V device, the reconfiguration
signals—reconfig_clk, reconfig_togxb, and reconfig_fromgxb—are
always present in the interface. For Stratix V GX device, the reconfiguration
signals—reconfig_togxb and reconfig_fromgxb—are always present in the
interface. The reconfig_clk reconfiguration signal is embedded in the

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
140

<!-- PDF page 141 -->

reconfig_togxb reconfiguration signal. For Intel Arria 10 GX device, the
reconfig_avmm interface signal is present when reconfiguration feature is
enabled.

## 2. The DATAWIDTH value depends on the FIFO width that you select in the parameter

editor. Options available are 8 and 32 bits.

##### 6.1.10.1. 1.25 Gbps Serial Interface

If the variant includes an embedded PMA, the PMA provides a 1.25-GHz serial
interface.
**Table 93. 1.25 Gbps MDI Interface Signals**

| Name | I/O | Description |
| --- | --- | --- |
| ref_clk | I | 125 MHz local reference clock oscillator. |
| rx_p | I | Serial Differential Receive Interface. |
| tx_p | O | Serial Differential Transmit Interface. |


##### 6.1.10.2. Transceiver Native PHY Signal

**Table 94. Transceiver Native PHY Signal**

| Name | I/O | Description |
| --- | --- | --- |
| cdr_ref_clk_n | I | Port to connect the RX PLL reference clock with a frequency of 125 MHz when you<br>enable SyncE support. |


##### 6.1.10.3. SERDES Control Signals

These signals apply only to PMA blocks implemented in devices with GX transceivers.
**Table 95. SERDES Control Signal**

| Name | I/O | Description |
| --- | --- | --- |
| rx_recovclkout | O | Recovered clock from the PMA block. |
| pcs_pwrdn_out | O | Power-down status. Asserted when the PCS function is in power-down mode;<br>deasserted when the PCS function is operating in normal mode. This signal is<br>implemented only when an internal SERDES is used with the option to export<br>the power-down signal.<br>This signal is not present in PMA blocks implemented in Intel Arria 10, Stratix<br>V, Arria V, and Arria V devices with GX transceivers. |
| gxb_pwrdn_in | I | Power-down enable. Assert this signal to power down the transceiver quad<br>block. This signal is implemented only when an internal SERDES is used with<br>the option to export the power-down signal.<br>This signal is not present in PMA blocks implemented in Intel Arria 10, Stratix<br>V, Arria V, and Arria V devices with GX transceivers. |
| gxb_cal_blk_clk | I | Calibration block clock for the ALT2GXB module (SERDES). This clock is<br>typically tied to the 125 MHz ref_clk. Only implemented when an internal<br>SERDES is used.<br>This signal is not present in PMA blocks implemented in Intel Arria 10, Stratix<br>V, Arria V, and Cyclone V devices with GX transceivers. |
| reconfig_clk | I | Reference clock for the dynamic reconfiguration controller. If you use a<br>dynamic reconfiguration controller in your design to dynamically control the<br>transceiver, both the reconfiguration controller and the IP require this clock.<br>This clock must operate between 37.5–50 MHz. Tie this clock low if you are not<br>using an external reconfiguration controller.<br>This signal is not present in PMA blocks implemented in Intel Arria 10, Stratix<br>V, Arria V, and Cyclone V devices with GX transceivers. |
| reconfig_togxb[n:0] | I | Driven from an external dynamic reconfiguration controller. Supports the<br>selection of multiple transceiver channels for dynamic reconfiguration.<br>For PMA blocks implemented in Stratix V devices with GX transceivers, the bus<br>width is [139:0]. For more information about the bus width for PMA blocks<br>implemented in each device, refer to the Dynamic Reconfiguration chapter of<br>the respective device handbook. |
| reconfig_fromgxb[n:<br>0] | O | Connects to an external dynamic reconfiguration controller. The bus identifies<br>the transceiver channel whose settings are being transmitted to the<br>reconfiguration controller. Leave this bus disconnected if you are not using an<br>external reconfiguration controller.<br>For more information about the bus width for PMA blocks implemented in each<br>device, refer to the Dynamic Reconfiguration chapter of the respective device<br>handbook. |
| reconfig_busy | I | Driven from an external dynamic reconfiguration controller. This signal will<br>indicate the busy status of the dynamic reconfiguration controller during offset<br>cancellation. Tie this signal to 1'b0 if you are not using an external<br>reconfiguration controller.<br>This signal is not present in PMA blocks implemented in Intel Arria 10, Stratix<br>V, Arria V, and Arria V devices with GX transceivers. |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
141

<!-- PDF page 142 -->

For more information on the signals, refer to the respective sections shown in Table 92
on page 138.

##### 6.1.10.4. Intel LVDS Transmitter and Receiver Soft-CDR I/O Signals

These signals apply only to Intel Agilex devices.
**Table 96. SERDES Control Signal**

| Name | I/O | Description |
| --- | --- | --- |
| refclk | I | 125 MHz local reference clock oscillator. |
| txp | O | Positive signal for the transmitter serial data. |
| txn | O | Negative signal for the transmitter serial data. |
| rxp | I | Positive signal for the receiver serial data. |
| rxn | I | Negative signal for the receiver serial data. |
| rx_recovclkout | O | Recovered clock from LVDS receiver core. |
| lvds_tx_pll_locked | O | PLL locked indicator from LVDS transmitter core. |


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
142

<!-- PDF page 143 -->


#### 6.1.11. 10/100/1000 Multiport Ethernet MAC with 1000BASE-X/SGMII

PCS and Embedded PMA Signals
Figure 58. 10/100/1000 Multiport Ethernet MAC Function without Internal FIFO Buffers,
with IEEE 1588v2, 1000BASE-X/SGMII PCS and Embedded PMA Signals
PHY Management Signals
mdio_in
mdc
mdio_oen
mdio_out
Reset Signalreset
TransceiverNative PHYSignal cdr_ref_clk_n
ECC Status
Signalpcs_eccstatus[1:0]

## 1.25 GbpsSerial Signals

ref_clk_n
rx_p_n
tx_p_n
Status LED Signals
led_an_n
led_crs_n
led_col_n
led_char_err_n
led_link_n
mac_tx_clk_nmac_rx_clk_n
ClockSignals
xon_gen_n
xoff_gen_n
magic_wakeup_n
magic_sleep_n_n Pause and Magic Packet Signals
SERDESControlSignals
IEEE 1588v2
Signals
pcs_pwrdn_out
gxb_pwrdn_in_n
gxb_cal_blk_clk
reconfig_clk_n
reconfig_togxb_n

# 8 data_tx_data_n[7:0]

data_tx_eop_n
data_tx_error_n
data_tx_sop_n
data_tx_valid_n
data_tx_ready_n
MAC Transmit InterfaceSignals
tx_crc_fwd_ntx_ff_uflow_n
8
5
data_rx_data_n[7:0]
data_rx_eop_n
data_rx_sop_n
data_rx_error_n[4:0]
data_rx_ready_n
data_rx_valid_n
MAC Receive InterfaceSignals
MAC Packet ClassificationSignals
pkt_class_valid_n
5
n rx_afull_data[1:0]
rx_afull_valid
MAC FIFOStatus Signals
rx_afull_clk
32
n
clk
reg_rd
reg_wr
reg_data_in[31:0]
reg_busy
reg_data_out[31:0]
reg_addr[(log2 MAX_CHANNELS+7):0]
32
MAC ControlInterface Signals rx_recovclkout
reconfig_busy
reconfig_fromgxb_n
tx_egress_timestamp_96b_n
tx_time_of_day_96b_n
tx_time_of_day_64b_n
rx_time_of_day_96b_n
rx_time_of_day_64b_n
pcs_phase_measure_clk
tx_egress_timestamp_request_n
tx_etstamp_ins_ctrl_n
tx_egress_timestamp_64b_n
rx_ingress_timestamp_96b_n
rx_ingress_timestamp_64b_n
Multi-Port MAC and 1000BASE-X/SGMII PCS
with Embedded PMA
pkt_class_data_n[4:0]
rx_afull_channel(CHANNEL_WIDTH-1:0)
led_disp_err_n
led_panel_link_n
(1)
Note to Figure 58 on page 143:

## 1. The SERDES control signals are present in variations targeting devices with GX

transceivers. For Stratix II GX and Arria GX devices, the reconfiguration signals—
reconfig_clk, reconfig_togxb, and reconfig_fromgxb—are included only
when the Enable transceiver dynamic reconfiguration option is turned on.

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
143

<!-- PDF page 144 -->

The reconfiguration signals—gxb_cal_blk_clk, pcs_pwrdwn_out,
gxb_pwrdn_in, reconfig_clk, and reconfig_busy—are not present in
variations targeting Intel Arria 10, Stratix V, Arria V, and Cyclone V devices with
GX transceivers.
**Table 97. References**

| Interface Signal | Section |
| --- | --- |
| Clock and reset signals | Clock and Reset Signals on page 111 |
| MAC control interface | MAC Control Interface Signals on page 112 |
| MAC transmit interface | MAC Transmit Interface Signals on page 115 |
| MAC receive interface | MAC Receive Interface Signals on page 113 |
| MAC packet classification signals | Multiport MAC Packet Classification Signals on page 121 |
| MAC FIFO status signals | Multiport MAC FIFO Status Signals on page 121 |
| Pause and magic packet signals | Pause and Magic Packet Signals on page 116 |
| PHY management signals | PHY Management Signals on page 118 |
| 1.25 Gbps serial signals | 1.25 Gbps Serial Interface on page 141 |
| Status LED control signals | Status LED Control Signals on page 123 |
| SERDES control signals | SERDES Control Signals on page 124 |
| Transceiver Native PHY signal | Transceiver Native PHY Signal on page 141 |
| IEEE 1588v2 RX timestamp signals | IEEE 1588v2 RX Timestamp Signals on page 144 |
| IEEE 1588v2 TX timestamp signals | IEEE 1588v2 TX Timestamp Signals on page 145 |
| IEEE 1588v2 TX timestamp request signals | IEEE 1588v2 TX Timestamp Request Signals on page 145 |
| IEEE 1588v2 TX insert control timestamp<br>signals | IEEE 1588v2 TX Insert Control Timestamp Signals on page 146 |
| IEEE 1588v2 TOD clock interface signals | IEEE 1588v2 Time-of-Day (TOD) Clock Interface Signals on page 147 |




##### 6.1.11.1. IEEE 1588v2 RX Timestamp Signals

**Table 98. IEEE 1588v2 RX Timestamp Interface Signals**

| Signal | I/O | Width | Description |
| --- | --- | --- | --- |
| rx_ingress_timesta<br>mp_96b_data_n | O | 96 | Carries the ingress timestamp on the receive datapath. Consists of 48-bit<br>seconds field, 32-bit nanoseconds field, and 16-bit fractional nanoseconds<br>field.<br>The MAC presents the timestamp for all receive frames and asserts this<br>signal in the same clock cycle it asserts<br>rx_ingress_timestamp_96b_valid. |
| rx_ingress_timesta<br>mp_96b_valid | O | 1 | When asserted, this signal indicates that<br>rx_ingress_timestamp_96b_data contains valid timestamp.<br>For all receive frame, the MAC asserts this signal in the same clock cycle it<br>receives the start of packet (avalon_st_rx_startofpacket is asserted). |
| rx_ingress_timesta<br>mp_64b_data | O | 64 | Carries the ingress timestamp on the receive datapath. Consists of 48-bit<br>nanoseconds field and 16-bit fractional nanoseconds field. |
|  |  |  | The MAC presents the timestamp for all receive frames and asserts this<br>signal in the same clock cycle it asserts<br>rx_ingress_timestamp_64b_valid. |
| rx_ingress_timesta<br>mp_64b_valid | O | 1 | When asserted, this signal indicates that<br>rx_ingress_timestamp_64b_data contains valid timestamp.<br>For all receive frame, the MAC asserts this signal in the same clock cycle it<br>receives the start of packet (avalon_st_rx_startofpacket is asserted). |


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
144

<!-- PDF page 145 -->


##### 6.1.11.2. IEEE 1588v2 TX Timestamp Signals

**Table 99. IEEE 1588v2 TX Timestamp Interface Signals**

| Signal | I/O | Width | Description |
| --- | --- | --- | --- |
| tx_egress_timestam<br>p_96b_data_n | O | 96 | A transmit interface signal. This signal carries requested timestamp of<br>transmitted frame with fingerprint<br>tx_egress_timestamp_96b_fingerprint.<br>Consists of 48-bit seconds field, 32-bit nanoseconds field, and 16-bit<br>fractional nanoseconds field. |
| tx_egress_timestam<br>p_96b_valid | O | 1 | A transmit interface signal. When asserted, this signal indicates that a<br>timestamp is obtained and a timestamp request is valid for the particular<br>frame.<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_egress_timestam<br>p_96b_fingerprint | O | n | Configurable width fingerprint that returns with correlated timestamps.<br>The signal width is determined by the TSTAMP_FP_WIDTH parameter<br>(default parameter value is 4). |
| tx_egress_timestam<br>p_64b_data | O | 64 | A transmit interface signal. This signal requested timestamp of transmitted<br>frame with fingerprint tx_egress_timestamp_64b_fingerprint.<br>Consists of 48-bit nanoseconds field and 16-bit fractional nanoseconds field. |
| tx_egress_timestam<br>p_64b_valid | O | 1 | A transmit interface signal. When asserted, this signal indicates that a<br>timestamp is obtained and a timestamp request is valid for the particular<br>frame.<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket or avalon_st_tx_startofpacket_n<br>is asserted). |
| tx_egress_timestam<br>p_64b_fingerprint | O | n | Configurable width fingerprint that returns with correlated timestamps.<br>The signal width is determined by the TSTAMP_FP_WIDTH parameter<br>(default parameter value is 4). |


##### 6.1.11.3. IEEE 1588v2 TX Timestamp Request Signals

**Table 100. IEEE 1588v2 TX Timestamp Request Signals**

| Signal | I/O | Width | Description |
| --- | --- | --- | --- |
| tx_egress_timestam<br>p_request_valid_n | I | 1 | Assert this signal when a user-defined tx_egress_timestamp is required<br>for a transmit frame.<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket or avalon_st_tx_startofpacket_n<br>is asserted). |
| tx_egress_timestam<br>p_request_fingerpr<br>int | I | n | Use this bus to specify fingerprint for the user-defined<br>tx_egress_timestamp. The fingerprint is used to identify the user-<br>defined timestamp. |
|  |  |  | The signal width is determined by the TSTAMP_FP_WIDTH parameter<br>(default parameter value is 4).<br>The value of this signal is mapped to user_fingerprint.<br>This signal is only valid when you assert<br>tx_egress_timestamp_request_valid. |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
145

<!-- PDF page 146 -->


##### 6.1.11.4. IEEE 1588v2 TX Insert Control Timestamp Signals

**Table 101. IEEE 1588v2 TX Insert Control Timestamp Interface Signals**

| Signal | I/O | Width | Description |
| --- | --- | --- | --- |
| tx_etstamp_ins_ctr<br>l_timestamp_insert<br>_n | I | 1 | Assert this signal to insert egress timestamp into the associated frame.<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_etstamp_ins_ctr<br>l_timestamp_format | I | 1 | Timestamp format of the frame, which the timestamp inserts.<br>0: 1588v2 format (48-bits second field + 32-bits nanosecond field + 16-bits<br>correction field for fractional nanosecond)<br>Required offset location of timestamp and correction field.<br>1: 1588v1 format (32-bits second field + 32-bits nanosecond field)<br>Required offset location of timestamp.<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_etstamp_ins_ctr<br>l_residence_time_u<br>pdate | I | 1 | Assert this signal to add residence time (egress timestamp –ingress<br>timestamp) into correction field of PTP frame.<br>Required offset location of correction field<br>(tx_etstamp_ins_ctrl_offset_correction_field).<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_etstamp_ins_ctr<br>l_ingress_timestam<br>p_96b[] | I | 96 | 96-bit format of ingress timestamp.<br>(48 bits second + 32 bits nanosecond + 16 bits fractional nanosecond).<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_etstamp_ins_<br>ctrl_ingress_times<br>tamp_64b[] | I | 64 | 64-bit format of ingress timestamp.<br>(48-bits nanosecond + 16-bits fractional nanosecond).<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_etstamp_ins_ctr<br>l_residence_time_c<br>alc_format | I | 1 | Format of timestamp to be used for residence time calculation.<br>0: 96-bits (96-bits egress timestamp - 96-bits ingress timestamp).<br>1: 64-bits (64-bits egress timestamp - 64-bits ingress timestamp).<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_etstamp_ins_ctr<br>l_checksum_zero | I | 1 | Assert this signal to set the checksum field of UDP/IPv4 to zero.<br>Required offset location of checksum field<br>(tx_etstamp_ins_ctrl_offset_checksum_field).<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_etstamp_ins_ctr<br>l_checksum_correct | I | 1 | Assert this signal to correct UDP/IPv6 packet checksum, by updating the<br>checksum correction, which is specified by checksum correction offset.<br>Required offset location of checksum correction<br>(tx_etstamp_ins_ctrl_offset_checksum_correction).<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_etstamp_ins_ctr<br>l_offset_timestamp | I | 1 | The location of the timestamp field, relative to the first byte of the packet.<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_etstamp_ins_ctr<br>l_offset_correctio<br>n_field[] | I | 16 | The location of the correction field, relative to the first byte of the packet.<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_etstamp_ins_ctr<br>l_offset_checksum_<br>field[] | I | 16 | The location of the checksum field, relative to the first byte of the packet.<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |
| tx_etstamp_ins_ctr<br>l_offset_checksum_<br>correction[] | I | 16 | The location of the checksum correction field, relative to the first byte of the<br>packet.<br>Assert this signal in the same clock cycle as the start of packet<br>(avalon_st_tx_startofpacket is asserted). |


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
146

<!-- PDF page 147 -->


##### 6.1.11.5. IEEE 1588v2 Time-of-Day (TOD) Clock Interface Signals

**Table 102. IEEE 1588v2 ToD Clock Interface Signals**

| Signal | I/O | Width | Description |
| --- | --- | --- | --- |
| tx_time_of_day_96b<br>_data_n | I | 96 | Use this bus to carry the time-of-day from external TOD module to 96-bit<br>MAC TX clock.<br>Consists of 48 bits seconds field, 32 bits nanoseconds field, and 16 bits<br>fractional nanoseconds field. |
| rx_time_of_day_96b<br>_data | I | 96 | Use this bus to carry the time-of-day from external TOD module to 96-bit<br>MAC RX clock.<br>Consists of 48 bits seconds field, 32 bits nanoseconds field, and 16 bits<br>fractional nanoseconds field. |
| tx_time_of_day_64b<br>_data | I | 64 | Use this bus to carry the time-of-day from external TOD module to 64-bit<br>MAC TX clock.<br>Consists of 48-bit nanoseconds field and 16-bit fractional nanoseconds field. |
| rx_time_of_day_64b<br>_data | I | 64 | Use this bus to carry the time-of-day from external TOD module to 64-bit<br>MAC RX clock.<br>Consists of 48-bit nanoseconds field and 16-bit fractional nanoseconds field. |


##### 6.1.11.6. IEEE 1588v2 PCS Phase Measurement Clock Signal

**Table 103. IEEE 1588v2 PCS Phase Measurement Clock Signal**

| Signal | I/O | Width | Description |
| --- | --- | --- | --- |
| pcs_phase_measure_<br>clk | I | 1 | Sampling clock to measure the latency through the PCS FIFO buffer. The<br>recommended frequency is 80 MHz. |


##### 6.1.11.7. IEEE 1588v2 PHY Path Delay Interface Signals

**Table 104. IEEE 1588v2 PHY Path Delay Interface Signals**

| Signal | I/O | Width | Description |
| --- | --- | --- | --- |
| tx_path_delay_data | I | 22 | Use this bus to carry the path delay on the transmit datapath. The delay is<br>measured between the physical network and MII/GMII to adjust the egress<br>timestamp.<br>Bits 0 to 9—Fractional number of clock cycles |
|  |  |  | Bits 10 to 21—Number of clock cycles |
| rx_path_delay_data | I | 22 | Use this bus to carry the path delay on the receive datapath. The delay is<br>measured between the physical network and MII/GMII to adjust the ingress<br>timestamp.<br>Bits 0 to 9—Fractional number of clock cycles<br>Bits 10 to 21—Number of clock cycles |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
147

<!-- PDF page 148 -->


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
148

<!-- PDF page 149 -->


#### 6.1.12. 1000BASE-X/SGMII PCS Signals

Figure 59. 1000BASE-X/SGMII PCS Function Signals
Reset Signals
reset_rx_clk
reset_tx_clk
reset_reg_clk
set_10
set_100
set_1000
hd_ena
SGMII StatusSignals
Status LED Signals
led_an
led_crs
led_col
led_char_err
led_link
led_disp_err
SERDES ControlSignals
sd_loopback
powerdown
rx_clk
tx_clk
MII/GMII Clock Signals
rx_clkena
tx_clkena
Clock
Enabler Signals
GMII Signals gmii_rx_d[7:0]
gmii_rx_dv
gmii_rx_err
gmii_tx_d[7:0]
gmii_tx_en
gmii_tx_err
8
8
mii_rx_d[3:0]
mii_rx_dv
mii_rx_err
mii_col
mii_crs
mii_tx_d[3:0]
mii_tx_en
mii_tx_err
MII Signals 4
4
PCS Control InterfaceSignals
reg_clk
reg_addr[4:0]
reg_rd
reg_wr
reg_data_out[15:0]
reg_data_in[15:0]
reg_busy
5
16
16
Ten Bit Interface Signals
tbi_rx_clk
tbi_rx_d[9:0]
tbi_tx_clk
tbi_tx_d[9:0]
10
10
Intel Arria 10TransceiverNative PHY Signals

# 1000 BASE-X/SGMII PCS Function

tx_serial_clk
rx_cdr_refclk
tx_analogreset
tx_digitalreset
rx_analogreset
rx_digitalreset
tx_cal_busy
rx_cal_busy
rx_set_locktodata
rx_set_locktoref
rx_is_locktodata
rx_is_locktoref
led_panel_link
(1)
Note to Figure 59 on page 149:

## 1. The clock enabler signals are present only in SGMII mode.


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
149

<!-- PDF page 150 -->

**Table 105. References**

| Interface Signal | Section |
| --- | --- |
| Ten-bit interface | TBI Interface Signals on page 123 |
| Status LED signals | Status LED Control Signals on page 123 |
| SERDES control signals | SERDES Control Signals on page 124 |
| Intel Arria 10 Transceiver Native PHY signals | Intel Arria 10 Transceiver Native PHY Signals on page 124 |


##### 6.1.12.1. PCS Control Interface Signals

**Table 106. Register Interface Signals**

| Name | Avalon<br>Memory-<br>Mapped<br>Signal Type | I/O | Description |
| --- | --- | --- | --- |
| reg_clk | clk | I | Register access reference clock. Set the signal to a value less than<br>or equal to 125-MHz. |
| reset_reg_clk | reset | I | Active-high reset signal for reg_clk clock domain. |
| reg_wr | write | I | Register write enable. |
| reg_rd | read | I | Register read enable. |
| reg_addr[4:0] | address | I | 16-bit word-aligned register address. |
| reg_data_in[15:0] | writedata | I | Register write data. Bit 0 is the least significant bit. |
| reg_data_out[15:0] | readdata | O | Register read data. Bit 0 is the least significant bit. |
| reg_busy | waitreques<br>t | O | Register interface busy. Asserted during register read or register<br>write. A value of 0 indicates that the read or write is complete. |


##### 6.1.12.2. PCS Reset Signals

**Table 107. Reset Signals**

| Name | I/O | Description |
| --- | --- | --- |
| reset_rx_clk | I | Active-high reset signal for PCS rx_clk clock domain. Assert this signal to reset<br>the logic synchronized by rx_clk. |
| reset_tx_clk | I | Active-high reset signal for PCS tx_clk clock domain. Assert this signal to reset<br>the logic synchronized by tx_clk. |


##### 6.1.12.3. MII/GMII Clocks and Clock Enablers

Data transfers on the MII/GMII interface are synchronous to the receive and transmit
clocks.
**Table 108. MAC Clock Signals**

| Name | I/O | Description |
| --- | --- | --- |
| rx_clk | O | Receive clock. This clock is derived from the TBI clock tbi_rx_clk and set to<br>125 MHz. |
| tx_clk | O | Transmit clock. This clock is derived from the TBI clock tbi_tx_clk and set to<br>125 MHz. |
| Clock Enabler Signals<br>Note: The clock enabler signals are present only in SGMII mode. |  |  |
| rx_clkena | O | Receive clock enabler. In SGMII mode, this signal enables rx_clk. |
| tx_clkena | O | Transmit clock enabler. In SGMII mode, this signal enables tx_clk. |






## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
150

<!-- PDF page 151 -->

Figure 60. Clock Enabler Signal Behavior

# 125 MHz Clock


# 25 MHz Clock Enable

Input Data
Output Data
0xAA
0xAA
0xBB
0xBB
0xCC
0xCC
0xDD
0xDD
0xEE

##### 6.1.12.4. GMII

**Table 109. GMII Signals**

| Name | I/O | Description |
| --- | --- | --- |
| GMII Transmit Interface |  |  |
| gmii_tx_d[7:0] | I | GMII transmit data bus. |
| gmii_tx_en | I | Assert this signal to indicate that the data on gmii_tx_d[7:0]is valid. |
| gmii_tx_err | I | Assert this signal to indicate to the PHY device that the current frame sent is<br>invalid. |
| GMII Receive Interface |  |  |
| gmii_rx_d[7:0] | O | GMII receive data bus. |
| gmii_rx_dv | O | Asserted to indicate that the data on gmii_rx_d[7:0] is valid. Stays asserted<br>during frame reception, from the first preamble byte until the last byte in the CRC<br>field is received. |
| gmii_rx_err | O | Asserted by the PHY to indicate that the current frame contains errors. |


##### 6.1.12.5. MII

**Table 110. MII Signals**

| Name | I/O | Description |
| --- | --- | --- |
| MII Transmit Interface |  |  |
| mii_tx_d[3:0] | I | MII transmit data bus. |
| mii_tx_en | I | Assert this signal to indicate that the data on mii_tx_d[3:0]is valid. |
| mii_tx_err | I | Assert this signal to indicate to the PHY device that the frame sent is invalid. |
| MII Receive Interface |  |  |
| mii_rx_d[3:0] | O | MII receive data bus. |
| mii_rx_dv | O | Asserted to indicate that the data on mii_rx_d[3:0]is valid. The signal stays<br>asserted during frame reception, from the first preamble byte until the last byte of<br>the CRC field is received. |
| mii_rx_err | O | Asserted by the PHY to indicate that the current frame contains errors. |
| mii_col | O | Collision detection. Asserted by the PCS function to indicate that a collision was<br>detected during frame transmission. |
| mii_crs | O | Carrier sense detection. Asserted by the PCS function to indicate that a transmit or<br>receive activity is detected on the Ethernet line. |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
151

<!-- PDF page 152 -->


##### 6.1.12.6. SGMII Status Signals

The SGMII status signals provide status information to the PCS block. When the PCS is
instantiated standalone, these signals are inputs to the MAC and serve as interface
control signals for that block.
**Table 111. SGMII Status Signals**

| Name | I/O | Description |
| --- | --- | --- |
| set_1000 | O | Gigabit mode enabled. In 1000BASE-X, this signal is always set to 1. In SGMII,<br>this signal is set to 1 if one of the following conditions is met:<br>• The USE_SGMII_AN bit is set to 1 and a gigabit link is established with the link<br>partner, as decoded from the partner_ability register.<br>• The USE_SGMII_AN bit is set to 0 and the SGMII_SPEED bit is set to 10. |
| set_100 | O | 100 -Mbps mode enabled. In 1000BASE-X, this signal is always set to 0. In SGMII,<br>this signal is set to 1 if one of the following conditions is met:<br>• The USE_SGMII_AN bit is set to 1 and a 100Mbps link is established with the<br>link partner, as decoded from the partner_ability register.<br>• The USE_SGMII_AN bit is set to 0 and the SGMII_SPEED bit is set to 01. |
| set_10 | O | 10 -Mbps mode enabled. In 1000BASE-X, this signal is always set to 0. In SGMII,<br>this signal is set to 1 if one of the following conditions is met:<br>• The USE_SGMII_AN bit is set to 1 and a 10Mbps link is established with the<br>link partner, as decoded from the partner_ability register.<br>• The USE_SGMII_AN bit is set to 0 and the SGMII_SPEED bit is set to 00. |
| hd_ena | O | Half-duplex mode enabled. In 1000BASE-X, this signal is always set to 0. In<br>SGMII, this signal is set to 1 if one of the following conditions is met:<br>• The USE_SGMII_AN bit is set to 1 and a half-duplex link is established with the<br>link partner, as decoded from the partner_ability register.<br>• The USE_SGMII_AN bit is set to 0 and the SGMII_DUPLEX bit is set to 1. |


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
152

<!-- PDF page 153 -->


#### 6.1.13. 1000BASE-X/SGMII 2XTBI PCS Signals

Figure 61. 1000BASE-X/SGMII 2XTBI PCS Function Signals
Reset Signals
reset_rx_clk
reset_tx_clk
reset_reg_clk
set_10
set_100
set_1000
hd_ena
SGMII StatusSignals
Status LED Signals
led_an
led_crs
led_col
led_char_err
led_link
led_disp_err
rx_clkena
tx_clkena
Clock Enabler Signals
GMII Signals gmii_rx_d[7:0]
gmii_rx_dv
gmii_rx_err
gmii_tx_d[7: 0]
gmii_tx_en
gmii_tx_err
8
8
mii_rx_d[3:0]
mii_rx_dv
mii_rx_err
mii_tx_d[3:0]
mii_tx_en
mii_tx_err
MII Signals 4
4
PCS Control InterfaceSignals
reg_clk
reg_addr[4:0]
reg_rd
reg_wr
reg_data_out[15:0]
reg_data_in[15:0]
reg_busy
5
16
16
2x Ten Bit Interface Signals
tbi2x_rx_clk
tbi2x_rx_d[19:0] 20
20

# 1000 BASE-X/SGMII 2XTBI PCS

led_panel_link
tbi2x_tx_clk
tbi2x_tx_d[19:0]
tx_clk_125
rx_clk_125MII/GMII Clock Signals tx_clk_62_5
rx_clk_62_5
(1)
Note to Figure 61 on page 153:

## 1. The clock enabler signals are present only in SGMII mode.

**Table 112. References**

| Interface Signal | Section |
| --- | --- |
| GMII clock signals | GMII Clock Signals on page 127 |
| GMII signals | GMII on page 151 |
| MII signals | MII on page 151 |
| PCS control interface signals | PCS Control Interface Signals on page 150 |
| SGMII status signals | SGMII Status Signals on page 152 |
| Status LED signals | Status LED Control Signals on page 123 |


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
153

<!-- PDF page 154 -->


##### 6.1.13.1. Clock Enablers

**Table 113. Clock Enablers**

| Name | I/O | Description |
| --- | --- | --- |
| rx_clkena | O | Receive clock enabler for SGMII 10M/100M operating speeds. |
| tx_clkena | O | Transmit clock enabler for SGMII 10M/100M operating speeds. |

Note: The clock enabler signals are present only in SGMII mode.

##### 6.1.13.2. PCS Reset Signals

**Table 114. Reset Signals**

| Name | I/O | Description |
| --- | --- | --- |
| reset_rx_clk | I | Active-high reset signal for PCS receive clock domain. Assert this signal to reset<br>the logic synchronized by rx_clk_125 and rx_clk_62_5. |
| reset_tx_clk | I | Active-high reset signal for PCS transmit clock domain. Assert this signal to reset<br>the logic synchronized by tx_clk_125 and tx_clk_62_5. |


##### 6.1.13.3. TBI Interface Signals

If the core variation does not include an embedded PMA, the PCS block provides a
62.5-MHz 2 ten-bit interface (TBI) to an external SERDES chip.
**Table 115. TBI Interface Signals for External SERDES Chip**

| Name | I/O | Description (17) |
| --- | --- | --- |
| tbi2x_tx_d[19:0] | O | 2X TBI transmit data. The PCS function transmits data on this bus synchronous to<br>tbi2x_tx_clk. |
| tbi2x_tx_clk | I | 62.5-MHz TBI transmit clock from external SERDES, typically sourced by the local<br>reference clock oscillator.<br>Note: If connected to the E-tile Native PHY, this signal can be sourced from<br>tx_clkout. |
| tbi2x_rx_clk | I | 62.5-MHz TBI receive clock from external SERDES, typically sourced by the clock<br>recovered from the encoded serial data.<br>Note: If connected to the E-tile Native PHY, this signal can be sourced from<br>rx_clkout. |
| tbi2x_rx_d[19:0] | I | 2X TBI receive data. This bus carries the data from the external SERDES.<br>Synchronize the bus with tbi2x_rx_clk. |

(17) All the signals in this table are not exported to the top level for 10/100/1000Mb Ethernet MAC
with 1000BASE-X/SGMII 2XTBI PCS with E-tile GXB variant.

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
154

<!-- PDF page 155 -->


#### 6.1.14. 1000BASE-X/SGMII PCS and PMA Signals

Figure 62. 1000BASE-X/SGMII PCS Function and PMA Signals
Reset
Signals
reset _rx_clk
reset _tx_clk
reset
set _10
set _100
set _1000
hd_ena
SGMII
Status
Signals
Status
LED
Signals
led_an
led_crs
led_col
led_char _err
led_link
led _disp _err
led_an
rx_clk
tx_clk
MII /GMII
Clock
Signals
rx_clkena
tx_clkena
Clock
Enabler
Signals
GMII
Signals gmii_rx_d[7:0]
gmii_rx_dv
gmii_rx_err
gmii_tx_d[7:0]
gmii_tx_en
gmii_tx_err
8
8
mii_rx_d[3:0]
mii_rx_dv
mii_rx_err
mii_col
mii_crs
mii_tx_d[3:0]
mii_tx_en
mii_tx_err
MII
Signals
4
4
PCS
Control
Interface
Signals
clk
address [4:0]
read
write
readdata [15 :0]
writedata [15 :0]
waitrequest 16
16
5
SERDES
Control
Signals

## 1.25 Gbps

Serial Signals
ref_clk
rx_p
tx_p
1000BASE-X/SGMII PCS Function With Embedded PMA
gxb_cal_blk_clk
pcs_pwrdn_out
gxb_pwrdn_in
reconfig_clk
reconfig_togxb
reconfig_fromgxb
rx_recovclkout
reconfig_busy
led_panel_link
(1) (2)
Notes to Figure 62 on page 155:

## 1. The clock enabler signals are present only in SGMII mode.


## 2. The SERDES control signals are present in variations targeting devices with GX

transceivers. For Stratix II GX and Arria GX devices, the reconfiguration signals—
reconfig_clk, reconfig_togxb, and reconfig_fromgxb—are included only
when the option, Enable transceiver dynamic reconfiguration, is turned on.
The reconfiguration signals—gxb_cal_blk_clk, pcs_pwrdwn_out,
gxb_pwrdn_in, reconfig_clk, and reconfig_busy—are not present in
variations targeting Stratix V devices with GX transceivers.

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
155

<!-- PDF page 156 -->

**Table 116. References**

| Interface Signal | Section |
| --- | --- |
| Reset signals | PCS Reset Signals on page 150 |
| MII/GMII clocks and clock enablers | MII/GMII Clocks and Clock Enablers on page 150 |
| PCS control interface | PCS Control Interface Signals on page 150 |
| GMII signals | GMII on page 151 |
| MII signals | MII on page 151 |
| SGMII status signals | SGMII Status Signals on page 152 |
| 1.25 Gbps serial signals | 1.25 Gbps Serial Interface on page 141 |
| Status LED signals | Status LED Control Signals on page 123 |
| SERDES control signals | SERDES Control Signals on page 124 |
| Transceiver Native PHY signal | Transceiver Native PHY Signal on page 141 |




### 6.2. Timing

This section shows the timing on the Triple-Speed Ethernet transmit and receive
interfaces as well as the timestamp signals for the IEEE 1588v2 feature.
Related Information
Avalon Interface Specifications
More information on Avalon memory-mapped control interface timing.

#### 6.2.1. Avalon Streaming Receive Interface

Figure 63. Receive Operation—MAC With Internal FIFO Buffers
ff_rx_clk
ff_rx_data[31:0]
ff_rx_sop
ff_rx_eop
ff_rx_rdy
ff_rx_dval
ff_rx_dsav
rx_frm_type[3:0]
rx_err_stat[17:0]
rx_err[5:0]
ff_rx_mod[1:0]

# 0000000000000000 00000000 00000001 00000002 00000003 00000004 00000005 00000000


# 00 1 0


# 0000000000 00064 00000

00
0

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
156

<!-- PDF page 157 -->

Figure 64. Receive Operation—MAC Without Internal FIFO Buffers
mac_rx_clk_0
data_rx_data_0[7:0]
data_rx_sop_0
data_rx_eop_0
data_rx_ready_0
data_rx_error_0[4:0]
data_rx_valid_0
pkt_class_data_0[4:0]
pkt_class_valid_0

# 0000 03 04 05 06 07 08 09 10 10 10 10 00

00

# 00 10 0

Figure 65. Invalid Length Error During Receive Operation—MAC With Internal FIFO
Buffer
ff_rx_clk
ff_rx_data[31:0]
ff_rx_sop
ff_rx_eop
ff_rx_rdy
ff_rx_dval
ff_rx_dsav
rx_frm_type[3:0]
rx_err_stat[17:0]
rx_err[5:0]
ff_rx_mod[1:0]

# 0000000000000000 00000001 00000002 00000003 00000004 00000005 00000006 00000007


# 00 1 0


# 0000000000 005DD 00000


# 0000 03 00


# 00 3 0


## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
157

<!-- PDF page 158 -->

Figure 66. Invalid Length Error During Receive Operation—MAC Without Internal FIFO
Buffers
mac_rx_clk_0
data_rx_data_0[7:0]
data_rx_sop_0
data_rx_eop_0
data_rx_ready_0
data_rx_error_0[4:0]
data_rx_valid_0
pkt_class_data_0[4:0]
pkt_class_valid_0

# 0000 03 04 05 06 06 07 08 09 09 09 09 09 00


# 0000 01


# 00 10 0


#### 6.2.2. Avalon Streaming Transmit Interface

Figure 67. Transmit Operation—MAC With Internal FIFO Buffers
ff_tx_clk
ff_tx_data[31:0]
ff_tx_sop
ff_tx_eop
ff_tx_rdy
ff_tx_wren
ff_tx_crc_fwd
ff_tx_err
ff_tx_mod[1:0]
ff_tx_septy
tx_ff_uflow

# 00000001 00000002 00000003 00000004 00000005 00000006


## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
158

<!-- PDF page 159 -->

Figure 68. Transmit Operation—MAC Without Internal FIFO Buffers
mac_tx_clk_0
data_tx_data_0[7:0]
data_tx_sop_0
data_tx_eop_0
data_tx_ready_0
data_tx_err_0
data_tx_valid_0

# 0000 01 01 01 02 03 04 05 06 07 08 09


#### 6.2.3. GMII Transmit

On transmit, all data transfers are synchronous to the rising edge of tx_clk. The
GMII data enable signal gm_tx_en is asserted to indicate the start of a new frame and
remains asserted until the last byte of the frame is present on gm_tx_d[7:0] bus.
Between frames, gm_tx_en remains deasserted.
If a frame is received on the Avalon streaming interface with an error (asserted with
ff_tx_eop), the frame is subsequently transmitted with the GMII gm_tx_err error
signal at any time during the frame transfer.

#### 6.2.4. GMII Receive

On receive, all signals are sampled on the rising edge of rx_clk. The GMII data
enable signal gm_rx_dv is asserted by the PHY to indicate the start of a new frame
and remains asserted until the last byte of the frame is present on the gm_rx_d[7:0]
bus. Between frames, gm_rx_dv remains deasserted.
If the PHY detects an error on the frame received from the line, the PHY asserts the
GMII error signal, gm_rx_err, for at least one clock cycle at any time during the
frame transfer.
A frame received on the GMII interface with a PHY error indication is subsequently
transferred on the Avalon streaming interface with the error signal rx_err[0]
asserted.

#### 6.2.5. RGMII Transmit

On transmit, all data transfers are synchronous to both edges of tx_clk. The RGMII
control signal tx_control is asserted to indicate the start of a new frame and
remains asserted until the last upper nibble of the frame is present on the
rgmii_out[3:0] bus. Between frames, tx_control remains deasserted.

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
159

<!-- PDF page 160 -->

Figure 69. RGMII Transmit in 10/100 Mbps
tx_clk
tx_control
rgmii_out[3:0] 00 5 D 0 5 1 6 1 9 1
Figure 70. RGMII Transmit in Gigabit Mode
tx_clk
tx_control
rgmii_out[3:0] 00 5 D 0 5 4 5 E 5 F 5 0 6 0
If a frame is received on the Avalon streaming interface with an error (ff_tx_err
asserted with ff_tx_eop), the frame is subsequently transmitted with the RGMII
tx_control error signal (at the falling edge of tx_clk) at any time during the frame
transfer.
Figure 71. RGMII Transmit with Error in 1000 Mbps
tx_clk
tx_control
rgmii_out[3:0] 00 5 0 4 6 0 1 0 0 8 0 9 0

#### 6.2.6. RGMII Receive

On receive all signals are sampled on both edges of rx_clk. The RGMII control signal
rx_control is asserted by the PHY to indicate the start of a new frame and remains
asserted until the last upper nibble of the frame is present on rgmii_in[3:0] bus.
Between frames, rx_control remains deasserted.
Figure 72. RGMII Receive in 10/100 Mbps
rx_clk
rx_control
rgmii_in[3:0] 00 5 D 0 5 1 6 1 9 0
Figure 73. RGMII Receive in 1000 Mbps
rx_clk
rx_control
rgmii_in[3:0] 00 5 D 0 5 4 5 E 5 F 5 0 6 0

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
160

<!-- PDF page 161 -->

A frame received on the RGMII interface with a PHY error indication is subsequently
transferred on the Avalon streaming interface with the error signal rx_err[0]
asserted.
Figure 74. RGMII Receive with Error in Gigabit Mode
rx_clk
rx_control
rgmii_in[3:0] 00 5 0 4 6 0 1 0 0 8 0 9 0
The current implementation of the RGMII receive interface expects a positive-delay
rx_clk relative to the receive data (the clock comes after the data).

#### 6.2.7. MII Transmit

On transmit, all data transfers are synchronous to the rising edge of tx_clk. The MII
data enable signal, m_tx_en, is asserted to indicate the start of a new frame and
remains asserted until the last byte of the frame is present on m_tx_d[3:0] bus.
Between frames, m_tx_en remains deasserted.
If a frame is received on the FIFO interface with an error (ff_tx_err asserted) the
frame is subsequently transmitted with the MII error signal m_tx_err for one clock
cycle at any time during the frame transfer.

#### 6.2.8. MII Receive

On receive, all signals are sampled on the rising edge of rx_clk. The MII data enable
signal m_rx_en is asserted by the PHY to indicate the start of a new frame and
remains asserted until the last byte of the frame is present on m_rx_d[3:0] bus.
Between frames, m_rx_en remains deasserted.
If the PHY detects an error on the frame received from the line, the PHY asserts the
MII error signal, m_rx_err, for at least one clock cycle at any time during the frame
transfer.
A frame received on the MII interface with a PHY error indication is subsequently
transferred on the FIFO interface with the error signal rx_err[0] asserted.

#### 6.2.9. IEEE 1588v2 Timestamp

The following timing diagrams show the timestamp of frames observed on TX path for
the IEEE 1588v2 feature.
Figure below shows the TX timestamp signals for the IEEE 1588v2 feature in a 1-step
operation.
In a 1-step operation, a TX egress timestamp is inserted into timestamp field of the
PTP frame in the MAC. You need to drive the 1-step related signal appropriately so
that the timestamp can be inserted into the correct location of the packet. The input
signals related to the 2-step operation are not important and can be driven low or
ignored.

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
161

<!-- PDF page 162 -->

Figure 75. Egress Timestamp Insert for IEEE 1588v2 PTP Packet Encapsulated in IEEE
802.3
Egress Timestamp Insert, IEEE 1588v2, PTP Packet
2-step Timestamp Request,Input
tx_egress_timestamp_request_valid
tx_egress_timestamp_request_data[N:0]
2-step Timestamp Return,Output
tx_egress_timestamp_96b_valid
tx_egress_timestamp_96b_fingerprint[N:0]
tx_egress_timestamp_96b_data[95:0]
tx_egress_timestamp_64b_valid
tx_egress_timestamp_64b_fingerprint[N:0]
tx_egress_timestamp_64b_data[63:0]
1-step Timestamp Insert,Input
tx_etstamp_ins_ctrl_timestamp_insert
tx_etstamp_ins_ctrl_timestamp_format
1-step Residence Time Update,Input
tx_etstamp_ins_ctrl_residence_time_update
tx_etstamp_ins_ctrl_ingress_timestamp_96b[95:0]
tx_etstamp_ins_ctrl_ingress_timestamp_64b[63:0]
tx_etstamp_ins_ctrl_residence_time_calc_format
1-step IPv4 and IPv6 Checksum,Input
tx_etstamp_ins_ctrl_checksum_zero
tx_etstamp_ins_ctrl_checksum_correct
1-step Location Offset,Input
tx_etstamp_ins_ctrl_offset_timestamp[15:0] Offset 1
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
tx_etstamp_ins_ctrl_offset_correction_field[15:0] Offset 2
tx_etstamp_ins_ctrl_offset_checksum_field[15:0]
tx_etstamp_ins_ctrl_offset_checksum_correction[15:0]
Figure 76 on page 163 shows the TX timestamp signals for the first type of egress
correction field update, where the residence time is calculated by subtracting 96 bit
ingress timestamp from 96 bit egress timestamp. The result is updated in the
correction field of the PTP frame encapsulated over UDP/IPv4.
The tx_etstamp_ins_ctrl_residence_time_calc_format signal is driven low
to indicate that this is a 96b residence time calculation. The
tx_etstamp_ins_ctrl_checksum_zero signal is driven high to clear the UDP/IPv4
checksum field to all 0.

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
162

<!-- PDF page 163 -->

Figure 76. Type 1 Egress Correction Field Update
Type 1 Egress Correction Field Update, 96b, IPV4
2-step Timestamp Request,Input
tx_egress_timestamp_request_valid
tx_egress_timestamp_request_data[N:0]
2-step Timestamp Return,Output
tx_egress_timestamp_96b_valid
tx_egress_timestamp_96b_fingerprint[N:0]
tx_egress_timestamp_96b_data[95:0]
tx_egress_timestamp_64b_valid
tx_egress_timestamp_64b_fingerprint[N:0]
tx_egress_timestamp_64b_data[63:0]
1-step Timestamp Insert,Input
tx_etstamp_ins_ctrl_timestamp_insert
tx_etstamp_ins_ctrl_timestamp_format
1-step Residence Time Update,Input
tx_etstamp_ins_ctrl_residence_time_update
tx_etstamp_ins_ctrl_ingress_timestamp_96b[95:0]
tx_etstamp_ins_ctrl_ingress_timestamp_64b[63:0]
tx_etstamp_ins_ctrl_residence_time_calc_format
1-step IPv4 and IPv6 Checksum,Input
tx_etstamp_ins_ctrl_checksum_zero
tx_etstamp_ins_ctrl_checksum_correct
1-step Location Offset,Input
tx_etstamp_ins_ctrl_offset_timestamp[15:0]
Offset 1tx_etstamp_ins_ctrl_offset_correction_field[15:0]
Offset 2tx_etstamp_ins_ctrl_offset_checksum_field[15:0]
tx_etstamp_ins_ctrl_offset_checksum_correction[15:0]
Ingress Timestamp
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Figure 77 on page 164 shows the TX timestamp signals for the second type of egress
correction field update, where the 64 bit ingress timestamp has been pre-subtracted
from the correction field at the ingress port. At the egress port, the 64 bit egress
timestamp is added into the correction field and the correct residence time is updated
in the correction field. This is the example of PTP frame encapsulated over UPD/IPV6.
The tx_etstamp_ins_ctrl_residence_time_calc_format signal is driven high
to indicate that this is a 64b residence time calculation. The
tx_etstamp_ins_ctrl_checksum_correct signal is driven high to correct the
packet UPD/IPV6 checksum by updating the checksum correction field.

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
163

<!-- PDF page 164 -->

Figure 77. Type 2 Egress Correction Field Update
Type 2 Egress Correction Field Update, 64b, IPV6
2-step Timestamp Request,Input
tx_egress_timestamp_request_valid
tx_egress_timestamp_request_data[N:0]
2-step Timestamp Return,Output
tx_egress_timestamp_96b_valid
tx_egress_timestamp_96b_fingerprint[N:0]
tx_egress_timestamp_96b_data[95:0]
tx_egress_timestamp_64b_valid
tx_egress_timestamp_64b_fingerprint[N:0]
tx_egress_timestamp_64b_data[63:0]
1-step Timestamp Insert,Input
tx_etstamp_ins_ctrl_timestamp_insert
tx_etstamp_ins_ctrl_timestamp_format
1-step Residence Time Update,Input
tx_etstamp_ins_ctrl_residence_time_update
tx_etstamp_ins_ctrl_ingress_timestamp_96b[95:0]
tx_etstamp_ins_ctrl_ingress_timestamp_64b[63:0]
tx_etstamp_ins_ctrl_residence_time_calc_format
1-step IPv4 and IPv6 Checksum,Input
tx_etstamp_ins_ctrl_checksum_zero
tx_etstamp_ins_ctrl_checksum_correct
1-step Location Offset,Input
tx_etstamp_ins_ctrl_offset_timestamp[15:0]
Offset 1tx_etstamp_ins_ctrl_offset_correction_field[15:0]
Offset 2
tx_etstamp_ins_ctrl_offset_checksum_field[15:0]
tx_etstamp_ins_ctrl_offset_checksum_correction[15:0]
64’b0
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Figure 78 on page 165 shows the TX timestamp signals for the IEEE 1588v2 feature in
a two step operation.
When the tx_egress_timestamp_request_valid signal is driven high with a
unique fingerprint, the MAC returns an egress timestamp associated with that unique
fingerprint. The signals related to the 1-step operation can be driven low or ignored.
There is no modification to the packet content.

## 6. Interface Signals


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
164

<!-- PDF page 165 -->

Figure 78. Egress 2-Step Operation
Egress Two-Step Operation, IEEE 1588v2, PTP Packet
2-step Timestamp Request,Input
tx_egress_timestamp_request_valid
tx_egress_timestamp_request_data[N:0]
2-step Timestamp Return,Output
tx_egress_timestamp_96b_valid
tx_egress_timestamp_96b_fingerprint[N:0]
tx_egress_timestamp_96b_data[95:0]
tx_egress_timestamp_64b_valid
tx_egress_timestamp_64b_fingerprint[N:0]
tx_egress_timestamp_64b_data[63:0]
1-step Timestamp Insert,Input
tx_etstamp_ins_ctrl_timestamp_insert
tx_etstamp_ins_ctrl_timestamp_format
1-step Residence Time Update,Input
tx_etstamp_ins_ctrl_residence_time_update
tx_etstamp_ins_ctrl_ingress_timestamp_96b[95:0]
tx_etstamp_ins_ctrl_ingress_timestamp_64b[63:0]
tx_etstamp_ins_ctrl_residence_time_calc_format
1-step IPv4 and IPv6 Checksum,Input
tx_etstamp_ins_ctrl_checksum_zero
tx_etstamp_ins_ctrl_checksum_correct
1-step Location Offset,Input
tx_etstamp_ins_ctrl_offset_timestamp[15:0]
tx_etstamp_ins_ctrl_offset_correction_field[15:0]
tx_etstamp_ins_ctrl_offset_checksum_field[15:0]
tx_etstamp_ins_ctrl_offset_checksum_correction[15:0]
Fingerprint
Fingerprint
96b Egress Timestamp
Fingerprint
64b Egress Timestamp
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care
Don’t-care

## 6. Interface Signals


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
165

<!-- PDF page 166 -->


## 7. Design Considerations


### 7.1. Optimizing Clock Resources in Multiport MAC with PCS and

Embedded PMA
The following factors determine the total number of global and regional clock
resources required by your system:
• Configuration of the Triple-Speed Ethernet Intel FPGA IP and the blocks it contains
• PCS operating mode (SGMII or 1000BASE-X)
• PMA technology implemented in the target device
• Number of clocks that can share a single source
• Number of PMAs required in the design
• ALTGX megafunction operating mode
You can use the same clock source to drive clocks that are visible at the top-level
design, thus reducing the total number of clock sources required by the entire design.
**Table 117. Clock Signals Visible at Top-Level Design**

| Clocks | Configurations (18) | Column 3 | Column 4 |
| --- | --- | --- | --- |
|  | MAC Only | MAC and PCS | MAC and PCS with PMA |
| rx_recovclkout | — | — | Yes |
| ref_clk | — (19) | — (19) | Yes |
| clk | Yes | Yes | Yes |
| ff_tx_clk (20) | Yes | Yes | Yes |
| ff_rx_clk (20) | Yes | Yes | Yes |
|  | MAC Only | MAC and PCS | MAC and PCS with PMA |
| tx_clk | Yes | No | No |
| rx_clk | Yes | No | No |
| tbi_rx_clk | — | Yes | No |
| tbi_tx_clk | — | Yes | No |
| gxb_cal_blk_clk (21) | — | — | Yes |
| reconfig_clk | — | — | Yes |

Clock signals that are visible at the top-level design for each possible configuration.
(18) Yes indicates that the clock is visible at the top-level design.
No indicates that the clock is not visible at the top-level design.
— indicates that the clock is not applicable for the given configuration.
(19) This clock is visible at the top-level design and needs to be connected to a clock source for the
multiport fifoless Ethernet MAC ONLY and fifoless Ethernet MAC with SGMII PCS
configurations. For single channel fifoless MAC configuration ONLY and fifoless MAC with
SGMII disabled in PCS, this clock is not used and can be tied to GND.
(20) These signals are only visible on the single port MAC with internal FIFO buffers. They are only
visible when the multiport Ethernet design is implemented through the replication of the
single port MAC with internal FIFO buffers.

# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 167 -->


#### 7.1.1. MAC and PCS With GX Transceivers

In configurations that contain the MAC, PCS, and GX transceivers, you have the
following options in optimizing clock resources:
• Utilize the same reset signal for all MAC instances if you do not require a separate
reset for each instance.
• Utilize the same reference clock for all PMA quads
• Utilize the same clock source to drive the reference clock, FIFO transmit and
receive clocks, and system clocks, if these clocks run at the same frequency.
The Intel Quartus Prime software automatically optimizes the TBI transmit clocks.
Only one clock source drives the TBI transmit clocks from each PMA quad.
The calibration clock (gxb_cal_blk_clk) calibrates the termination resistors in all
transceiver channels in a device. As there is only one calibration circuit in each device,
one clock source suffices.
Note: If you do not constrain the PLL inputs and outputs in your design, add
derive_pll_clocks in the timing constraint file to ensure that the Timing Analyzer
automatically creates derived clocks for the PLL outputs.
(18) Yes indicates that the clock is visible at the top-level design.
No indicates that the clock is not visible at the top-level design.
— indicates that the clock is not applicable for the given configuration.
(21) Applies to GX transceiver.

## 7. Design Considerations


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
167

<!-- PDF page 168 -->

Figure 79. Clock Distribution in MAC and SGMII PCS with GXB Configuration—Optimal
Case
Figure shows the optimal clock distribution scheme you can achieve in configurations that contain the
10/100/1000 Ethernet MAC, SGMII PCS, and GX transceivers.
tbi_tx_clk1
tbi_rx_clk1
tbi_rx_clk2
tbi_rx_clk3
tbi_rx_clk4
Port 4
clk1
clk2
clk3
clk4
PCS 1
rx_clk1
tx_clk1
PCS 2
rx_clk2
tx_clk2
PCS 3
rx_clk3
tx_clk3
PCS 4rx_clk4
tx_clk4
4-port MAC
Port 2
Port 3
ref_clk
rx_clk1
tx_clk1
rx_clk2
tx_clk2
rx_clk3
tx_clk3
rx_clk4
tx_clk4
ALTGX
(GIGE Mode)
Quad
Transceivers
cal_blk_clk
ref_clk
To subsequent Quads, if any
tbi_tx_clk2
tbi_tx_clk3
tbi_tx_clk4
Port 1
tx_clk_en1
rx_clk_en1
tx_clk_en2
rx_clk_en2
tx_clk_en3
rx_clk_en3
tx_clk_en1
rx_clk_en1
ALTGX
(GIGE Mode)
ALTGX
(GIGE Mode)
ALTGX
(GIGE Mode)
Note to Figure 79 on page 168:

## 1. The PMA layer in devices with GX transceivers uses ALTGX IP.

In addition to the aforementioned optimization options, the TBI transmit and receive
clocks can be used to drive the MAC transmit and receive clocks, respectively.

## 7. Design Considerations


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
168

<!-- PDF page 169 -->

Figure 80. Clock Distribution in MAC and 1000BASE-X PCS with GXB Configuration—
Optimal Case
Figure shows the optimal clock distribution scheme you can achieve in configurations that contain the
10/100/1000 Ethernet MAC, 1000Base-X PCS, and GX transceivers.
ALTGX
(GIGE Mode )
ALTGX
(GIGE Mode )
ALTGX
(GIGE Mode )
Quad
Transceivers
ALTGX
(GIGE Mode )
Port 2
4-port MAC
cal_blk_clk
ref_clk
tbi_rx_clk1
tbi_rx_clk2
tbi_rx_clk3
tbi_rx_clk4
rx_clk1
tx_clk1
rx_clk2
tx_clk2
rx_clk3
tx_clk3
To subsequent Quads, if any
Port 4
Port 3
rx_clk4
tx_clk4
clk1
clk2
clk3
clk4
PCS 1
PCS 2
PCS 3
PCS 4
tbi_tx_clk
Port 1
Note to Figure 80 on page 169 :

## 1. The PMA layer in devices with GX transceivers uses ALTGX megafunctions.


#### 7.1.2. MAC and PCS With LVDS Soft-CDR I/O

In configurations that contain the MAC, PCS, and LVDS Soft-CDR I/O, you have the
following options in optimizing clock resources:

## 7. Design Considerations


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
169

<!-- PDF page 170 -->

• Utilize the same reset signal for all MAC instances if you do not require a separate
reset for each instance.
• Utilize the same clock source to drive the reference clock, FIFO transmit and
receive clocks, and system clocks, if these clocks run at the same frequency.
Figure 81. Clock Distribution in MAC and SGMII PCS with LVDS Configuration—Optimal
Case
Figure shows the optimal clock distribution scheme you can achieve in configurations that contain the MAC,
SGMII PCS and LVDS Soft-CDR I/O.
tbi_tx_clk
tbi_rx_clk1
tbi_rx_clk2
tbi_rx_clk3
tbi_rx_clk4
clk1
clk2
clk3
clk4
PCS1
rx_clk1
tx_clk1
PCS2
rx_clk2
tx_clk2
PCS3
rx_clk3
tx_clk3
PCS4
rx_clk4
tx_clk4
4-portMAC
Port 1
ref_clk
LVDS RXCOMPONENT
PLL
pllpll~clk1rx_clk1
tx_clk1
rx_clk2
tx_clk2
rx_clk3
tx_clk3
rx_clk4
tx_clk4
Port 2
Port 3
Port 4
tx_clk_en1
rx_clk_en1
tx_clk_en2
rx_clk_en2
tx_clk_en3
rx_clk_en3
tx_clk_en4
rx_clk_en4
LVDS TX
COMPONENT
LVDS RX COMPONENT
LVDS TX
COMPONENT
LVDS TX
COMPONENT
LVDS RX COMPONENT
LVDS RX COMPONENT
LVDS TX
COMPONENT

## 7. Design Considerations


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
170

<!-- PDF page 171 -->

Figure 82. Clock Distribution in MAC and 1000BASE-X PCS with LVDS Configuration—
Optimal Case
Figure shows the optimal clock distribution scheme you can achieve in configurations that contain the MAC,
1000BASE-X PCS, and LVDS Soft-CDR I/O.
Port 1

# 4 -port MAC

tbi_tx_clk
tbi_rx _clk 1
tbi_rx _clk 2
tbi_rx _clk 3
tbi_rx _clk 4
rx _clk 1
tx_clk 1
rx _clk 2
tx_clk 2
rx _clk 3
tx_clk 3
Port 4
Port 3
rx _clk 4
tx_clk 4
clk 1
clk 2
clk 3
clk 4
PCS 1
PCS 2
PCS 3
PCS 4
ref _clk
PLL
pll
pll~clk 1
Port 2
LVDS RX
COMPONENT
LVDS TX
COMPONENT
LVDS RX
COMPONENT
LVDS RX
COMPONENT
LVDS RX
COMPONENT
LVDS TX
COMPONENT
LVDS TX
COMPONENT
LVDS TX
COMPONENT
Notes to Figure 81 on page 170 and Figure 82 on page 171:

## 1. There may be a performance risk if you use the Triple-Speed Ethernet Intel FPGA

IP variant with LVDS I/O for PMA implementation in Intel Arria 10 devices for Intel
Quartus Prime software versions 17.0.2 and earlier. To avoid the performance risk,
Intel recommends that you regenerate the Triple-Speed Ethernet Intel FPGA IP
and recompile the design in the Intel Quartus Prime software version 17.1 or later.

## 7. Design Considerations


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
171

<!-- PDF page 172 -->

To download and install the software patch for Intel Quartus Prime version 17.0.2,
refer to KDB Link: Performance Risk Running Triple Speed Ethernet LVDS in Arria

# 10 Devices.


## 2. For Intel Quartus Prime software version 17.1 onwards, the number of ports

supported for Triple-Speed Ethernet design targeting Intel Stratix 10, Intel Arria
10, and Intel Cyclone 10 GX devices is 8 per instance. To avoid performance risk,
you must not promote the reference clock to global clock manually. Assign the
number of ports supported and its reference clock to the same I/O bank as inter-
bank clock sharing is not allowed.
Related Information
• Core Configuration on page 26
• KDB Link: Performance Risk Running Triple Speed Ethernet LVDS in Intel Arria 10
Devices
• Sharing PLLs in Devices with LVDS Soft-CDR I/O on page 172
• Intel Agilex Device Pin-Out Files

### 7.2. Sharing PLLs in Devices with LVDS Soft-CDR I/O

For Intel Agilex devices, you must adhere to the following LVDS soft-CDR placement
guidelines to avoid Quartus design compilation fitter error:
• In each GPIO bank of the Intel Agilex FPGA device, there are two sub-banks. The
top sub-bank has pin indexes from 48-95 and supports a maximum of 4 LVDS
soft-CDR I/O. The bottom sub-bank has pin indexes from 0-47 and supports a
maximum of 8 LVDS soft-CDR I/O.
• For the exact location of the LVDS soft-CDR I/O pin, refer to the Intel Agilex
device pin-out files.
• One Triple-Speed Ethernet IP cannot support LVDS soft-CDR I/O that has a
mixture channel placement in both top and bottom sub-banks. You must constrain
the LVDS soft-CDR I/O channel placement to either the top sub-bank or bottom
sub-bank only.
For Intel Stratix 10, Intel Arria 10, and Intel Cyclone 10 GX devices, you cannot share
PLLs for designs that contain multiple instances of MAC and PCS with PMA or PCS with
PMA variation targeting devices with LVDS soft-CDR I/O. The Intel Quartus Prime
software will not merge the PLLs for these instances. Therefore, each of the design
instance must be implemented in a different I/O bank with a dedicated clock path.
For older devices, you can optimize the resource utilization by sharing the PLLs for
designs that contain multiple instances of MAC and PCS with PMA or PCS with PMA
variation targeting devices with LVDS soft-CDR I/O.
The Intel Quartus Prime software merges the PLLs for these instances if you
implement the following items in your design:
• Connect the reference clock of each instance to the same source.
• Place the LVDS I/O pins on the same side of the FPGA.

## 7. Design Considerations


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
172

<!-- PDF page 173 -->

Note: For Intel Quartus Prime software version 17.1 onwards, the number of ports supported
for Triple-Speed Ethernet design targeting Intel Stratix 10, Intel Arria 10, and Intel
Cyclone 10 GX devices is 8 ports per instance. Assign the number of ports supported
and its reference clock to the same I/O bank as inter-bank clock sharing is not
allowed.
Related Information
• MAC and PCS With LVDS Soft-CDR I/O on page 169
• Intel Agilex Device Pin-Out Files

### 7.3. Sharing PLLs in Devices with GIGE PHY

For Cyclone V designs that contain multiple instances of MAC and PCS with PMA or
PCS with PMA variation targeting devices with GIGE PHY, you can share the PLLs by
placing the associated signals (tx_p, rx_p, and ref_clk) to the same I/O block of
transceiver bank through pin assignment. Additionally, the rx_recovclkout clock
must be buffered by two levels of inverter in the top level module so that it can be
fitted to the general I/O pins.

### 7.4. Sharing Transceiver Quads

For designs that contain multiple PMA blocks targeting Intel FPGA device families with
GX transceivers, you can combine the transceiver channels in the same quad. To share
the same transceiver quad, the transceiver channels must have the same dynamic
reconfiguration setting. In other words, you must turn on dynamic reconfiguration
capabilities in all channels in a quad even though you only intend to use these
capabilities in some of the channels.
The dynamic reconfiguration is always turned on in devices other than Arria GX and
Stratix II GX. When the dynamic reconfiguration is turned on in designs targeting
devices other than Intel Arria 10, Stratix V, Arria V, Intel Cyclone 10 GX, and Cyclone
V, Intel recommends that you connect the dynamic reconfiguration signals to the
ALTGX_RECONFIG megafunction.
In Stratix V, Arria V, and Cyclone V devices, Intel recommends that you connect the
dynamic reconfiguration signals to the Transceiver Reconfiguration Controller
megafunction. For transceiver quad sharing between Triple-Speed Ethernet Intel FPGA
IP and other IPs that target these devices, reset signal for all the cores must be from
the same source.
Refer to the respective device handbook for more information on dynamic
reconfiguration signals in Intel FPGA devices.

### 7.5. Migrating From Old to New User Interface For Existing Designs

In the Intel Quartus Prime software version 13.0, the old Triple-Speed Ethernet IP
user interface is deprecated. Existing Triple-Speed Ethernet designs generated prior to
version 13.0 can still load properly in the Intel Quartus Prime software version 13.0.
However, starting from version 13.1, the old Triple-Speed Ethernet interface and
design generated using the old interface will not be supported.

## 7. Design Considerations


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
173

<!-- PDF page 174 -->

You need to manually migrate your design to the new user interface. Reopening and
saving the existing design created with the old user interface will not automatically
convert the design to the new user interface.
To migrate your design to the new user interface, launch the Intel Quartus Prime
software version 13.0 or later, create a new project, and specify the parameters as
described in Design Walkthrough on page 21.
Note: For target devices with LVDS I/O such as Intel Stratix 10, Intel Arria 10, and Intel
Cyclone 10 GX, Intel recommends that you migrate your Triple-Speed Ethernet
designs to Intel Quartus Prime software version 17.1 and later.

#### 7.5.1. Exposed Ports in the New User Interface

In the new user interface in Platform Designer, for a design that has a MAC function,
you have to manually connect the exposed ports or terminate them.
In MAC variation with internal FIFO buffers, the ready latency is two in both
standalone and Platform Designer flow. The Platform Designer system inserts a timing
adapter to change the ready latency to zero.
**Table 118. Exposed Ports and Recommended Termination Value for MAC Variation With**

| Port Name | I/O | Width | Recommended<br>Termination Value |
| --- | --- | --- | --- |
| xon_gen | I | 1 | 1'b0 |
| xoff_gen | I | 1 | 1'b0 |
| magic_wakeup | O | 1 | Left open |
| magic_sleep_n | I | 1 | 1'b1 |
| ff_tx_crc_fwd | I | 1 | 1'b0 |
| ff_tx_septy | O | 1 | Left open |
| tx_ff_uflow | O | 1 | Left open |
| ff_tx_a_full | O | 1 | Left open |
| ff_tx_a_empty | O | 1 | Left open |
| rx_err_stat | O | 18 | Left open |
| rx_frm_type | O | 4 | Left open |
| ff_rx_dsav | O | 1 | Left open |
| ff_rx_a_full | O | 1 | Left open |
| ff_rx_a_empty | O | 1 | Left open |

Internal FIFO Buffers
The following table lists the following ports that are exposed in the Platform Designer
system for a design that has MAC variation without internal FIFO buffers.

## 7. Design Considerations


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
174

<!-- PDF page 175 -->

**Table 119. Exposed Ports and Recommended Termination Value for MAC Variation**

| Port Name | I/O | Width | Recommended<br>Termination Value |
| --- | --- | --- | --- |
| xon_gen_<n> | I | 1 | 1'b0 |
| xoff_gen_<n> | I | 1 | 1'b0 |
| magic_wakeup_<n> | O | 1 | Left open |
| magic_sleep_n_<n> | I | 1 | 1'b1 |
| ff_tx_crc_fwd_<n> | I | 1 | 1'b0 |

Without Internal FIFO Buffers

### 7.6. Clocking Scheme of MAC with 2XTBI PCS and Embedded PMA

The following is the clocking scheme of the design that contains MAC with 2XTBI and
embedded PMA on E-tile and F-tile:
• 2XTBI PCS runs on 125 MHz and 62.5 MHz clocks while the same 125 MHz clock is
used by MAC.
• The 125 MHz and 62.5 MHz clocks must be synchronous, in which their rising
edges must align and must have 0 ppm and phase shift.
• The E-tile Native PHY and F-tile Direct PHY are the embedded PMAs in this variant.
The tx_clkout and rx_clkout on the E-tile Native PHY and F-tile Direct PHY
are used as clock sources for 2XTBI PCS tbi2x_tx_clk and tbi2x_rx_clk.
• Logic is implemented in the PCS block for clock rate matching by default
regardless whether the ENABLE_SGMII option is selected. Therefore, the 125 MHz
and 62.5 MHz clocks do not need to be at 0 ppm in comparison with tx_clkout
and rx_clkout, which are usually provided by external SERDES.
• The E-tile Native PHY and F-tile Direct PHY transceivers are driven by the 156.25
MHz clock.
**Table 120. Clock Signals Visible at Top-Level Design**

| Clocks | Configurations (22) | Column 3 |
| --- | --- | --- |
|  | MAC and 2XTBI PCS with PMA | 2XTBI PCS Only |
| clk | Yes | N/A |
| reg_clk | No | Yes |
| ff_tx_clk | Yes | N/A |
| ff_rx_clk | Yes | N/A |
| tx_clk_125 | Yes | Yes |
| rx_clk_125 | Yes | Yes |
|  | MAC and 2XTBI PCS with PMA | 2XTBI PCS Only |
| tx_clk_62_5 | Yes | Yes |
| rx_clk_62_5 | Yes | Yes |
| tbi2x_tx_clk | No | Yes |
| tbi2x_rx_clk | No | Yes |
| pll_refclk0 (23) | Yes | N/A |
| tx_clkout (23) | No | N/A |
| rx_clkout (23) | No | N/A |

Clock signals that are visible at the top-level design for each possible configuration.
(22) Yes indicates that the clock is visible at the top-level design.
No indicates that the clock is not visible at the top-level design.
N/A indicates that the clock is not applicable for the given configuration.

## 7. Design Considerations


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
175

<!-- PDF page 176 -->

Figure 83. Clock Connectivity in MAC with 2XTBI PCS and Embedded PMA
MAC 2XTBI PCS E-Tile Transceiver
Native PHY
tx_clkena
tx_clk_125
rx_clk_125
rx_clkena
ff_rx_clk
ff_tx_clk
clk reg_clk
tbi2x_rx_clkrx_clkout
IOPLL

# 125 MHz

Clock Source rx_clk_62_5

## 62.5 MHz(1) (2)

(3)
(3)
(4)
Notes to Figure 83 on page 176:

## 1. Intel recommends that the rx_clk_125, tx_clk_125, rx_clk_62_5, and

tx_clk_62_5 share the same clock source.

## 2. Therefore, Intel recommends you to use one IOPLL with two output clocks to get

the 125 MHz and 62.5 MHz clocks and connect to both the TX and RX datapaths.

## 3. rx_clkout and tx_clkout are output clocks generated by the E-tile transceiver

Native PHY and F-tile transceiver Direct PHY and internally connected to
tbi2x_rx_clk and tbi2x_tx_clk in the variant MAC with 2XTBI and
embedded PMA.

## 4. The reg_clk clock is internally connected to clk in the variant MAC with 2XTBI

and embedded PMA. Refer to Table 106 on page 150 for more information about
reg_clk.
(22) Yes indicates that the clock is visible at the top-level design.
No indicates that the clock is not visible at the top-level design.
N/A indicates that the clock is not applicable for the given configuration.
(23) Clock signals of E-tile transceiver Native PHY and F-tile transceiver Direct PHY.

## 7. Design Considerations


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
176

<!-- PDF page 177 -->


## 8. Timing Constraints

Intel provides timing constraint files (.sdc) to ensure that the Triple-Speed Ethernet
Intel FPGA IP meets the design timing requirements in Intel FPGA devices. The files
constraints the false paths and multi-cycle paths in the Triple-Speed Ethernet Intel
FPGA IP. The timing constraints files are specified in the <variation_name>.qip file
and is automatically included in the Intel Quartus Prime project files.
You may need to add timing constraints that are external to the IP. The following
sections describe the procedure to create the timing constraint file.

### 8.1. Creating Clock Constraints

After you generate and integrate the Triple-Speed Ethernet Intel FPGA IP into the
system, you need to create a timing constraints file to specify the clock constraint
requirement.
You can specify the clock requirement in the timing constraint file using the following
command:
create_clock
For example, for a new clock named "reg_clk", with a 50 MHz clock targeted to the
top level input port "clk", enter the following command line:
create_clock -name "reg_clk" -period "50 MHz" [get_ports "clk"]
Figure below shows an example of how you can create a timing constraint file to
constrain the Triple-Speed Ethernet Intel FPGA IP clocks.
Figure 84. Triple-Speed Ethernet Timing Constraint Example
The reconfig_clk signal is not shown in this example. Constrain the reconfig_clk based on your design
implementation.
user_instance.v
TOP .v
Intel FPGA PLL
10/100/1000-Mbps Ethernet MACwith 1000BASE-X/SGMIIPCS and PMA(with internal FIFO)ff_tx_clk
ff_rx_clk
tse_variation.v
ref_clk
clk
ext_clkpll_inclk100-Mhz 50-Mhz
100-Mhz*
inclk0
c1 c0
xcvr_ref_clk
125-Mhz
* For 32-bit FIFO width, Intel recommneds to use 100 MHz for c0 PLL output clock.
For 8-bit FIFO width, Intel recommneds to use 125 MHz for c0 PLL output clock.

# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 178 -->

The example above consists of the following Verilog modules:
• TOP.v—The top level design module which contains an Intel FPGA PLL and a user-
defined instance. The top level input clocks consist of pll_inclk, ext_clk, and
xcvr_ref_clk.
• user_instance.v—The user-defined instance that instantiates the Triple-Speed
Ethernet Intel FPGA IP.
• tse_variation.v—A Triple-Speed Ethernet Intel FPGA IP variation. This
example uses a 10/100/1000-Mbps Ethernet MAC with an internal FIFO buffer, a
1000BASE-X/SGMII PCS, and an embedded PMA.
The frequency for the PLL clock input, inclk0, is 100 MHz, and the frequency for the
PLL clock output, c0, is 100 MHz. The Triple-Speed Ethernet MAC Avalon streaming
clocks, ff_tx_clk and ff_rx_clk, use c0 as the clock source. The input clock
frequency for the transceiver reference clock, xcvr_ref_clk, is 125 MHz.
Example of the Triple-Speed Ethernet IP timing constraint file:
# PLL clock input, 100 MHz
create_clock -name pll_inclk -period 10.000 [get_ports {pll_inclk}]
# ext_clk, 50 MHz
create_clock -name ext_clk -period 20.000 [get_ports {ext_clk}]
# xcvr_ref_clk, 125 MHz
create_clock -name xcvr_ref_clk -period 8.000 [get_ports {xcvr_ref_clk}]
# Derive PLL generated output clocks.
derive_pll_clocks
Note: The derive_pll_clocks command is not supported in Intel Stratix 10 devices
because all PLL clocks are automatically generated by the SDC files generated
alongside the PLL IP.

### 8.2. Recommended Clock Frequency

**Table 121. Recommended Clock Input Frequency For Each IP Variant**

| IP Variant | Clock | Recommended Frequency<br>(MHz) |
| --- | --- | --- |
| 10/100/1000-Mbps Ethernet MAC (with Internal<br>FIFO buffers) | CLK | 50–125 |
|  | TX_CLK | 125 |
|  | RX_CLK | 125 |
|  | FF_TX_CLK | • For 32 bits FIFO: 100<br>• For 8 bits FIFO: 125 |
|  | FF_RX_CLK | • For 32 bits FIFO: 100<br>• For 8 bits FIFO: 125 |
| 10/100/1000-Mbps Ethernet MAC (without Internal<br>FIFO buffers) | CLK | 50–125 |
|  | TX_CLK <N> | 125 |
|  | RX_CLK <N> | 125 |
|  | RX_AFULL_CLK | 100 |
| 10/100/1000-Mbps Ethernet MAC with 1000BASE-<br>X/SGMII PCS (with Internal FIFO buffers) | CLK | 50–125 |
|  | FF_TX_CLK | • For 32 bits FIFO: 100<br>• For 8 bits FIFO: 125 |
|  | FF_RX_CLK | • For 32 bits FIFO: 100<br>• For 8 bits FIFO: 125 |
|  | TBI_TX_CLK | 125 |
|  | TBI_RX_CLK | 125 |
|  | REF_CLK | 125 |
|  | RECONFIG_CLK (24) | 37.5–50 |
|  | GXB_CAL_BLK_CLK | 125 |
| 10/100/1000-Mbps Ethernet MAC with 1000BASE-<br>X/SGMII PCS (without Internal FIFO buffers) | CLK | 50–125 |
|  | RX_AFULL_CLK | 100 |
|  | TBI_TX_CLK <N> | 125 |
|  | TBI_RX_CLK <N> | 125 |
|  | REF_CLK | 125 |
|  | RECONFIG_CLK <N> (24) | 37.5–50 |
|  | GXB_CAL_BLK_CLK | 125 |
| 1000BASE-X/SGMII PCS only | CLK | 50–125 |
|  | REF_CLK | 125 |
|  | TBI_TX_CLK | 125 |
|  | TBI_RX_CLK | 125 |
| 10/100/1000 Ethernet MAC with 1000BASE-X/<br>SGMII 2XTBI (with Internal FIFO buffers) | CLK | 50–125 |
|  | TX_CLK_125 | 125 |
|  | RX_CLK_125 | 125 |
|  | FF_TX_CLK | • For 32 bits FIFO: 100<br>• For 8 bits FIFO: 125 |
|  | FF_RX_CLK | • For 32 bits FIFO: 100<br>• For 8 bits FIFO: 125 |
|  | TX_CLK_62_5 | 62.5 |
|  | RX_CLK_62_5 | 62.5 |
|  | PLL_REFCLK0 | 156.25 |
| 1000BASE-X/SGMII 2XTBI PCS only | CLK | 50–125 |
|  | TX_CLK_125 | 125 |
|  | RX_CLK_125 | 125 |
|  | TX_CLK_62_5 | 62.5 |
|  | RX_CLK_62_5 | 62.5 |


## 8. Timing Constraints


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
178

<!-- PDF page 179 -->

(24) This signal is only applicable to all device family prior to the 28-nm devices, which consists of
the Stratix V, Arria V, Arria V GZ, and Cyclone V devices.

## 8. Timing Constraints


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
179

<!-- PDF page 180 -->


## 8. Timing Constraints


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
180

<!-- PDF page 181 -->


## 9. Testbench

You can use the testbench provided with the Triple-Speed Ethernet Intel FPGA IP to
exercise your custom IP variation. The testbench includes the following features:
• Easy-to-use simulation environment for any standard HDL simulator.
• Simulation of all basic Ethernet packet transactions.
• Open source Verilog HDL and VHDL testbench files.
The provided testbench applies only to custom IP variations created using Platform
Designer.

### 9.1. Triple-Speed Ethernet Testbench Architecture

Figure 85. Triple-Speed Ethernet Testbench Architecture
Device Under Test
Frame
Generator
System
Side Ethernet
Side
Port 0
Port 2
Port n . . .
Port 1
Frame
Monitor MDIO
Slave 0
MDIO
Slave 1Testbench Control
Simulation Configuration Parameters

### 9.2. Testbench Components

The testbench comprises the following modules:

# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 182 -->

• Device under test (DUT)—Your custom IP variation
• Avalon streaming Ethernet frame generator—Simulates a user application
connected to the MAC system-side interface. It generates frames on the Avalon
streaming transmit interface.
• Avalon streaming Ethernet frame monitor—Simulates a user application receiving
frames from the MAC system-side interface. It monitors the Avalon streaming
receive interface and decodes all data received.
• MII/RGMII/GMII Ethernet frame generator—Simulates a MAC function that sends
frames to the PCS function.
• MII/RGMII/GMII Ethernet frame monitor—Simulates a MAC function that receives
frames from the PCS function and decodes them.
• MDIO slaves—Simulates a PHY management interface. It responds to an MDIO
master transactor.
• Clock and reset generator.
**Table 122. Testbench Components**

| Configuration | System-Side<br>Interface | Ethernet-Side<br>Interface | Frame Generator | Frame Monitor |
| --- | --- | --- | --- | --- |
| MAC only | Avalon streaming<br>interface | GMII/MII/RGMII | Avalon streaming<br>frame generator | Avalon streaming<br>frame monitor |
| MAC with PCS | Avalon streaming<br>interface | TBI | Avalon streaming<br>frame generator | Avalon streaming<br>frame monitor |
| MAC with PCS and<br>embedded PMA | Avalon streaming<br>interface | 1.25 Gbps | Avalon streaming<br>frame generator | Avalon streaming<br>frame monitor |
| PCS only | GMII/MII | TBI | GMII/MII frame<br>generator | GMII/MII frame<br>monitor |
| PCS with embedded<br>PMA | GMII/MII | 1.25 Gbps | GMII/MII frame<br>generator | GMII/MII frame<br>monitor |




### 9.3. Testbench Verification

The testbench is self-checking and determines the success of a simulation by verifying
the frames received. It also checks for any errors detected by the frame monitors. The
testbench does not verify the IEEE statistics generated by the MAC layer. Simulation
fails only if the testbench is not able to detect deliberately inserted errors. At the end
of a simulation, the testbench displays messages in the simulator console indicating its
results.

## 9. Testbench


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
182

<!-- PDF page 183 -->

The testbench verifies the following functionality:
• Transmit and receive datapaths are functionally correct.
• Ethernet frames generated by the frame generator are received by the frame
monitor.
• Additional checks for configurations that contain the MAC function:
— Correct CRC-32 is inserted.
— Short frames are padded up to at least 64 bytes in length.
— Untagged received frames of size greater than the maximum frame length are
truncated to the maximum frame length with additional bytes up to 12.
— CRC-32 is optionally discarded before the frames are received by the traffic
monitor.
• Additional checks for configurations that contain the PCS function with optional
embedded PMA:
— Transmit frames generated by the frame generator are correctly encapsulated.
— Received frames are de-encapsulated before they are forwarded to the frame
monitor.

### 9.4. Testbench Configuration

The testbench is configured, by default, to operate in loopback mode. Frames sent
through the transmit path are looped back into the receive path.
Separate data paths can be configured for single-channel MAC with internal FIFO
buffers. In this configuration, the MII/GMII Ethernet frame generator is enabled and
the testbench control block simulates independent yet complete receive and transmit
datapaths.
You can also customize other aspects of the testbench using the testbench simulation
parameters.

## 9. Testbench


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
183

<!-- PDF page 184 -->

The device under test is configured with the following default settings:
• Link speed is set to Gigabit except for configurations that contain Small MAC. For
Small MACs, the default speed is 100 Mbps.
• Five Ethernet frames of payload length 100, 101, 102, 103 and 104 bytes are
transmitted to the system-side interface and looped back on the ethernet-side
interface.
• Default settings for the MAC function:
— The command_config register is set to 0x0408003B.
— Promiscuous mode is enabled.
— The maximum frame length, register frm_length, is configured to 1518.
— For a single-channel MAC with internal FIFO buffers, the transmit FIFO buffer
is set to start data transmission as soon as its level reaches
tx_section_full. The receive FIFO buffer is set to begin forwarding
Ethernet frames to the Avalon streaming receive interface when its level
reaches rx_section_full.
• Default setting for the PCS function:
— The if_mode register is set to 0x0000.
— Auto-negotiation between the local PHY and remote link PHY is bypassed.

### 9.5. Test Flow

The testbench performs the following operations upon a simulated power-on reset:
• Initializes the DUT registers.
• Starts transmission. For a single-channel MAC with internal FIFO buffers, clears
the FIFOs.
• Ends transmission and checks the following elements to determine that the
simulation is successful:
— No Ethernet protocol errors detected.
— Ethernet frames generated and transmitted are received by the frame monitor.

### 9.6. Simulation Model

This section describes the step-by-step instructions for generating the simulation
model and simulating your design using the ModelSim simulator or other simulators.

#### 9.6.1. Generate the Simulation Model

The generated design example includes both Verilog HDL and VHDL testbench files for
the device under test (DUT)—your custom IP variation.

## 9. Testbench


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
184

<!-- PDF page 185 -->

To generate a Verilog functional simulation model, use the command prompt and run
the quartus_sh -t generate_sim_verilog.tcl file. Alternatively, perform the
following steps:

## 1. Launch the Intel Quartus Prime software and browse to the

<variation name>_testbench directory.

## 2. Open the generate_sim.qpf file from the project directory.


## 3. On the Tools menu, select Tcl Scripts and select the generate_sim_verilog.tcl

file.

## 4. Click Run.

To generate a VHDL functional simulation model, you can use the command prompt
and run the quartus_sh -t generate_sim_vhdl.tcl file. Alternatively, perform
the following steps:

## 1. Launch the Intel Quartus Prime software and browse to the

<variation name>_testbench directory.

## 2. Open the generate_sim.qpf file from the project directory.


## 3. On the Tools menu, select Tcl Scripts and browse to the

generate_sim_vhdl.tcl file.

## 4. Click Run.


#### 9.6.2. Simulate the IP

You can simulate your IP variation with the functional simulation model and the
testbench or design example generated with your IP. The functional simulation model
and testbench files are generated in a project subdirectory. This directory may also
include scripts to compile and run the testbench.
For a complete list of models or libraries required to simulate your IP, refer to the
scripts provided with the testbench in Simulation Model Files on page 186.
Generate the simulation model as shown in Generate the Simulation Model on page

# 184 before simulating the testbench design.

To use the ModelSim simulation software to simulate the testbench design, follow
these steps:

## 1. For Verilog testbench design:

a. Browse to the following project directory: < variation name>_testbench/
testbench_verilog/<variation name>
b. Run the following command to set up the required libraries, to compile the
generated IP Functional simulation model, and to exercise the simulation
model with the provided testbench:
do run_<variation_name>_tb.tcl

## 2. For VHDL testbench design:

a. Browse to the following project directory: < variation name>_testbench/
testbench_vhdl/<variation name>_testbench
b. Run the following command to set up the required libraries, to compile the
generated IP Functional simulation model, and to exercise the simulation
model with the provided testbench:

## 9. Testbench


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
185

<!-- PDF page 186 -->

do run_<variation_name>_tb.tcl
For more information about simulating Intel FPGA IPs, refer to the Simulating Intel
FPGA Designs section in the respective Intel Quartus Prime Pro Edition User Guide:
Third-party Simulation and Intel Quartus Prime Standard Edition User Guide:
Third-party Simulation.
Note: Use the simulation models only for simulation and not for synthesis or any
other purposes. Using these models for synthesis creates a nonfunctional
design.
Related Information
• Intel Quartus Prime Pro Edition User Guide: Third-party Simulation
• Intel Quartus Prime Standard Edition User Guide: Third-party Simulation

#### 9.6.3. Simulation Model Files

Previously, the Triple-Speed Ethernet Intel FPGA IP generates a
<variation_name>.vho or <variation_name>.vo file for VHDL or Verilog HDL IP
functional simulation model.
For the new Triple-Speed Ethernet Intel FPGA IP created in Intel Quartus Prime
software version 13.0, the simulation model will be generated using the industrial
standard IEEE simulation encryption.
The following table lists the scripts available for you to compile the simulation model
files in a standalone flow.
Note: The simulation support is different in Intel Quartus Prime Windows and Linux version.
Therefore, some of the files generated can be used only in the Linux environment.
Refer to the Intel Quartus Prime User Guide: Third-party Simulation for more details.
**Table 123. Simulation Model Files**

| Directory Name | Description |
| --- | --- |
| sim/mentor/ | Contains a ModelSim script msim_setup.tcl to set up and<br>run a simulation.<br>Note: The ModelSim-AE simulator is not supported for<br>10/100/1000 Ethernet MAC with 1000BASE-X/SGMII<br>2XTBI PCS variant. You must use another supported<br>ModelSim simulator such as ModelSim SE. |
| sim/synopsys/vcs/ | Contains a shell script vcs_setup.sh to set up and run a<br>VCS* simulation. |
| sim/synopsys/vcsmx/ | Contains a shell script vcsmx_setup.sh and<br>synopsys_sim.setup to set up and run a VCS MX<br>simulation. |
| sim/aldec/ | Contains a Riviera-PRO* script rivierapro_setup.tcl to<br>set up and run a simulation.<br>Note: Riviera simulator is not supported for 10/100/1000<br>Ethernet MAC with 1000BASE-X/SGMII 2XTBI PCS<br>variant. |
| sim/xcelium/ | Contains a shell script xcelium_setup.tcl and other<br>setup files to set up and run a simulation. |


## 9. Testbench


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
186

<!-- PDF page 187 -->

Related Information
• Intel Quartus Prime Pro Edition User Guide: Third-party Simulation
• Intel Quartus Prime Standard Edition User Guide: Third-party Simulation

## 9. Testbench


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
187

<!-- PDF page 188 -->


## 10. Software Programming Interface


### 10.1. Driver Architecture

Figure 86. Triple-Speed Ethernet Software Driver Architecture
TX SGDMA
RX SGDMA
Memory
Client Apps Interniche Stack TSE Driver
Control Interface
TX FIFO (2)
RX FIFO (2)
TX Descriptor
RX Descriptor
TSE MAC
Descriptor Memory (1)
Nios II CPU
TX Path
RX Path
Avalon-MM Interface
SetupDescriptors
MII/GMII
MII/GMII
Process &Write Back StatusProcess &Write Back Status
Notes to Figure 86 on page 188:

## 1. The first n bytes are reserved for SGDMA descriptors, where n = (Total number of

descriptors + 3) × 32. Applications must not use this memory region.

## 2. For MAC variations without internal FIFO buffers, the transmit and receive FIFOs

are external to the MAC function.

### 10.2. Directory Structure

Structure of the altera_triple_speed_ethernet directory.

# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 189 -->

Figure 87. Directory Structure
HAL
altera_triple_speed_ethernet
inctriple_speed_ethernet.h
altera_avalon_tse.h
altera_avalon_tse_system_info.h
inctriple_speed_ethernet_regs.h
srcaltera_avalon_tse.c
altera_avalon_tse_system_info.c
inicheins_tse_mac.h
triple_speed_ethernet_iniche.h
iniche
UCOSII
inc
src
ins_tse_mac.c

### 10.3. PHY Definition

By default, the software driver only supports the following PHYs:
• National DP83848C (10/100 Mbps)
• National DP83865 (10/100/1000 Mbps)
• Marvell 88E1111 (10/100/1000 Mbps)
• Marvell 88E1145 (Quad PHY, 10/100/1000 Mbps).
You can extend the software driver to support other PHYs by defining the PHY profile
using the structure alt_tse_phy_profile and adding it to the system using the
function alt_tse_phy_add_profile(). For each PHY instance, use the structure
alt_tse_system_phy_struct to define it and the function
alt_tse_system_add_sys() to add the instance to the system.
The software driver automatically detects the PHY’s operating mode and speed if the
PHY conforms to the following specifications:
• One bit to specify duplex and two consecutive bits (the higher bit being the most
significant bit) to specify the speed in the same extended PHY specific register.
• The speed bits are set according to the convention shown in Table 124 on page
190.

## 10. Software Programming Interface


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
189

<!-- PDF page 190 -->

**Table 124. PHY Speed Bit Values**

| Speed (Mbps) | PHY Speed Bits | Column 3 |
| --- | --- | --- |
|  | MSB | LSB |
| 1000 | 1 | 0 |
| 100 | 0 | 1 |
| 10 | 0 | 0 |







For PHYs that do not conform to the aforementioned specifications, you can write a
function to retrieve the PHY’s operating mode and speed, and set the field
*link_status_read in the PHY data structure to your function’s address.
You can also execute a function to initialize a PHY profile or a PHY instance by setting
the function pointer (*phy_cfg and *tse_phy_cfg) in the respective structures to
the function’s address.
Example of PHY Profile Structure
typedef struct alt_tse_phy_profile_struct{ /* PHY profile */
/*The name of the PHY*/
char name[80];
/*Organizationally Unique Identififier*/
alt_u32 oui;
/*PHY model number*/
alt_u8 model_number;
/*PHY revision number*/
alt_u8 revision_number;
/*The location of the PHY Specific Status Register*/
alt_u8 status_reg_location;
/*The location of the Speed Status bit in the PHY Specific Status
Register*/
alt_u8 speed_lsb_location;
/*The location of the Duplex Status bit in the PHY Status Specific
Register*/
alt_u8 duplex_bit_location;
/*The location of the Link Status bit in PHY Status Specific
Register*/
alt_u8 link_bit_location;
/*PHY initialization function pointer—profile specific*/
alt_32 (*phy_cfg)(np_tse_mac *pmac);
/*Pointer to the function that reads and returns 32-bit link status.Possible
status:
full duplex (bit 0 = 1), half duplex (bit 0 = 0),gigabit (bit 1 = 1),
100Mbps (bit 2 = 1), 10Mbps (bit 3 = 1),invalid speed (bit 16 = 1).*/
alt_u32 (*link_status_read)(np_tse_mac *pmac);
} alt_tse_phy_profile;

## 10. Software Programming Interface


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
190

<!-- PDF page 191 -->

Example of PHY Instance Structure
typedef struct alt_tse_system_phy_struct { /* PHY instance */
/* PHY's MDIO address */
alt_32tse_phy_mdio_address;
/* PHY initialization function pointer—instance specific */
alt_32 (*tse_phy_cfg)(np_tse_mac *pmac);
} alt_tse_system_phy;

### 10.4. Using Multiple SG-DMA Descriptors

To successfully use multiple SG-DMA descriptors in your application, make the
following modifications:
• Set the value of the constant ALTERA_TSE_SGDMA_RX_DESC_CHAIN_SIZE in
altera_avalon_tse.h to the number of descriptors optimal for your
application. The default value is 1 and the maximum value is determined by the
constant NUMBIGBUFFS. For TCP applications, Intel recommends that you use the
default value.
• Increase the amount of memory allocated for the Interniche stack.
The memory space for the Interniche stack is allocated using the Interniche
function pk_alloc(). Although user applications and other network interfaces such
as LAN91C111 can share the memory space, Intel recommends that you use this
memory space for only one purpose, that is storing unprocessed packets for the
Triple-Speed Ethernet Intel FPGA IP. Each SG-DMA descriptor used by the device
driver consumes a buffer size of 1536 bytes (defined by the constant
BIGBUFSIZE) in the memory space. To achieve reasonable performance and to
avoid memory exhaustion, add a new constant named NUMBIGBUFS to your
application and set its value using the following guideline:
NUMBIGBUFS = <current value> + <number of SG-DMA descriptors>
By default, the constant NUMBIGBUFS is set to 30 in ipport.h. If you changed
the default value in the previous release of the IP to optimize performance and
resource usage, use the modified value to compute the new value of
NUMBIGBUFS.

### 10.5. Using Jumbo Frames

To use jumbo frames, set the frm_length register to 9600 and edit the files and
definitions.
**Table 125. Jumbo Frames Definitions**

| File | Definition |
| --- | --- |
| ip\altera\ethernet<br>\altera_eth_tse\src<br>\software\lib\UCOSII | #define ALTERA_TSE_PKT_INIT_LEN 8206<br>#define ALTERA_TSE_MAX_MTU_SIZE 8192<br>#define ALTERA_TSE_MIN_MTU_SIZE 14 |
| \inc\iniche<br>\altera_eth_tse_iniche<br>.h |  |
| ip\altera\ethernet<br>\altera_eth_tse\src<br>\software\lib\HAL\inc<br>\altera_avalon_tse.h | #define ALTERA_TSE_MAC_MAX_FRAME_LENGTH 8196 (25) |
| <BSP project directory><br>\iniche\src\h<br>\nios2\ipport.h | #ifndef BIGBUFSIZE<br>#define BIGBUFSIZE 1536<br>#endif |
|  | Details |
| Description: | The alt_tse_mac_set_common_speed() sets the speed of a<br>multiport MAC and the PHYs connected to it. |
| Parameter: | pmac—A pointer to the base of the MAC control interface.<br>common_speed—The speed to set. |
| Return: | TSE_PHY_SPEED_1000 if the PHYs common speed is 1000 Mbps.<br>TSE_PHY_SPEED_100 if the PHYs common speed is 100 Mbps.<br>TSE_PHY_SPEED_10 if the PHYs common speed is 10 Mbps.<br>TSE_PHY_SPEED_NO_COMMON if there isn’t a common speed among the<br>PHYs. The current speed of the MAC and PHYs is not changed. |
| See also: | alt_32 alt_tse_mac_get_common_speed() |
|  | Details |
|  | psys_sgdma—A pointer to the scatter-gather DMA structure.<br>psys_mem—A pointer to the memory structure.<br>psys_shared_fifo—A pointer to the FIFO structure.<br>psys_phy—A pointer to the PHY structure. |
| Return: | SUCCESS if the operation is successful.SUCCESS if the operation is<br>successful.<br>ALTERA_TSE_MALLOC_FAILED if the operation fails.<br>ALTERA_TSE_SYSTEM_DEF_ERROR if one or more of the definitions are<br>incorrect, or empty. |
|  | Details |
|  | • Configure the admin and operation status of the NET structure of the<br>Triple-Speed Ethernet driver instance to<br>ALTERA_TSE_ADMIN_STATUS_DOWN.<br>• De-register the SGDMA RX interrupt from the operating system.<br>• Clear the RX_ENA bit in the command_config register to disable the<br>RX datapath. |
| Parameter: | iface—The index of the MAC interface. This argument is reserved for<br>configurations that contain multiple MAC instances. |
| Return: | SUCCESS if the close operations are successful.<br>An error code if de-registration of SGDMA RX from the operating system<br>failed. |
| See also: | triple_speed_ethernet_init() |
|  | Details |
| Description: | The tse_mac_setGMIImode() function sets the MAC function<br>operation mode to Gigabit (GMII). The settings of the command_config<br>register are restored at the end of the function. |
| Parameter: | pmac—A pointer to the MAC control interface base address. |
| Return: | SUCCESS |
| See also: | tse_mac_setMIImode() |


## 10. Software Programming Interface


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
191

<!-- PDF page 192 -->


### 10.6. API Functions

This section describes each provided API function in alphabetical order.

#### 10.6.1. alt_tse_mac_get_common_speed()

Details
Prototype: alt_tse_mac_get_common_speed(np_tse_mac *pmac)
Thread-safe: No
Available from ISR: No
Include: <altera_avalon_tse.h>
Description: The alt_tse_mac_get_common_speed()obtains the common speed
supported by the PHYs connected to a multiport MAC and remote link
partners.
Parameter: pmac—A pointer to the base of the MAC control interface.
Return: TSE_PHY_SPEED_1000 if the PHYs common speed is 1000 Mbps.
TSE_PHY_SPEED_100 if the PHYs common speed is 100 Mbps.
TSE_PHY_SPEED_10 if the PHYs common speed is 10 Mbps.
TSE_PHY_SPEED_NO_COMMON if there isn’t a common speed among the
PHYs.
See also: alt_32 alt_tse_mac_set_common_speed()

#### 10.6.2. alt_tse_mac_set_common_speed()

Details
Prototype: alt_tse_mac_set_common_speed(np_tse_mac *pmac, alt_32
common_speed)
Thread-safe: No
Available from ISR: No
Include: <altera_avalon_tse.h>
(25) The maximum value for ALTERA_TSE_MAC_MAX_FRAME_LENGTH is defined by the
frm_length register.

## 10. Software Programming Interface


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
192

<!-- PDF page 193 -->


#### 10.6.3. alt_tse_phy_add_profile()

Prototype: alt_tse_phy_add_profile(alt_tse_phy_profile *phy)
Thread-safe: No
Available from ISR: No
Include: <altera_avalon_tse.h>
Description: The alt_tse_phy_add_profile() function adds a new PHY to the
PHY profile. Use this function if you want to use PHYs other than Marvell
88E1111, Marvell Quad PHY 88E1145, National DP83865, and National
DP83848C.
Parameter: phy—A pointer to the PHY structure.
Return: ALTERA_TSE_MALLOC_FAILED if the operation is not successful.
Otherwise, the index of the newly added PHY is returned.

#### 10.6.4. alt_tse_system_add_sys()

Prototype: alt_tse_system_add_sys(alt_tse_system_mac *psys_mac,
alt_tse_system_sgdma *psys_sgdma,
alt_tse_system_desc_mem *psys_mem,
alt_tse_system_shared_fifo *psys_shared_fifo,
alt_tse_system_phy *psys_phy)
Thread-safe: No
Available from ISR: No
Include: <system.h><system.h><altera_avalon_tse_system_info.h>
<altera_avalon_tse.h><altera_avalon_tse_system_info.h>
<altera_avalon_tse_system_info.h><altera_avalon_tse_sy
stem_info.h>
Description: The alt_tse_system_add_sys() function defines the TSE system’s
components: MAC, scatter-gather DMA, memory, FIFO and PHY. This
needs to be done for each port in the system.
Parameter: psys_mac—A pointer to the MAC structure.

## 10. Software Programming Interface


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
193

<!-- PDF page 194 -->


#### 10.6.5. triple_speed_ethernet_init()

Prototype: error_t triple_speed_ethernet_init(alt_niche_dev
*p_dev)
Thread-safe: No
Available from ISR: No
Include: <triple_speed_ethernet_iniche.h>
Description: The triple_speed ethernet_init() function opens and initializes
the Triple-Speed Ethernet driver. Initialization involves the following
operations:
• Set up the NET structure of the MAC device instance.
• Configure the MAC PHY Address.
• Register and open the SGDMA RX and TX Module of the MAC device
instance.
• Enable the SGDMA RX interrupt and register it to the Operating
• Register the SGDMA RX callback function.
• Obtains the PHY Speed of the MAC.
• Set up the Ethernet MAC Register settings for the Triple-Speed
Ethernet driver operation.
• Set up the initial descriptor chain to start the SGDMA RX operation.
Parameter: p_dev—A pointer to the Triple-Speed Ethernet device instance.
Return: SUCCESS if the Triple-Speed Ethernet driver is successfully initialized.
See also: tse_mac_close()

#### 10.6.6. tse_mac_close()

Prototype: int tse_mac_close(int iface)
Thread-safe: No
Available from ISR: No
Include: <triple_speed_ethernet_iniche.h>
Description: The tse_mac_close() closes the Triple-Speed Ethernet driver by
performing the following operations:

## 10. Software Programming Interface


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
194

<!-- PDF page 195 -->


#### 10.6.7. tse_mac_raw_send()

Prototype: int tse_mac_raw_send(NET net, char *data, unsigned
data_bytes)
Thread-safe: No
Available from ISR: No
Include: <triple_speed_ethernet_iniche.h>
Description: The tse_mac_raw_send() function sends Ethernet frames data to the
MAC function. It validates the arguments to ensure the data length is
greater than the ethernet header size specified by
ALTERA_TSE_MIN_MTU_SIZE. The function also ensures the SGDMA TX
engine is not busy prior to constructing the descriptor for the current
transmit operation.
Upon successful validations, this function calls the internal API,
tse_mac_sTxWrite, to initiate the synchronous SGDMA transmit
operation on the current data buffer.
Parameter: net—The NET structure of the Triple-Speed Ethernet MAC instance.
data—A data pointer to the base of the Ethernet frame data, including
the header, to be transmitted to the MAC. The data pointer is assumed
to be word-aligned.
data_bytes—The total number of bytes in the Ethernet frame including
the additional padding bytes as specified by ETHHDR_BIAS.
Return: SUCCESS if the current data buffer is successfully transmitted.
SEND_DROPPED if the number of data bytes is less than the Ethernet
header size.
ENP_RESOURCE if the SGDMA TX engine is busy.

#### 10.6.8. tse_mac_setGMII mode()

Prototype: int tse_mac_setGMIImode(np_tse_mac *pmac)
Thread-safe: No
Available from ISR: No
Include: <triple_speed_ethernet_iniche.h>

## 10. Software Programming Interface


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
195

<!-- PDF page 196 -->


#### 10.6.9. tse_mac_setMIImode()

Prototype: int tse_mac_setMIImode(np_tse_mac *pmac)
Thread-safe: No
Available from ISR: No
Include: <triple_speed_ethernet_iniche.h>
mode to MII (10/100). The settings of the command_config register

#### 10.6.10. tse_mac_SwReset()

Prototype: int tse_mac_SwReset(np_tse_mac *pmac)
Thread-safe: No
Available from ISR: No
Include: <triple_speed_ethernet_iniche.h>
Description: The tse_mac_SwReset() performs a software reset on the MAC
function. A software reset occurs with some latency as specified by
ALTERA_TSE_SW_RESET_TIME_OUT_CNT. The settings of the

### 10.7. Constants

The following lists all constants defined for the MAC registers manipulation and
provides links to detailed descriptions of the registers. It also list the constants that
define the MAC operating mode and timeout values.

## 10. Software Programming Interface


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
196

<!-- PDF page 197 -->

**Table 126. Constants Mapping**

| Constant | Value | Description |
| --- | --- | --- |
| ALTERA_TSE_DUPLEX_<br>MODE_DEFAULT | 1 | 0: Half-duplex<br>1:Full-duplex |
| ALTERA_TSE_MAC_SPE<br>ED_DEFAULT | 0 | 0: 10 Mbps<br>1: 100 Mbps<br>2: 1000 Mbps |
| ALTERA_TSE_SGDMA_R<br>X_DESC_CHAIN_SIZE | 1 | The number of SG-DMA descriptors required for the current operating mode. |
| ALTERA_CHECKLINK_T<br>IMEOUT_THRESHOLD | 1000000 | The timeout value when the MAC tries to establish a link with a PHY. |
| ALTERA_AUTONEG_TIM<br>EOUT_THRESHOLD | 250000 | The auto-negotiation timeout value. |
| Command_Config Register (Command_Config Register (Dword Offset 0x02) on page 88) |  |  |
| ALTERA_TSEMAC_CMD_<br>TX_ENA_OFST | 0 | Configures the TX_ENA bit. |
| ALTERA_TSEMAC_CMD_<br>TX_ENA_MSK | 0x1 |  |
| ALTERA_TSEMAC_CMD_<br>RX_ENA_OFST | 1 | Configures the RX_ENA bit. |
| ALTERA_TSEMAC_CMD_<br>RX_ENA_MSK | 0x2 |  |
| ALTERA_TSEMAC_CMD_<br>XON_GEN_OFST | 2 | Configures the XON_GEN bit. |
| ALTERA_TSEMAC_CMD_<br>XON_GEN_MSK | 0x4 |  |
| ALTERA_TSEMAC_CMD_<br>ETH_SPEED_OFST | 3 | Configures the ETH_SPEED bit. |
| ALTERA_TSEMAC_CMD_<br>ETH_SPEED_MSK | 0x8 |  |
| ALTERA_TSEMAC_CMD_<br>PROMIS_EN_OFST | 4 | Configures the PROMIS_EN bit. |
| ALTERA_TSEMAC_CMD_<br>PROMIS_EN_MSK | 0x10 |  |
| ALTERA_TSEMAC_CMD_<br>PAD_EN_OFST | 5 | Configures the PAD_EN bit. |
| ALTERA_TSEMAC_CMD_<br>PAD_EN_MSK | 0x20 |  |
| ALTERA_TSEMAC_CMD_<br>CRC_FWD_OFST | 6 | Configures the CRC_FWD bit. |
| ALTERA_TSEMAC_CMD_<br>CRC_FWD_MSK | 0x40 |  |
| ALTERA_TSEMAC_CMD_<br>PAUSE_FWD_OFST | 7 | Configures the PAUSE_FWD bit. |
| ALTERA_TSEMAC_CMD_<br>PAUSE_FWD_MSK | 0x80 |  |
| ALTERA_TSEMAC_CMD_<br>PAUSE_IGNORE_OFST | 8 | Configures the PAUSE_IGNORE bit. |
| ALTERA_TSEMAC_CMD_<br>PAUSE_IGNORE_MSK | 0x100 |  |
| ALTERA_TSEMAC_CMD_<br>TX_ADDR_INS_OFST | 9 | Configures the TX_ADDR_INS bit. |
| ALTERA_TSEMAC_CMD_<br>TX_ADDR_INS_MSK | 0x200 |  |
| ALTERA_TSEMAC_CMD_<br>HD_ENA_OFST | 10 | Configures the HD_ENA bit. |
| ALTERA_TSEMAC_CMD_<br>HD_ENA_MSK | 0x400 |  |
| ALTERA_TSEMAC_CMD_<br>EXCESS_COL_OFST | 11 | Configures the EXCESS_COL bit. |
| ALTERA_TSEMAC_CMD_<br>EXCESS_COL_MSK | 0x800 |  |
| ALTERA_TSEMAC_CMD_<br>LATE_COL_OFST | 12 | Configures the LATE_COL bit. |
| ALTERA_TSEMAC_CMD_<br>LATE_COL_MSK | 0x1000 |  |
| ALTERA_TSEMAC_CMD_<br>SW_RESET_OFST | 13 | Configures the SW_RESET bit. |
| ALTERA_TSEMAC_CMD_<br>SW_RESET_MSK | 0x2000 |  |
| ALTERA_TSEMAC_CMD_<br>MHASH_SEL_OFST | 14 | Configures the MHASH_SEL bit. |
| ALTERA_TSEMAC_CMD_<br>MHASH_SEL_MSK | 0x4000 |  |
| ALTERA_TSEMAC_CMD_<br>LOOPBACK_OFST | 15 | Configures the LOOP_ENA bit. |
| ALTERA_TSEMAC_CMD_<br>LOOPBACK_MSK | 0x8000 |  |
| ALTERA_TSEMAC_CMD_<br>TX_ADDR_SEL_OFST | 16 | Configures the TX_ADDR_SEL bits (bits 16 - 18). |
| ALTERA_TSEMAC_CMD_<br>TX_ADDR_SEL_MSK | 0x70000 |  |
| ALTERA_TSEMAC_CMD_<br>MAGIC_ENA_OFST | 19 | Configures the MAGIC_ENA bit. |
| ALTERA_TSEMAC_CMD_<br>MAGIC_ENA_MSK | 0x80000 |  |
| ALTERA_TSEMAC_CMD_<br>SLEEP_OFST | 20 | Configures the SLEEP bit. |
| ALTERA_TSEMAC_CMD_<br>SLEEP_MSK | 0x100000 |  |
| ALTERA_TSEMAC_CMD_<br>WAKEUP_OFST | 21 | Configures the WAKEUP bit. |
| ALTERA_TSEMAC_CMD_<br>WAKEUP_MSK | 0x200000 |  |
| ALTERA_TSEMAC_CMD_<br>XOFF_GEN_OFST | 22 | Configures the XOFF_GEN bit. |
| ALTERA_TSEMAC_CMD_<br>XOFF_GEN_MSK | 0x400000 |  |
| ALTERA_TSEMAC_CMD_<br>CNTL_FRM_ENA_OFST | 23 | Configures the CNTL_FRM_ENA bit. |
| ALTERA_TSEMAC_CMD_<br>CNTL_FRM_ENA_MSK | 0x800000 |  |
| ALTERA_TSEMAC_CMD_<br>NO_LENGTH_CHECK_OF<br>ST | 24 | Configures the NO_LENGTH_CHECK bit. |
| ALTERA_TSEMAC_CMD_<br>NO_LENGTH_CHECK_MS<br>K | 0x1000000 |  |
| ALTERA_TSEMAC_CMD_<br>ENA_10_OFST | 25 | Configures the ENA_10 bit. |
| ALTERA_TSEMAC_CMD_<br>ENA_10_MSK | 0x2000000 |  |
| ALTERA_TSEMAC_CMD_<br>RX_ERR_DISC_OFST | 26 | Configures the RX_ERR_DISC bit. |
| ALTERA_TSEMAC_CMD_<br>RX_ERR_DISC_MSK | 0x4000000 |  |
| ALTERA_TSEMAC_CMD_<br>CNT_RESET_OFST | 31 | Configures the CNT_RESET bit. |
| ALTERA_TSEMAC_CMD_<br>CNT_RESET_MSK | 0x80000000 |  |
| Tx_Cmd_Stat Register (Transmit and Receive Command Registers (Dword Offset 0x3A – 0x3B) on page 94) |  |  |
| ALTERA_TSEMAC_TX_C<br>MD_STAT_OMITCRC_OF<br>ST | 17 | Configures the OMIT_CRC bit. |
| ALTERA_TSEMAC_TX_C<br>MD_STAT_OMITCRC_MS<br>K | 0x20000 |  |
| ALTERA_TSEMAC_TX_C<br>MD_STAT_TXSHIFT16_<br>OFST | 18 | Configures the TX_SHIFT16 bit. |
| ALTERA_TSEMAC_TX_C<br>MD_STAT_TXSHIFT16_<br>MSK | 0x40000 |  |
| Rx_Cmd_Stat Register (Transmit and Receive Command Registers (Dword Offset 0x3A – 0x3B) on page 94) |  |  |
| ALTERA_TSEMAC_RX_C<br>MD_STAT_RXSHIFT16_<br>OFST | 25 | Configures the RX_SHIFT16 bit |
| ALTERA_TSEMAC_RX_C<br>MD_STAT_RXSHIFT16_<br>MSK | 0x2000000 |  |




























## 10. Software Programming Interface


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
197

<!-- PDF page 198 -->
























## 10. Software Programming Interface


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
198

<!-- PDF page 199 -->




















## 10. Software Programming Interface


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
199

<!-- PDF page 200 -->




## 10. Software Programming Interface


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
200

<!-- PDF page 201 -->


## 11. Triple-Speed Ethernet Intel FPGA IP User Guide

Archives
IP versions are the same as the Intel Quartus Prime Design Suite software versions up
to v19.1. From Intel Quartus Prime Design Suite software version 19.2 or later, IP
cores have a new IP versioning scheme.
If an IP core version is not listed, the user guide for the previous IP core version applies.
Intel Quartus Prime
Version
IP Core Version User Guide

## 21.2 19.4.0 Triple-Speed Ethernet Intel FPGA IP User Guide


## 20.4 19.4.0 Triple-Speed Ethernet Intel FPGA IP User Guide


## 19.4 19.4.0 Triple-Speed Ethernet Intel FPGA IP User Guide


## 19.3 19.3.0 Triple-Speed Ethernet Intel FPGA IP User Guide


## 19.2 19.2.0 Triple-Speed Ethernet Intel FPGA IP User Guide


## 17.1 17.1 Triple-Speed Ethernet Intel FPGA IP User Guide


## 16.0 16.0 Triple-Speed Ethernet MegaCore Function User Guide


## 15.1 15.1 Triple-Speed Ethernet MegaCore Function User Guide


## 15.0 15.0 Triple-Speed Ethernet MegaCore Function User Guide


# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 202 -->


## 12. Document Revision History for the Triple-Speed

Ethernet Intel FPGA IP User Guide
Document Version Intel Quartus
Prime Version
IP Version Changes

### 2021.10.04 21.3 19.5.0 • Added support for Intel Agilex F-tile devices for the

following core variant:
— 10/100/1000 Ethernet MAC with 1000BASE-X/
SGMII 2XTBI PCS and Embedded PMA
• Added new topics:
— 10/100/1000 Ethernet MAC with 1000BASE-X/
SGMII 2XTBI PCS and Embedded PMA Signals
(F-Tile)
— F-tile Transceiver Direct PHY Signals
• Renamed topic title 10/100/1000 Ethernet MAC
Function with Internal FIFO Buffers, and 1000BASE-
X/SGMII 2XTBI PCS Signals With Embedded PMA
Signals to 10/100/1000 Ethernet MAC with
1000BASE-X/SGMII 2XTBI PCS and Embedded PMA
Signals (E-Tile).
• Updated the following topics:
— Clocking Scheme of MAC with 2XTBI PCS and
Embedded PMA
— Interface Signals
• Updated the following tables:
— Resource Utilization for Triple-Speed Ethernet
for Intel Agilex Devices
— PCS Transmit and Receive Latency

### 2021.08.23 21.2 19.4.0 Corrected the insert correction of the P2P transparent

clock for Delay_Req in Table: Timestamp and
Correction Insertion for 1-Step Clock Synchronization.

### 2021.06.29 21.2 19.4.0 Removed support for NCSim in Table: Simulation Model

Files.
continued...

# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 203 -->

Document Version Intel Quartus
Prime Version
IP Version Changes

### 2021.06.23 21.2 19.4.0 • Updated the Features topic.

• Added information on deterministic latency in Table:
Overview of MAC Register Space.
• Added new topics:
— Deterministic Latency
— Deterministic Latency (Dword Offset 0xE1–
0xD3)
— 10/100/1000 Ethernet MAC Without Internal
FIFO Buffers with IEEE 1588v2, 1000BASE-X/
SGMII 2XTBI PCS, SGMII Bridge, and
Deterministic Latency Signals
— Deterministic Latency Clock Signals
— Deterministic Latency Datapath Signals
— Deterministic Latency Control and Status
Interface Signals
— Deterministic Latency Interface Signals
— IEEE 1588v2 PCS TX PTP Alignment Interface
Signals

### 2021.04.20 20.4 19.4.0 • Corrected the minimum supported grade with 1588

feature for Intel Cyclone 10 GX devices from -I3 to
-I5 in Table: Device Family Support for Triple-Speed
Ethernet MAC.
• Corrected the table description for Table: Resource
Utilization for Triple-Speed Ethernet for Intel
Cyclone 10 GX Devices to state that the resource
utilization estimates are obtained by targeting the
Intel Cyclone 10 GX (10CX220YU484I6G) device
with speed grade -6.

### 2021.02.19 20.4 19.4.0 • Updated the description in Receive of the SGMII

Converter topic..
• Updated the description in Ten-bit Interface
section.
• Updated Table: Resource Utilization for Triple-Speed
Ethernet in Intel Stratix 10 Devices to include
resource utilization for Triple-Speed Ethernet with
E-tile transceiver in Intel Stratix 10 devices.
• Removed Table: Resource Utilization for Triple-
Speed Ethernet with E-Tile Transceiver in Intel
Stratix 10 Devices.
• Updated for latest Intel branding standards.

### 2020.12.14 20.4 19.4.0 • Added support for two new core variants for Intel

Stratix 10 E-tile devices:
— 10/100/1000-Mbps Ethernet MAC without
internal FIFO buffers with 1000BASE-X/SGMII
2XTBI PCS
— 10/100/1000-Mbps Ethernet MAC without
internal FIFO buffers with IEEE 1588v2 and
1000BASE-X/SGMII 2XTBI PCS
• Added new Figure: 10/100/1000-Mbps Ethernet
MAC Without Internal FIFO Buffers with 1000BASE-
X/SGMII 2XTBI PCS.
• Added a footnote to the settings of 1000-Mbps
Small MAC IP variation in Table: Resource
Utilization for Triple-Speed Ethernet for Cyclone V
Devices to state that the variant targets devices
with –6 speed grade.
continued...

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
203

<!-- PDF page 204 -->

Document Version Intel Quartus
Prime Version
IP Version Changes
• Added a note to the description of the Interface
parameter on the recommended speed grades for
Cyclone V devices in Table: Core Configuration
Parameters.
• Updated Table: Resource Utilization for Triple-Speed
Ethernet for Cyclone V Devices.
• Added information on Intel Stratix 10 GXB PMA
Adaptation parameter to Table: PCS/Transceiver
Options Parameters.
• Updated the description in IEEE 1588v2 Supported
Configurations.
• Updated the description for the following signals in
Table: IEEE 1588v2 TX Timestamp Interface
Signals:
— tx_egress_timestamp_96b_data_n
— tx_egress_timestamp_96b_valid
— tx_egress_timestamp_64b_data
— tx_egress_timestamp_64b_valid
• Updated the descriptions for the following signals in
Table: IEEE 1588v2 TX Insert Control Timestamp
Interface Signals:
— tx_etstamp_ins_ctrl_residence_time_u
pdate
— tx_etstamp_ins_ctrl_checksum_zero
— tx_etstamp_ins_ctrl_checksum_correct
• Updated Sharing PLLs in Devices with LVDS Soft-
CDR I/O to include LVDS soft-CDR placement
guidelines for Intel Agilex devices.
• Updated topic title 10/100/1000 Ethernet MAC with
1000BASE-X/SGMII 2XTBI PCS Signals to
10/100/1000 Ethernet MAC with 1000BASE-X/
SGMII 2XTBI PCS and Embedded PMA Signals.
• Made editorial updates throughout the document.

### 2020.10.05 19.4 19.4.0 • Updated the following topic, figures, and table

include the LVDS change:
— Sharing PLLs in Devices with LVDS Soft-CDR I/O
— Figure: Clock Distribution in MAC and SGMII
PCS with LVDS Configuration—Optimal Case
— Figure: Clock Distribution in MAC and
1000BASE-X PCS with LVDS Configuration—
Optimal Case
— Table: Core Configuration Parameters
• Added a note to Simulation Model Files.
• Updated Length Checking with information about
jumbo frame.
• Updated Table: Core Configuration Parameters to
include the information of the FPGA device with E-
tile transceivers for Core Variation and
Transceiver type.
• Updated Table: MAC Control Interface Signals to
include more details about reg_busy.
• Made editorial updates throughout the document.

### 2020.02.27 19.4 19.4.0 • Updated the Payload Pad Removal topic.

continued...

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
204

<!-- PDF page 205 -->

Document Version Intel Quartus
Prime Version
IP Version Changes

### 2019.12.16 19.4 19.4.0 • Added support for Intel Agilex devices.

• Added new section— Clocking Scheme of MAC with
2XTBI PCS and Embedded PMA.
• Added a foot note to the Minimum Speed Grade
with 1588 Feature value of the Intel Stratix 10 (E-
tile) in Table: Device Family Support for Triple-
Speed Ethernet MAC.
• Updated the Features topic.
• Updated the Performance and Resource Utilization
topic:
— Added new Table: Resource Utilization for Triple-
Speed Ethernet for Intel Agilex Devices.
— Update Table: Resource Utilization for Triple-
Speed Ethernet in Intel Stratix 10 Devices.
— Updated Table: Resource Utilization for Triple-
Speed Ethernet with E-Tile Transceiver in Intel
Stratix 10 Devices.
— Updated Table: Resource Utilization for Triple-
Speed Ethernet for Intel Arria 10 Devices.
— Updated Table: Resource Utilization for Triple-
Speed Ethernet for Intel Cyclone 10 GX Devices.
• Remove the note in the Generating a Design
Example or Simulation Model topic.
• Updated the description of the Transceiver type
parameter in Table: Core Configuration Parameters.
• Updated the parameter name Enable Stratix 10
transceiver dynamic reconfiguration to Enable
E-tile transceiver dynamic reconfiguration in
Table: PCS/Transceiver Options Parameters.
• Added a new Topic— Intel LVDS Transmitter and
Receiver Soft-CDR I/O Signals.
• Updated the description in the Receive FIFO Buffer
and Local Device Congestion topic.
• Updated Table: PCS Transmit and Receive Latency
to include latency information for the following
Intel Stratix 10 E-tile configuration:
— 10-Mbps SGMII 2XTBI PCS
— 100-Mbps SGMII 2XTBI PCS
— 10-Mbps SGMII 2XTBI PCS with GXB
— 100-Mbps SGMII 2XTBI PCS with GXB
• Updated the description in the 1000BASE-X/SGMII
PCS With Optional Embedded PMA topic.
• Updated the FPGA IEEE 1588v2 Feature topic.
• Updated the GMII Clock Signals topic.
continued...

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
205

<!-- PDF page 206 -->

Document Version Intel Quartus
Prime Version
IP Version Changes
• Updated the following figures:
— Updated figure and figure title 10/100/1000-
Mbps Ethernet MAC and 1000BASE-X/SGMII
PCS with Optional PMA to 10/100/1000-Mbps
Ethernet MAC and 1000BASE-X/SGMII PCS with
PMA.
— Updated figure and figure title 1000BASE-X/
SGMII 2XTBI PCS with Optional PMA to
1000BASE-X/SGMII 2XTBI PCS.
— Clock Distribution in MAC and SGMII PCS with
GXB Configuration—Optimal Case
— Clock Distribution in MAC and SGMII PCS with
LVDS Configuration—Optimal Case.
— Power-Down.
— Corrected figure title PTP Frame in IEEE 8002.3
to PTP Frame in IEEE 802.3
— Updated Figure: 10/100/1000 Ethernet MAC
Function with Internal FIFO Buffers Signals.
— Updated Figure: 10/100/1000 Multiport Ethernet
MAC Function without Internal FIFO Buffers
Signals.
— Updated Figure: 10/100/1000 Ethernet MAC
Function with Internal FIFO Buffers, with
1000BASE-X/SGMII PCS Signals.
— Updated Figure: 0/100/1000 Ethernet MAC
Function with Internal FIFO Buffers, and
1000BASE-X/SGMII 2XTBI PCS Signals With
Embedded PMA Signals.
— Updated Figure: 10/100/1000 Multiport Ethernet
MAC Function without Internal FIFO Buffers with
1000BASE-X/SGMII PCS Signals.
— Updated Figure: 10/100/1000 Ethernet MAC
Function with Internal FIFO Buffers, and
1000BASE-X/SGMII PCS With Embedded PMA
Signals.
— Updated Figure: 10/100/1000 Multiport Ethernet
MAC Function without Internal FIFO Buffers,
with IEEE 1588v2, 1000BASE-X/SGMII PCS and
Embedded PMA Signals.
— Updated Figure: 1000BASE-X/SGMII PCS
Function Signals.
— Updated Figure: 1000BASE-X/SGMII 2XTBI PCS
Function Signals.
— Updated Figure: 1000BASE-X/SGMII PCS
Function and PMA Signals.
— Updated Figure: Reset Distribution in MAC with
PCS and Embedded PMA.
• Updated the Table: GMII/RGMII/MII Clock Signals
in the 10/100/1000 Ethernet MAC Signals section to
remove tx_clkena and rx_clkena signals.
• Added a new topic for the for the 10/100/1000
Ethernet MAC Signals section—Clock Enabler
Signals.
• Updated Table: Clock Signals Visible at Top-Level
Design:
— Updated the table description.
— Added footnotes for ff_tx_clk and
ff_rx_clk.
continued...

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
206

<!-- PDF page 207 -->

Document Version Intel Quartus
Prime Version
IP Version Changes
• Updated the note in the Creating Clock Constraints
topic to state that the derive_pll_clocks
command is not supported in Intel Stratix 10
devices because all PLL clocks are automatically
generated by the SDC files generated alongside the
PLL IP.
• Corrected the term gbx_pwrdn_in to
gxb_pwrdn_in.
• Updated the term "MegaWizard Plug-In Manager" to
"IP Catalog".
• Renamed topic title Intel Stratix 10 E-tile
Transceiver Native PHY Signals to E-tile Transceiver
Native PHY Signals.
• Updated for latest Intel branding standards.

### 2019.11.01 19.3 19.3.0 • Corrected the minimum speed grade with 1588

feature for Intel Stratix 10 E-tile devices from "-I3"
to "Not supported".
• Updated the descriptions in the following topics:
— Features
— Intel FPGA IP IEEE 1588v2 Feature
• Updated Table: IEEE 1588v2 Feature LVDS I/O
Delay—Hardware.

### 2019.09.30 19.3 19.3.0 • Updated Table: Device Family Support for Triple-

Speed Ethernet MAC.
• Updated Table: Simulation Model Files.
• Updated the notes for Figure: Clock Distribution in
MAC and 1000BASE-X PCS with LVDS Configuration
—Optimal Case.

### 2019.07.24 19.2 19.2.0 • Added support for two new core variants for Intel

Stratix 10 E-tile devices:
— 10/100/1000-Mbps Ethernet MAC with
1000BASE-X/SGMII 2XTBI PCS
— 1000BASE-X/SGMII 2XTBI PCS
• Added a new Topic: GMII Converter.
• Added a new Table: Resource Utilization for Triple-
Speed Ethernet with E-tile Transceiver in Intel
Stratix 10 Devices.
• Updated Table: PCS/Transceiver Options
Parameters:
— Added Intel Stratix 10 GXB Transceiver
Options parameter to the table.
— Added a second note to clarify that the
Transceiver Options and Series V GXB
Transceiver Options parameters are not
available in the Triple-Speed Ethernet Intel FPGA
IP parameter editor interface of the Intel
Quartus Prime Pro Edition software version 19.2
onwards. These options are only present in the
Intel Quartus Prime Standard Edition software.
• Updated Table: PCS Transmit and Receive Latency
to include latency information for Intel Stratix 10
E-tile configuration.
• Added a note to the MAC Configuration Register
Space topic.
• Updated Table: PCS Control Register Bit
Descriptions to update the descriptions for
COLLISION_TEST and DUPLEX_MODE.
continued...

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
207

<!-- PDF page 208 -->

Document Version Intel Quartus
Prime Version
IP Version Changes
• Updated c0 clock frequency from 110 MHz to 100
MHz and added a note of recommended clock
frequencies for different FIFO widths for
ff_tx_clk and ff_rx_clk signals in Figure:
Triple-Speed Ethernet Timing Constraint Example.
• Updated recommended clock frequencies for
ff_tx_clk and ff_rx_clk signals in Table:
Recommended Clock Input Frequency For Each IP
Core Variant.
• Updated Table: Statistics Counters to change the
ifOutDiscards register to Reserved.
• Restructured the document.

### 2019.03.29 17.1 17.1 Updated the note in the MAC Error Correction Code

(ECC) topic to state that the error correction code
(ECC) feature is applicable to Arria V GZ, Stratix V, and
Intel Arria 10 devices.

### 2019.02.21 17.1 17.1 Updated the project directory path for VHDL design in

the Simulate the IP Core topic.

### 2019.01.28 17.1 17.1 Added notes to the Multicast Address Resolution topic.


### 2018.11.28 17.1 17.1 Updated Table: Clock Signals Visible at Top-Level

Design to add notes for ref_clk under MAC Only and
MAC+PCS configurations.

### 2018.08.01 17.1 17.1 • Renamed the document as Triple-Speed Ethernet

Intel FPGA IP Core User Guide.
• Updated the description of the MAC Transmit
Datapath topic.
• Updated the "Command_Config Register Field
Descriptions" and "PCS Configuration Registers"
tables: Added HW reset values to all registers.
• Updated Table: Transmit and Receive Nominal
Latency.
• Updated Table: Statistics Counters to update the
descriptions for aOctetsReceivedOK,
ifOutErrors, ifOutUcastPkts,
ifOutMulticastPkts, and
ifOutBroadcastPkts registers.
• Updated for latest Intel branding standards.
Date Version Changes
November 2017 2017.11.06 • Rebranded as Intel.
• Renamed the document as Intel FPGA Triple-Speed Ethernet IP Core User
Guide.
• Added support for the Intel Stratix 10, Intel Cyclone 10 GX, and and Intel
Cyclone 10 LP device families.
• Updated the description of the About This IP Core topic.
• Added "Intel FPGA IP Core Device Support Levels" table to the Device Family
Support topic.
• Removed the Definition: Device Support Level topic.
• Updated the "Intel Arria 10 Resource Utilization", "Cyclone V Resource
Utilization" table: Updated the IP core name from 1000BASE-X/SGMII PCS
with PMA to 1000BASE-X/SGMII PCS.
continued...

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
208

<!-- PDF page 209 -->

Date Version Changes
• Updated the Generating a Design Example or Simulation Model topic:
— Added a note to clarify that the Generate Example Design option only
generates the design for functional simulation.
— Added a note to clarify that the dynamically generated design example for
functional simulation is available only in Intel Arria 10, Intel Cyclone GX,
and Intel Stratix 10 devices.
• Updated the "Recommended Quartus Pin Assignments" table: Updated the
Design Pin information for GLOBAL_SIGNAL pin assignment.
• Updated the "Core Configuration Parameters" table:
— Added a note to the description of Interface parameter to clarify that
RGMII interface is not supported in Intel Arria 10, Intel Cyclone 10 GX,
and Intel Stratix 10 devices from Intel Quartus Prime software version

## 17.1 onwards.

— Added a note to the description of Number of ports to clarify that the
number of ports supported for Triple-Speed Ethernet designs targeting
Intel Stratix 10, Intel Arria 10, and Intel Cyclone 10 GX devices is 8 in
Intel Quartus Prime software version 17.1 onwards.
— Added a note to the description of Transceiver type parameter to clarify
on the performance risk when using Triple-Speed Ethernet IP variant with
LVDS I/O for PMA implementation in Intel Arria 10 devices for Intel
Quartus Prime software versions 17.0.2 and earlier.
• Updated Figure: Hardware Multicast Address Resolution Engine
• Updated the "PCS Transmit and Receive Latency" table:
— Added PCS transmit and receive latency for Intel Stratix 10 and Intel
Cyclone 10 GX devices.
— Added a footnote under the Latency (Clock Cycles) column to clarify that
the latency numbers are from simulation.
• Updated the description in the CRC Checking topic.
• Updated the Configuration Register Space section:
— Updated the "IEEE 1588v2 Feature PMA Delay—Hardware" table to include
digital delay information for Intel Arria 10 devices.
— Updated the "IEEE 1588v2 Feature LVDS I/O Delay—Hardware" table to
include digital delay information for Intel Arria 10 and Intel Stratix 10
devices.
• Updated the description of the MAC and PCS With LVDS Soft-CDR I/O topic:
Added a note to clarify on the performance risk when using Triple-Speed
Ethernet IP variant with LVDS I/O for PMA implementation in Intel Arria 10
devices for Intel Quartus Prime software versions 17.0.2 and earlier.
• Added a note to the Sharing PLLs in Devices with LVDS Soft-CDR I/O topic.
• Updated the Creating Clock Constraints topic: Added a note to clarify that the
derive_pll_clocks command is not supported in Intel Stratix 10 devices.
• Made editorial updates throughout the document.
March 2017 2017.03.08 • Updated the note below Figure 6-5 in the 10/100/1000 Ethernet MAC with
1000BASE-X/SGMII PCS and Embedded PMA Signals topic.
• Updated the Arria 10 and Cyclone V Resource Utilization tables to include
information about 10/100/1000-Mbps Ethernet MAC and 1000BASE-X/SGMII
PCS MegaCore Function.
• Updated the link in the Related Information section for the Altera IEEE
1588v2 Features topic.
• Editorial fix to the notes in Figures 6-5, 6-6, 6-7, and 7-2.
January 2017 2017.01.05 • Added ordering code IP-TRIETHERNETF for IEEE 1588v2 and product ID(s)
00BD and 0104 for Triple-Speed Ethernet and IEEE 1588v2.
January 2017 2017.01.05 Corrected typo in the Configuration Register Space topic.
continued...

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
209

<!-- PDF page 210 -->

Date Version Changes
October 2016 2016.10.31 • Corrected the Device Family Support topic to include all supported devices,
including devices that do not have the 1588 feature support.
• Removed mention of read_timeout in the topic about MAC reset.
• Updated the description of DISABLE_READ_TIMEOUT in the topic about the
command_config register.
• Removed read_timeout and disable_read_timeout registers from the
table that lists the PCS configuration registers.
May 2016 2016.05.02 • Updated the Device Family Support topic.
• Updated the Performance and Resource Utilization topic.
• Updated the Release Information topic.
• Removed the Design Example topic and the appendices that described the
design components, Time-of-Day (ToD) Clock, ToD Synchronizer, and Packet
Classifier. Added a link to the application note for the design example.
• Added the Document Archives topic that lists documents for the past
releases.
• Removed the PMA and LVDS I/O Delay—Simulation Model tables from the
IEEE 1588v2 Feature PMA Delay topic because simulation data is not
deterministic.
November 2015 2015.11.02 • ToD Clock chapter:
— Updated the device family support.
— Added a new parameter—PERIOD_CLOCK_FREQUENCY.
— Updated the CSR description for SecondsH, SecondsL, NanoSec,
Period, AdjustPeriod, DriftAdjust, and DriftAdjustRate.
• ToD Synchronizer chapter:
— Updated the device family support.
— Changed the frequency range to 390.625 MHz (from 312.5 MHz)
— Added a new table—"Sampling Clock Frequency According to the Selected
Parameter Settings".
— Updated the "Settings to Achieve the Recommended Factors for Stratix V
PLL" table with more sampling clock factors.
— Updated the parameter value of SYNC_MODE to "Between 0 to 15" (from
"Between 0 to 6").
— Added a new parameter—SAMPLE_SIZE.
• Updated the description for tx_serial_clk to state that the clock
frequency is 1250 MHz.
• Changed instances of Quartus II to Quartus Prime.
June 2015 2015.06.15 • Added a new parameter, , in the Core Configuration Parameters table.
• Added description for new signals—tx_clkena, rx_clkena, and
led_panel_link.
• Added Qsys-equivalent signal names for the following signals:Use clock
enable for MAC
— control_port_clock_connection: clk
— pcs_mac_tx_clock_connection: tx_clk
— pcs_mac_rx_clock_connection: rx_clk
— receive_clock_connection: ff_rx_clk
— transmit_clock_connection: ff_tx_clk
• Revised the Command_config register field descriptions for bits 0, 1, and 13.
• Corrected the Command_config register setting for Enable MAC Transmit and
Receive Datapath register initialization sequence from 0x00802223 to
0x00800223.
• Corrected the bit width for pkt_class_dataUse clock enable signal in the
following timing diagrams:
— Receive Operation—MAC Without Internal FIFO Buffers.
— Invalid Length Error During Receive Operation—MAC Without Internal
FIFO Buffers.
continued...

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
210

<!-- PDF page 211 -->

Date Version Changes
• Updated the following sections to indicate that the reconfiguration signals are
not present in variations targeting Arria 10, Stratix V, Arria V, and Cyclone V
devices with GX transceivers.
— note in Figure 57 on page 140
— SERDES control signals description in Table 95 on page 141.
— note in Figure 58 on page 143
— Sharing Transceiver Quads on page 173
• Updated the description for Extended Statistics Counters (0x3C – 0x3E)
to state the specific order for reading counters.
• Removed "10/100/1000-Mbps MAC with 1000BASE-X/SGMII PCS"
configuration from the list of supported configurations in IEEE 1588v2
feature.
• Added a new topic—Using ToD Clock SecondsH, SecondsL, and
NanoSecRegisters.
June 2014 14.0 • Added a link to the Altera website that provides the latest device support
information for Altera IP.
• Added a note in PCS/Transceiver Options on page 30—You must configure the
Arria 10 Transceiver ATX PLL output clock frequency to 1250.0 MHz when
using the Arria 10 Transceiver Native PHY with the Triple-Speed Ethernet IP
core.
• Added MAC Error Correction Code (ECC) on page 53 section.
• Added new support configuration for IEEE 1588v2 feature.
• Updated the tx_period and rx_period register bits in IEEE 1588v2
Feature (Dword Offset 0xD0 – 0xD6) on page 95.
• Updated the timing adjustment for the IEEE 1588v2 feature PMA delay in
IEEE 1588v2 Feature PMA Delay on page 96.
• Revised the control interface signal names to reg_rd, reg_data_in,
reg_wr, reg_busy, and reg_addr in MAC Control Interface Signals on page
112.
• Added ECC status signals in ECC Status Signals on page 118 and ECC Status
Signals on page 125.
• Added Arria 10 Transceiver Native PHY signals in Intel Arria 10 Transceiver
Native PHY Signals on page 124.
• Added Transceiver Native PHY signal in Transceiver Native PHY Signal on page
141.
• Updated the following the signal diagrams:
— 10/100/1000 Ethernet MAC Signals
— 1000BASE-X/SGMII PCS Function Signals
— 10/100/1000 Ethernet MAC with 1000BASE-X/SGMII PCS Signals
— 10/100/1000 Multiport Ethernet MAC Function without Internal FIFO
Buffers, with IEEE 1588v2, 1000BASE-X/SGMII PCS and Embedded PMA
Signals
• Added IEEE 1588v2 feature PHY path delay interface signals in IEEE 1588v2
PHY Path Delay Interface Signals on page 147.
• Updated the Period and AdjustPeriod register bits in ToD Clock
Configuration Register Space.
• Added two new conditions that the ToD synchronizer module supports in ToD
Synchronizer chapter.
• Added three new recommended sampling clock frequencies in ToD
Synchronizer chapter.
• Added a new setting of 32/63 in ToD Synchronizer Block.
• Updated the SYNC_MODE parameter value and description in ToD
Synchronizer Parameter Settings.
December 2013 13.1 • Added support for Arria 10 device.
• Added device family support list for IEEE 1588v2 variant.
• Updated the PCS/Transceiver options parameters in PCS/Transceiver Options
on page 30.
continued...

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
211

<!-- PDF page 212 -->

Date Version Changes
• Updated the bit order in Table 51 on page 102 , Table 52 on page 102 and
Table 54 on page 103.
• Added information on how to view all the signal names when implementing
the IP in Qsys in Interface Signals.
• Added a section about exposed ports in the new user interface in Design
Considerations.
May 2013 13.0 • Updated the MegaWizard Plug-In Manager flow in Getting Started with Altera
IP Cores.
• Added information about generating a design example and simulation
testbench in Generating a Design Example or Simulation Model on page 22.
• Updated the list of Quartus II generated files.
• Added information about the recommended pin assignments in Design
Constraint File No Longer Generated on page 24.
• Updated the MegaCore parameter names and description in Parameter
Settings.
• Updated the IEEE 1588v2 feature list in Functional Description.
• Updated the SGMII auto-negotiation description in Functional Description.
• Added information about the IEEE 1588v2 feature PMA delay in IEEE 1588v2
Feature PMA Delay on page 96.
• Updated the Multiport Ethernet MAC with IEEE 1588v2, 1000BASE-X/SGMII
PCS and Embedded PMA Signals.
• Updated the IEEE 1588v2 timestamp signal names.
• Added timing diagrams for IEEE 1588v2 timestamp signals.
• Added a section about migrating existing design to the Quartus II software
new MegaCore user interface in Design Considerations.
• Updated Timing Constraints chapter, to describe the new timing constraint
files and the recommended clock input frequency for each MegaCore Function
variant.
• Added information about the simulation model files generated using IEEE
simulation encryption in Simulation Model Files on page 186.
• Updated the jumbo frames file directory in Using Jumbo Frames on page 191.
• Updated the ToD configuration parameters in ToD Clock Parameter Setting
and ToD interface signals, ToD Clock Avalon-ST Transmit Interface Signals
and ToD Clock Avalon-MM Control Interface Signals.
• Added information to describe the ToD’s drift adjustment in the Adjusting ToD
Clock Drift.
• Added ToD Synchronizer and Packet Classifier chapters.
• Removed SOPC Builder information.
January 2013 12.1 • Added Altera IEEE 1588v2 Feature section in Chapter 4.
• Added information for the following GUI parameters: Enable timestamping,
Enable PTP 1-step clock, and Timestamp fingerprint width in “Timestamp
Options”.
• Added MAC registers with IEEE 1588v2 feature.
• Added IEEE 1588v2 feature signals tables.
• Added Triple-Speed Ethernet with IEEE 1588v2 Design Example section.
• Added Time-of-Day Clock section.
June 2012 12.0 • Added support for Cyclone V.
• Updated the Congestion and Flow Control section in Chapter 4.
• Added Register Initialization section in Chapter 5.
• Added holdoff_quant register description.
• Added UNIDIRECTIONAL_ENABLE bit description.
• Revised and moved the section on Timing Constraint to a new chapter.
• Added information about how to customize the SDC file in Chapter 8.
• Added Pause Frame Generation section.
continued...

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide


# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
212

<!-- PDF page 213 -->

Date Version Changes
November 2011 11.1 • Added support for Arria V.
• Revised the Device Family Support section in Chapter 1.
• Added disable_read_timeout and read_timeout registers at address
0x15 and 0x16.
June 2011 11.0 • Updated support for Cyclone IV GX, Cyclone III LS, Aria II GZ,
HardCopy IV GX/E and HardCopy III E devices.
• Revised Performance and Resource Utilization section in Chapter 1.
• Updated Chapter 3 to include Qsys System Integration Tool Design Flow.
• Added Transmit and Receive Latencies section in Chapter 4.
• Updated all MAC register address to dbyte addressing.
December 2010 10.1 • Added support for Arria II GZ.
• Added a new parameter, Starting Channel Number.
• Streamlined the contents and document organization.
August 2010 10.0 • Added support for Stratix V.
• Revised the nomenclature of device support types.
• Added chapter 5, Design Considerations. Moved the Clock Distribution section
to this chapter and renamed it to Optimizing Clock Resources in Multiport
MAC and PCS with Embedded PMA. Added sections on PLL Sharing and
Transceiver Quad Sharing.
• Updated the description of Enable transceiver dynamic reconfiguration.
November 2009 9.1 • Added support for Cyclone IV, Hardcopy III, and Hardcopy IV, and updated
support for Hardcopy II to full.
• Updated chapter 1 to include a feature comparison between 10/100/1000
Ethernet MAC and small MAC.
• Updated chapter 4 to revise the 10/100/1000 Ethernet MAC description,
Length checking, Reset, and Control Interface sections.
March 2009 9.0 • Added support for Arria II GX.
• Updated chapter 3 to include a new parameter that enables wider statistics
counters.
• Updated chapter 4 to reflect support for different speed in multiport MACs
and gated clocks elimination.
• Updated chapter 6 to reflect enhancements made on the device drivers.
November 2008 8.1 • Updated Chapters 3 and 4 to add description on dynamic reconfiguration.
• Updated Chapter 6 to include a procedure to add unsupported PHYs.
May 2008 8.0 • Revised the performance tables and device support.
• Updated Chapters 3 and 4 to include information on MAC with multi ports and
without internal FIFOs.
• Revised the clock distribution section in Chapter 4.
• Reorganized Chapter 5 to remove redundant information and to include the
new testbench architecture.
• Updated Chapter 6 to include new public APIs.
October 2007 7.2 • Updated Chapter 1 to reflect new device support.
• Updated Chapters 3 and 4 to include information on Small MAC.
May 2007 7.1 • Added Chapters 2, 3, 5 and 6.
• Updated contents to reflect changes and enhancements in the current
version.
March 2007 7.0 Updated signal names and description.
December 2006 6.1 • Global terminology changes: 1000BASE-X PCS/SGMII to 1000BASE-X/SGMII
PCS, host side or client side to internal system side, HD to half-duplex.
• Initial release of document on Web.
December 2006 6.1 Initial release of document on DVD.

## 12. Document Revision History for the Triple-Speed Ethernet Intel FPGA IP User Guide


# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
213

<!-- PDF page 214 -->

A. Ethernet Frame Format
A.1. Basic Frame Format
Figure 88. MAC Frame Format

# 7 octets PREAMBLE


# 1 octet SFD


# 6 octets DESTINATION ADDRESS


# 6 octets

SOURCE ADDRESS

# 2 octets

0..1500/9600 octets
PAYLOAD DATA
0..46 octets PAD

# 4 octets FRAME CHECK SEQUENCE

EXTENSION
Frame length
(half duplex only)
LENGTH/TYPE
A basic Ethernet frame comprises the following fields:
• Preamble—a maximum of 7-octet fixed value of 0x55.
• Start frame delimiter (SFD)—a 1-octet fixed value of 0xD5 which marks the
beginning of a frame.
• Destination and source addresses—6 octets each. The least significant byte is
transmitted first.
• Length or type—a 2-octet value equal to or greater than 1536 (0x600) indicates a
type field. Otherwise, this field contains the length of the payload data. The most
significant byte of this field is transmitted first.
• Payload Data and Pad—variable length data and padding.
• Frame check sequence (FCS)—a 4-octet cyclic redundancy check (CRC) value for
detecting frame errors during transmission.
• An extension field—Required only for gigabit Ethernet operating in half-duplex
mode. The MAC function does not support this implementation.
A.2. VLAN and Stacked VLAN Frame Format
The extension of a basic MAC frame is a virtual local area network (VLAN) tagged
frame, which contains an additional 4-byte field for the VLAN tag and information
between the source address and length/type fields. VLAN tagging is defined by the
IEEE Standard 802.1Q. VLAN tagging can identify and separate many groups' network

# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 215 -->

traffic from each other in enterprise and metro networks. Each VLAN group can consist
of many users with varied MAC address in different geographical locations of a
network. VLAN tagging increases and scales the network performance and add privacy
and safety to various groups and customers' network traffic.
VLAN tagged frames have a maximum length of 1522 bytes, excluding the preamble
and the SFD fields.
Figure 89. VLAN Tagged MAC Frame Format

# 7 octets

PREAMBLE

# 1 octet

SFD

# 6 octets

DESTINATION ADDRESS

# 6 octets

SOURCE ADDRESS

# 2 octets

CLIENT LENGTH/TYPE
PAY LOAD DATA
0..42 octets PAD

# 4 octets FRAME CHECK SEQUENCE

EXTENSION (half duplex only)
Frame length

# 2 octets


# 2 octets VLAN info

LENGTH/TYPE (VLAN Tag 0x8100)
0..1500/9600 octets
In metro Ethernet applications, which require more scalability and security due to the
sharing of an Ethernet link by many service providers, MAC frames can be tagged with
two consecutive VLAN tags (stacked VLAN). Stacked VLAN frames contain an
additional 8-byte field between the source address and client length/type fields, as
illustrated.
Figure 90. Stacked VLAN Tagged MAC Frame Format

# 7 octets

PREAMBLE

# 1 octet

SFD

# 6 octets

DESTINATION ADDRESS

# 6 octets

SOURCE ADDRESS

# 2 octets

PAY LOAD DATA
0..38 octets PAD

# 4 octets FRAME CHECK SEQUENCE

Frame length

# 2 octets


# 2 octets VLAN info

Stacked VLANs2 octets

# 2 octets

VLAN info
EXTENSION (half duplex only)
CLIENT LENGTH/TYPE
LENGTH/TYPE (VLAN Tag 0x8100)
LENGTH/TYPE (VLAN Tag 0x8100)
0..1500/9600 octets
A. Ethernet Frame Format

# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
215

<!-- PDF page 216 -->

A.3. Pause Frame Format
A pause frame is generated by the receiving device to indicate congestion to the
emitting device. If flow control is supported, the emitting device should stop sending
data upon receiving pause frames.
The length/type field has a fixed value of 0x8808, followed by a 2-octet opcode field of
0x0001. A 2-octet pause quanta is defined in the second and third bytes of the frame
payload (P1 and P2). The pause quanta, P1, is the most significant byte. A pause
frame has no payload length field, and is always padded with 42 bytes of 0x00.
Figure 91. Pause Frame Format
7octets PREAMBLE

# 1 octet SFD


# 6 octets DESTINATION ADDRESS 6 octets SOURCE ADDRESS


# 2 octets


# 42 octets PAD

CRC

# 2 octets


# 2 octets


# 4 octets

PayloadPAUSE QUANTA (P1, P2)
OPCODE (0X0001)
TYPE (0x8808)
A.3.1. Pause Frame Generation
When you turn on the Enable full-duplex flow control option, pause frame
generation is triggered by the following events:
• RX FIFO fill level hits the rx_section_empty threshold.
• XOFF register write.
• XON register write.
• XOFF I/O pin (xoff_gen) assertion.
• XON I/O pin (xon_gen) assertion.
If the RX FIFO buffer is almost full, the MAC function triggers the pause frame
generation to the remote Ethernet device.
If the local Ethernet device needs to generate pause frame via XOFF or XON register
write or I/O pin assertion, it is recommended to set the rx_section_empty register
to a larger value to avoid non-deterministic result.
The following table summarizes the pause frame generation based on the above
events.
A. Ethernet Frame Format

# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
216

<!-- PDF page 217 -->

**Table 127. Pause Frame Generation**

| Register Write or I/O Pin Assertion (1) | Column 2 | Description |
| --- | --- | --- |
| XOFF_GEN | XON_GEN |  |
| 1 | 0 | If the XOFF_GEN bit is set to 1, the XOFF pause frames are continuously<br>generated and sent to the MII/GMII TX interface until the XOFF_GEN bit is<br>cleared. |
| 0 | 1 | If the XON_GEN bit is set to 1, the XON pause frames are continuously<br>generated and sent to the MII/GMII TX interface until the XON_GEN bit is<br>cleared. |
| 1 | 1 | This event is not recommended as it will produce non-deterministic result. |
| Note to Table 127 on page 217 :<br>1. Set the XON and XOFF registers to 0 when you use the I/O pin to generate the pause frame and vice versa. |  |  |









A. Ethernet Frame Format

# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide

<!-- PDF page 218 -->

B. Simulation Parameters
B.1. Functionality Configuration Parameters
You can use these parameters to enable or disable specific functionality in the MAC
and PCS.
**Table 128. IP Functionality Configuration Parameters**

| Parameter | Description | Default |
| --- | --- | --- |
| Supported in configurations that contain the 10/100/1000 Ethernet MAC |  |  |
| ETH_MODE | 10: Enables MII.<br>100: Enables MII.<br>1000: Enables GMII. | 1000 |
| HD_ENA | Sets the HD_ENA bit in the command_config register. See Command_Config<br>Register (Dword Offset 0x02) on page 88. | 0 |
| TB_MACPAUSEQ | Sets the pause_quant register. See Base Configuration Registers (Dword Offset<br>0x00 – 0x17) on page 85. | 15 |
| TB_MACIGNORE_PAUSE | Sets the PAUSE_IGNORE bit in the command_config register. See<br>Command_Config Register (Dword Offset 0x02) on page 88. | 0 |
| TB_MACFWD_PAUSE | Sets the PAUSE_FWD bit in the command_config register. See Command_Config<br>Register (Dword Offset 0x02) on page 88. | 0 |
| TB_MACFWD_CRC | Sets the CRC_FWD bit in the command_config register. See Command_Config<br>Register (Dword Offset 0x02) on page 88. | 0 |
| TB_MACINSERT_ADDR | Sets the ADDR_INS bit in the command_config register. See Command_Config<br>Register (Dword Offset 0x02) on page 88. | 0 |
| TB_PROMIS_ENA | Sets the PROMIS_EN bit in the command_config register. See Command_Config<br>Register (Dword Offset 0x02) on page 88. | 1 |
| TB_MACPADEN | Sets the PAD_EN bit in the command_config register. See Command_Config<br>Register (Dword Offset 0x02) on page 88. | 1 |
| TB_MACLENMAX | Maximum frame length. | 1518 |
| TB_IPG_LENGTH | Sets the tx_ipg_length register. See Base Configuration Registers (Dword<br>Offset 0x00 – 0x17) on page 85. | 12 |
| TB_MDIO_ADDR0 | Sets the mdio_addr0 register. See Base Configuration Registers (Dword Offset<br>0x00 – 0x17) on page 85. | 0 |
| TB_MDIO_ADDR1 | Sets the mdio_addr1 register. See Base Configuration Registers (Dword Offset<br>0x00 – 0x17) on page 85. | 1 |
| TX_FIFO_AE | Sets the tx_almost_empty register. See Base Configuration Registers (Dword<br>Offset 0x00 – 0x17) on page 85. | 8 |
| TX_FIFO_AF | Sets the tx_almost_full register. See Base Configuration Registers (Dword<br>Offset 0x00 – 0x17) on page 85. | 10 |
| RX_FIFO_AE | Sets the rx_almost_empty register. See Base Configuration Registers (Dword<br>Offset 0x00 – 0x17) on page 85. | 8 |
| RX_FIFO_AF | Sets the rx_almost_full register. See Base Configuration Registers (Dword<br>Offset 0x00 – 0x17) on page 85. | 8 |
| TX_FIFO_SECTION_EMP<br>TY | Sets the tx_section_empty register. See Base Configuration Registers (Dword<br>Offset 0x00 – 0x17) on page 85. | 16 |
| TX_FIFO_SECTION_FUL<br>L | Sets the tx_section_full register. See Base Configuration Registers (Dword<br>Offset 0x00 – 0x17) on page 85. | 16 |
| RX_FIFO_SECTION_EMP<br>TY | Sets the rx_section_empty register. See Base Configuration Registers (Dword<br>Offset 0x00 – 0x17) on page 85. | 0 |
| RX_FIFO_SECTION_FUL<br>L | Sets the rx_section_full register. See Base Configuration Registers (Dword<br>Offset 0x00 – 0x17) on page 85. | 16 |
| MCAST_TABLEN | Specifies the first n addresses from MCAST_ADDRESSLIST from which multicast<br>address is selected. | 9 |
| MCAST_ADDRESSLIST | A list of multicast addresses. | 0x8876543<br>32211<br>0x8866443<br>52611<br>0xABCDEF<br>012313<br>0x9245654<br>5AB15<br>0x4326800<br>10217<br>0xADB589<br>215439<br>0xFFEACFE<br>3434B<br>0xFFCCDD<br>AA3123<br>0xADB358<br>415439 |
| Supported in configurations that contain the 1000BASE-X/SGMII PCS |  |  |
| TB_SGMII_ENA | Sets the SGMII_ENA bit in the if_mode register. See If_Mode Register (Word<br>Offset 0x14) on page 103. | 0 |
| TB_SGMII_AUTO_CONF | Sets the USE_GMII_AN bit in the if_mode register. See If_Mode Register (Word<br>Offset 0x14) on page 103. | 0 |


# 683402 | 2021.10.04

Send Feedback
Intel Corporation. All rights reserved. Intel, the Intel logo, and other Intel marks are trademarks of Intel
Corporation or its subsidiaries. Intel warrants performance of its FPGA and semiconductor products to current
specifications in accordance with Intel's standard warranty, but reserves the right to make changes to any
products and services at any time without notice. Intel assumes no responsibility or liability arising out of the
application or use of any information, product, or service described herein except as expressly agreed to in
writing by Intel. Intel customers are advised to obtain the latest version of device specifications before relying
on any published information and before placing orders for products or services.
*Other names and brands may be claimed as the property of others.
ISO
9001:2015
Registered

<!-- PDF page 219 -->

B.2. Test Configuration Parameters
You can use these parameters to create custom test scenarios.
**Table 129. Test Configuration Parameters**

| Parameter | Description | Default |
| --- | --- | --- |
| Supported in configurations that contain the 10/100/1000 Ethernet MAC |  |  |
| TB_RXFRAMES | Enables local loopback on the Ethernet side (GMII/MII/RGMII). The value must<br>always be set to 0. | 0 |
| TB_TXFRAMES | Specifies the number of frames to be generated by the Avalon streaming<br>Ethernet frame generator. | 5 |
| TB_RXIPG | IPG on the receive path. | 12 |
| TB_ENA_VAR_IPG | 0: A constant IPG, TB_RXIPG, is used by the GMII/RGMII/MII Ethernet frame<br>generator.<br>1: Enables variable IPG on the receive path. | 0 |
| TB_LENSTART | Specifies the payload length of the first frame generated by the frame<br>generators. The payload length of each subsequent frame is incremented by the<br>value of TB_LENSTEP. | 100 |
| TB_LENSTEP | Specifies the payload length increment. | 1 |
| TB_LENMAX | Specifies the maximum payload length generated by the frame generators. If the<br>payload length exceeds this value, it wraps around to TB_LENSTART. This<br>parameter can be used to test frame length error by setting it to a value larger<br>than the value of TB_MACLENMAX. | 1500 |
| TB_ENA_PADDING | 0: Disables padding.<br>1: If the length of frames generated by the GMII/RGMII/MII Ethernet frame<br>generator is less than the minimum frame length (64 bytes), the generator<br>inserts padding bytes to the frames to make up the minimum length. | 1 |
| TB_ENA_VLAN | 0: Only basic frames are generated.<br>1: Enables VLAN frames generation. This value specifies the number of basic<br>frames generated before a VLAN frame is generated followed by a stacked VLAN<br>frame. | 0 |
| TB_STOPREAD | Specifies the number of packets to be read from the receive FIFO before reading<br>is suspended. You can use this parameter to test FIFO overflow and flow control. | 0 |
| TB_HOLDREAD | Specifies the number of clock cycles before the Avalon streaming monitor stops<br>reading from the receive FIFO. | 1000 |
| TB_TX_FF_ERR | 0: Normal behavior.<br>1: Drives the Avalon streaming error signal high to simulate erroneous frames<br>transmission. | 0 |
| TB_TRIGGERXOFF | Specifies the number of clock cycles from the start of simulation before the<br>xoff_gen signal is driven. | 0 |
| TB_TRIGGERXON | Specifies the number of clock cycles from the start of simulation before the<br>xon_gen signal is driven high. | 0 |
| RX_COL_FRM | Specifies which frame is received with collision. Valid in fast Ethernet and half-<br>duplex mode only. | 0 |
| RX_COL_GEN | Specifies which nibble within the frame collision occurs. | 0 |
| TX_COL_FRM | Specifies which frame is transmitted with a collision. Valid in fast Ethernet and<br>half-duplex mode only. | 0 |
| TX_COL_GEN | Specifies which nibble within the frame collision occurs on the transmit path. | 0 |
| TX_COL_NUM | Specifies the number of consecutive collisions during retransmission. | 0 |
| TX_COL_DELAY | Specifies the delay, in nibbles, between collision and retransmission. | 0 |
| TB_PAUSECONTROL | 0: GMII frame generator does not respond to pause frames.<br>1: Enables flow control in the GMII frame generator. | 1 |
| TB_MDIO_SIMULATION | Enable / Disable MDIO simulation. | 0 |
| Supported in configurations that contain the 1000BASE-X/SGMII PCS |  |  |
| TB_SGMII_HD | 0: Disables half-duplex mode. | 0 |
|  | 1: Enables half-duplex mode. |  |
| TB_SGMII_1000 | 0: Disables gigabit operation.<br>1: Enables gigabit operation. | 1 |
| TB_SGMII_100 | 0: Disables 100 Mbps operation.<br>1: Enables 100 Mbps operation. | 0 |
| TB_SGMII_10 | 0: Disables 10 Mbps operation.<br>1: Enables 10 Mbps operation. | 0 |
| TB_TX_ERR | 0: Disables error generation.<br>1: Enables error generation. | 0 |

B. Simulation Parameters

# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
219

<!-- PDF page 220 -->

B. Simulation Parameters

# 683402 | 2021.10.04

Triple-Speed Ethernet Intel® FPGA IP User Guide Send Feedback
220

<!-- PDF page 221 -->

B. Simulation Parameters

# 683402 | 2021.10.04

Send Feedback Triple-Speed Ethernet Intel® FPGA IP User Guide
221

<!-- PDF page 222 -->

Mouser Electronics
Authorized Distributor
Click to View Pricing, Inventory, Delivery & Lifecycle Information:
Altera:
IP-TRIETHERNET
