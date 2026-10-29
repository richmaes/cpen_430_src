`timescale 1ns/1ps

module tcam_tb;
	localparam integer ENTRY_WIDTH = 512;
	localparam integer ENTRY_COUNT = 8;

	logic [ENTRY_WIDTH-1:0] entries [0:ENTRY_COUNT-1];
	string memory_path;
	integer memory_file;
	integer entry_index;
	logic clk = 1'b0;
	logic rst = 1'b1;
	logic valid = 1'b0;
	logic [511:0] data = '0;
	logic [511:0] tcam = '0;
	wire match;
	wire no_match;
	wire [2:0] match_addr;
	localparam integer LOOKUP_CYCLES = 9;
	localparam integer MAX_LOOKUPS = 1000;
	integer cycle_count = 0;
	integer sent_count = 0;
	integer received_count = 0;
	integer multiple_match_count = 0;
	integer due_cycle [0:MAX_LOOKUPS-1];
	integer expected_addr [0:MAX_LOOKUPS-1];
	logic [ENTRY_WIDTH-1:0] miss_key;
	bit miss_found;
	integer candidate;
	integer index;
	integer lookup_index;
	bit candidate_present;

	always #5 clk = ~clk;

	always @(posedge clk) begin
		cycle_count = cycle_count + 1;
		#1;
		if (!rst) begin
			if (received_count < sent_count && cycle_count == due_cycle[received_count]) begin
				if (expected_addr[received_count] == -1) begin
					if (match !== 1'b0 || no_match !== 1'b1)
						$fatal(1, "Lookup %0d: expected no_match", received_count);
				end
				else if (match !== 1'b1 || no_match !== 1'b0 ||
					match_addr !== expected_addr[received_count]) begin
					$fatal(1, "Lookup %0d: expected address %0d, got match=%b no_match=%b address=%0d",
						received_count, expected_addr[received_count], match, no_match, match_addr);
				end
				$display("Lookup %0d: PASS at cycle %0d, expected address=%0d",
					received_count, cycle_count, expected_addr[received_count]);
				received_count = received_count + 1;
			end
			else if (match !== 1'b0 || no_match !== 1'b0)
				$fatal(1, "Unexpected or early result at cycle %0d", cycle_count);
		end
	end

	task automatic send_lookup(
		input logic [ENTRY_WIDTH-1:0] key,
		input logic [ENTRY_WIDTH-1:0] mask,
		input bit require_multiple
	);
		integer address;
		integer hit_count;
		integer lowest_addr;
		begin
			@(negedge clk);
			if (sent_count == MAX_LOOKUPS)
				$fatal(1, "Lookup scoreboard full");
			hit_count = 0;
			lowest_addr = -1;
			for (address = 0; address < ENTRY_COUNT; address = address + 1) begin
				if ((entries[address] & ~mask) == (key & ~mask)) begin
					if (lowest_addr == -1)
						lowest_addr = address;
					hit_count = hit_count + 1;
				end
			end
			if (require_multiple && hit_count < 2)
				$fatal(1, "Multiple-match query must hit at least two entries");
			if (hit_count >= 2)
				multiple_match_count = multiple_match_count + 1;
			due_cycle[sent_count] = cycle_count + 1 + LOOKUP_CYCLES;
			if (sent_count > 0 && due_cycle[sent_count] - due_cycle[sent_count-1] != LOOKUP_CYCLES)
				$fatal(1, "Requests must be spaced exactly nine clocks apart");
			expected_addr[sent_count] = lowest_addr;
			$display("Sending lookup %0d: %0d matching entries, lowest address=%0d",
				sent_count, hit_count, lowest_addr);
			sent_count = sent_count + 1;
			data = key;
			tcam = mask;
			valid = 1'b1;
			@(posedge clk);
			@(negedge clk);
			valid = 1'b0;
			data = ~key;
			tcam = ~mask;
			repeat (LOOKUP_CYCLES - 1) @(posedge clk);
		end
	endtask

	initial begin
		repeat ((MAX_LOOKUPS + 1) * LOOKUP_CYCLES + 20) @(posedge clk);
		$fatal(1, "Lookup test timeout");
	end

	mini_tcam dut (
		.clk(clk),
		.rst(rst),
		.data(data),
		.tcam(tcam),
		.valid(valid),
		.match(match),
		.no_match(no_match),
		.match_addr(match_addr)
	);

	initial begin
		if (!$value$plusargs("MEM_FILE=%s", memory_path))
			$fatal(1, "Supply +MEM_FILE=<path to hex memory file>");

		memory_file = $fopen(memory_path, "r");
		if (memory_file == 0)
			$fatal(1, "Cannot open memory file: %s", memory_path);
		$fclose(memory_file);

		for (entry_index = 0; entry_index < ENTRY_COUNT; entry_index = entry_index + 1)
			entries[entry_index] = 'x;

		$readmemh(memory_path, entries);
		for (entry_index = 0; entry_index < ENTRY_COUNT; entry_index = entry_index + 1) begin
			if ($isunknown(entries[entry_index]))
				$fatal(1, "Entry %0d is missing or contains unknown bits", entry_index);
			dut.mem[entry_index] = entries[entry_index];
		end
		repeat (2) @(posedge clk);
		#1;
		for (entry_index = 0; entry_index < ENTRY_COUNT; entry_index = entry_index + 1) begin
			if (dut.mem[entry_index] !== entries[entry_index])
				$fatal(1, "Memory load mismatch at address %0d", entry_index);
			$display("dut.mem[%0d] = %0128h", entry_index, dut.mem[entry_index]);
		end

		$display("PASS: loaded and verified %0d entries of %0d bits from %s",
			ENTRY_COUNT, ENTRY_WIDTH, memory_path);

		miss_found = 1'b0;
		for (candidate = 0; candidate <= ENTRY_COUNT; candidate = candidate + 1) begin
			candidate_present = 1'b0;
			miss_key = candidate;
			for (index = 0; index < ENTRY_COUNT; index = index + 1)
				if (entries[index] == miss_key)
					candidate_present = 1'b1;
			if (!candidate_present) begin
				miss_found = 1'b1;
				break;
			end
		end
		if (!miss_found)
			$fatal(1, "Could not generate absent key");

		@(negedge clk);
		rst = 1'b0;
		for (lookup_index = 0; lookup_index < MAX_LOOKUPS; lookup_index = lookup_index + 1) begin
			case (lookup_index % 12)
				8: send_lookup(entries[1], entries[1] ^ entries[3], 1'b1);
				9: send_lookup(entries[4], entries[4] ^ entries[6], 1'b1);
				10: send_lookup('0, '1, 1'b1);
				11: send_lookup(miss_key, '0, 1'b0);
				default: send_lookup(entries[lookup_index % 12], '0, 1'b0);
			endcase
		end
		@(posedge clk);
		#2;
		if (received_count != MAX_LOOKUPS || sent_count != MAX_LOOKUPS || multiple_match_count < 2)
			$fatal(1, "Incomplete lookup coverage");
		repeat (2) @(posedge clk);
		#2;
		$display("PASS: %0d lookups at nine-clock intervals, including %0d multiple-match queries",
			received_count, multiple_match_count);
		$finish;
	end
endmodule
