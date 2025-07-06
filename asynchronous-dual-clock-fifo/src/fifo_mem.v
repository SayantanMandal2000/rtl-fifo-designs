// RTL Code for the RAM type FIFO buffer memory array
`timescale 1ns / 1ps

module fifo_mem(
    input w_clk,
    input w_en,
    input [DATA_WIDTH-1:0] w_data,
    input [ADDR_WIDTH-1:0] w_addr,
    input r_clk,
    input r_en,
    input [ADDR_WIDTH-1:0] r_addr,
    output reg [ADDR_WIDTH-1:0] r_data
    );

    parameter ADDR_WIDTH=3;
    parameter DATA_WIDTH=8;
    parameter DEPTH=1<<ADDR_WIDTH;
    
    reg [DATA_WIDTH-1:0] mem[0:DEPTH-1];
    
    always@(posedge w_clk) begin
        if(w_en)
            mem[w_addr]<=w_data;
    end
    
    always@(posedge r_clk) begin
        if(r_en)
            r_data<=mem[r_addr];
    end

endmodule
