`timescale 1ns / 1ps

// Purpose: Generate the 'full' flag for the asynchronous FIFO (write side)
module full
#(parameter WIDTH = 4,
  parameter DEPTH = 8)
(
    input wire w_clk,
    input wire rst_n,
    input wire wr_rq,
    input wire [$clog2(DEPTH):0] wsync_ptr2,
    output reg [$clog2(DEPTH)-1:0] waddr,
    output reg [$clog2(DEPTH):0] wptr,
    output reg full
    );

    reg [$clog2(DEPTH):0] bin, binnext, graynext;
    reg fulln;
    
    // Updates the write pointer, binary counter, and full flag on each cycle
    always @(posedge w_clk or negedge rst_n) begin
        if (!rst_n) begin
            wptr <= 'd0;
            bin <= 'd0;
            full <= 0;
        end 
        else begin
            wptr <= graynext; 
            bin <= binnext;  
            full <= fulln;    
        end
    end
    
    // Computes next binary/Gray pointers and determines full condition
    always @(*) begin
        waddr = bin[$clog2(DEPTH)-1:0];       // Write address is the LSB portion of binary pointer
        binnext = bin + (~full & wr_rq);      // Compute next binary pointer
        graynext = (binnext >> 1) ^ binnext;  // Convert binary to Gray code  
        // Check for full condition:
        // Full is asserted when next Gray-coded write pointer equals
        // the synchronized read pointer with MSBs inverted (wrap-around condition) 
        fulln = (graynext == {~wsync_ptr2[$clog2(DEPTH):$clog2(DEPTH)-1], wsync_ptr2[$clog2(DEPTH)-2:0]});
    end

endmodule
