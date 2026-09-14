`ifndef STRUCTURES_VH
`define STRUCTURES_VH

typedef struct packed {
	logic [31:0] data;
	logic        sop;
	logic        eop;
	logic [1:0]  empty;
	logic        valid;
	logic [5:0]  error;
} avalon_st_t;

`endif
