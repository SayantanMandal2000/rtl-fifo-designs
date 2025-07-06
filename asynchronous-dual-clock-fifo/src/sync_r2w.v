// RTL code for the read-clock domain to write-clock domain synchronizer module
`timescale 1ns / 1ps

module sync_r2w(
    input w_clk,
    input w_rstn,
    input [ADDR_WIDTH:0] rptr,
    output reg [ADDR_WIDTH:0] wq2_rptr
    );
    
    parameter ADDR_WIDTH=4;
    
    reg [ADDR_WIDTH:0] wq1_rptr;
    
    always@(posedge w_clk or negedge w_rstn) begin
        if(!w_rstn) begin
            wq1_rptr<=0;
            wq2_rptr<=0;
        end
        else begin
            wq1_rptr<=rptr;
            wq2_rptr<=wq1_rptr;
        end
    end
    
endmodule
