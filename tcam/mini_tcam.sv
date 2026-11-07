//Trever TCAm

module mini_tcam (
    input  logic         clk,
    input  logic         rst,
    input  logic [511:0] data,
    input  logic [511:0] tcam,
    input  logic         valid,
    output logic         match,
    output logic         no_match,
    output logic [2:0]   match_addr
);

//variabless I used
logic [511:0] mem [0:7];
logic [511:0] mem_out;
logic [511:0] key, mask;
logic [3:0] count;
logic found;
wire same;

//Counter
always @(posedge clk)
begin
    if (rst)
        count <= 9;
    else if (valid && count >= 8)
        count <= 0;
    else if (count < 9)
        count <= count + 1;
end

//Memory allocations
always @(posedge clk)
begin
    if (count < 8)
        mem_out <= mem[count[2:0]];
end

//TCAM comparison staement
assign same = &(mask | ~(key ^ mem_out));

//finding matches
always @(posedge clk)
begin
    if (rst)
    begin
        found <= 0;
        match_addr <= 0;
    end
    else
    begin
        if (count > 0 && count <= 8 && same && !found)
        begin
            found <= 1;
            match_addr <= count - 1;
        end

        if (valid && count >= 8)
            found <= 0;
    end
end

// sifting through data
always @(posedge clk)
begin
    if (rst)
    begin
        match <= 0;
        no_match <= 0;
    end
    else
    begin
        match <= 0;
        no_match <= 0;

        if (valid && count >= 8)
        begin
            key <= data;
            mask <= tcam;
        end

        if (count == 8)
        begin
            match <= found || same;
            no_match <= !(found || same);
        end
    end
end

endmodule
