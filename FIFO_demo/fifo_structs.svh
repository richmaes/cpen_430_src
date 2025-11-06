`ifndef __FIFO_STRUCTS_SVH__
`define __FIFO_STRUCTS_SVH__

// Packed 33-bit structure include
// Fields (total width = 33 bits):
//  - data : 8 bits
//  - addr : 5 bits
//  - info : 20 bits (the "rest")
//
// Note on bit ordering for packed structs: the first declared field is
// the most-significant portion when the struct is viewed as a packed
// vector. So the vector layout (MSB downto LSB) will be:
//    { data[7:0], addr[4:0], info[19:0] }

typedef struct packed {
    logic [31:0]  data;     // bits [34:3]
    logic [1:0]   pri;  // bits [2:1]
    logic         sop;
    logic         eop;
    logic         we;        // bits [0]
} control_t;

// Optional constant for total width
`define CONTROL_W $bits(control_t);

`endif // __FIFO_STRUCTS_SVH__