`timescale 1ns / 1ps

// Purpose: Generate the 'empty' flag for the asynchronous FIFO (read side)
module empty
#(
    parameter WIDTH = 4,   
    parameter DEPTH = 8  
)
(
    input wire r_clk,             
    input wire rst_n,              
    input wire rd_rq,              
    input wire [$clog2(DEPTH):0] rsync_ptr2, 
    output reg [$clog2(DEPTH)-1:0] raddr,    
    output reg [$clog2(DEPTH):0] rptr,       
    output reg empty                          
    );

    reg [$clog2(DEPTH):0] bin, binnext, graynext;
    reg emptyn;
    
    // Updates read pointer and empty flag every clock cycle
    always @(posedge r_clk or negedge rst_n) begin
        if (!rst_n) begin
            rptr <= 'd0;       
            bin <= 'd0;        
            empty <= 1;       
        end else begin
            rptr <= graynext;  
            bin <= binnext;    
            empty <= emptyn;   
        end
    end
    
    // Computes next read address, pointers, and empty condition
    always @(*) begin
        raddr = bin[$clog2(DEPTH)-1:0];         // Extract current binary read address
        binnext = bin + (~empty & rd_rq);       // Increment binary read pointer
        graynext = (binnext >> 1) ^ binnext;    // Convert binary to Gray code for next pointer
        emptyn = (graynext == rsync_ptr2);      // FIFO is empty when read pointer equals synchronized write pointer
    end
    
endmodule