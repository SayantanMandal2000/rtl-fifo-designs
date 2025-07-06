// RTL code for the write-clock domain to read-clock domain synchronizer module
`timescale 1ns / 1ps

module sync_w2r(
    input r_clk,
    input r_rstn,
    input [ADDR_WIDTH:0] wptr,
    output reg [ADDR_WIDTH:0] rq2_wptr
    );
    
    parameter ADDR_WIDTH=4;
    
    reg [ADDR_WIDTH:0] rq1_wptr;
    
    always@(posedge r_clk or negedge r_rstn) begin
        if(!r_rstn) begin
            rq1_wptr<=0;
            rq2_wptr<=0;
        end
        else begin
            rq1_wptr<=wptr;
            rq2_wptr<=rq1_wptr;
        end
    end
    
endmodule
