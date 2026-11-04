`timescale 1ns/1ps

module tcam_tb #(
	parameter bit VARY_RESPONSE_LATENCY = 1'b0
);
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
	wire dut_match;
	wire dut_no_match;
	wire [2:0] dut_match_addr;
	localparam integer LOOKUP_CYCLES = 9;
	localparam integer MAX_LOOKUPS = 10;
	localparam integer FIFO_DEPTH = 16;
	integer cycle_count = 0;
	integer sent_count = 0;
	integer received_count = 0;
	integer multiple_match_count = 0;
	integer expected_addr [0:FIFO_DEPTH-1];
	integer read_ptr = 0;
	integer write_ptr = 0;
	integer last_request_cycle = -1;
	bit previous_result = 1'b0;
	logic [ENTRY_WIDTH-1:0] miss_key;
	bit miss_found;
	integer candidate;
	integer index;
	integer lookup_index;
	bit candidate_present;

	always #5 clk = ~clk;

	generate
		if (VARY_RESPONSE_LATENCY) begin : variable_latency
			logic delayed_match = 1'b0;
			logic delayed_no_match = 1'b0;
			logic [2:0] delayed_addr = '0;
			integer response_index = 0;
			integer delay_ns;

			assign match = delayed_match;
			assign no_match = delayed_no_match;
			assign match_addr = delayed_addr;

			always @(negedge clk) begin
				if (!rst) begin
					if ($isunknown({dut_match, dut_no_match}))
						$fatal(1, "Unknown DUT result signals before delay shim");
					if (dut_match || dut_no_match) begin
						delay_ns = (response_index % 3) * 20;
						$display("Delaying DUT response %0d by %0d extra clocks",
							response_index, delay_ns / 10);
						delayed_match <= #(delay_ns) dut_match;
						delayed_no_match <= #(delay_ns) dut_no_match;
						delayed_addr <= #(delay_ns) dut_match_addr;
						delayed_match <= #(delay_ns + 10) 1'b0;
						delayed_no_match <= #(delay_ns + 10) 1'b0;
						response_index = response_index + 1;
					end
				end
			end
		end
		else begin : direct_response
			assign match = dut_match;
			assign no_match = dut_no_match;
			assign match_addr = dut_match_addr;
		end
	endgenerate

	always @(posedge clk) begin
		cycle_count = cycle_count + 1;
		#1;
		if (!rst) begin
			if ($isunknown({match, no_match}))
				$fatal(1, "Unknown result signals at cycle %0d", cycle_count);
			if (match && no_match)
				$fatal(1, "match and no_match asserted together");
			if (match || no_match) begin
				if (previous_result)
					$fatal(1, "Result outputs must be single-cycle pulses");
				if (received_count == sent_count)
					$fatal(1, "Unexpected response with no pending lookup");
				if (expected_addr[read_ptr] == -1) begin
					if (match !== 1'b0 || no_match !== 1'b1)
						$fatal(1, "Lookup %0d: expected no_match", received_count);
				end
				else if (match !== 1'b1 || no_match !== 1'b0 ||
					match_addr !== expected_addr[read_ptr]) begin
					$fatal(1, "Lookup %0d: expected address %0d, got match=%b no_match=%b address=%0d",
						received_count, expected_addr[read_ptr], match, no_match, match_addr);
				end
				$display("Lookup %0d: PASS at cycle %0d, expected address=%0d",
					received_count, cycle_count, expected_addr[read_ptr]);
				read_ptr = (read_ptr + 1) % FIFO_DEPTH;
				received_count = received_count + 1;
			end
			previous_result = match || no_match;
		end
		else
			previous_result = 1'b0;
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
			if (sent_count - received_count >= FIFO_DEPTH)
				$fatal(1, "Expected-result FIFO full");
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
			if (sent_count > 0 && cycle_count + 1 - last_request_cycle != LOOKUP_CYCLES)
				$fatal(1, "Requests must be spaced exactly nine clocks apart");
			last_request_cycle = cycle_count + 1;
			expected_addr[write_ptr] = lowest_addr;
			write_ptr = (write_ptr + 1) % FIFO_DEPTH;
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
		repeat ((MAX_LOOKUPS + FIFO_DEPTH + 1) * LOOKUP_CYCLES + 20) @(posedge clk);
		$fatal(1, "Lookup test timeout: sent=%0d received=%0d", sent_count, received_count);
	end

	mini_tcam dut (
		.clk(clk),
		.rst(rst),
		.data(data),
		.tcam(tcam),
		.valid(valid),
		.match(dut_match),
		.no_match(dut_no_match),
		.match_addr(dut_match_addr)
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
		wait (received_count == sent_count);
		@(negedge clk);
		if (received_count != MAX_LOOKUPS || sent_count != MAX_LOOKUPS || multiple_match_count < 2)
			$fatal(1, "Incomplete lookup coverage");
		repeat (2) @(posedge clk);
		#2;
		$display("PASS: %0d lookups at nine-clock intervals, including %0d multiple-match queries",
			received_count, multiple_match_count);
		$finish;
	end
endmodule
