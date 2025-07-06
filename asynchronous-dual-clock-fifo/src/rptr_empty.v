// RTL Code for the read pointer and empty flag logic
`timescale 1ns / 1ps

module rptr_empty(
    input r_clk,
    input r_rstn,
    input r_en,
    input [ADDR_WIDTH:0] rq2_wptr,
    output reg [ADDR_WIDTH:0] rptr_gray,
    output [ADDR_WIDTH-1:0] r_addr,
    output empty
    );
    
    parameter ADDR_WIDTH=4;
    
    reg [ADDR_WIDTH:0] rptr_bin;
    wire [ADDR_WIDTH:0] rptr_bin_nxt,rptr_gray_nxt;
    
    assign rptr_bin_nxt=rptr_bin+(r_en&(~empty));
    assign rptr_gray_nxt=rptr_bin_nxt^(rptr_bin_nxt>>1);
    
    assign empty=(rptr_gray_nxt==rq2_wptr);
    
    assign r_addr=rptr_bin[ADDR_WIDTH-1:0];
    
    always@(posedge r_clk or negedge r_rstn) begin
        if(!r_rstn) begin
            rptr_bin<=0;
            rptr_gray<=0;
        end
        else begin
            rptr_bin<=rptr_bin_nxt;
            rptr_gray<=rptr_gray_nxt;
        end
    end
    
endmodule
  