// RTL Code for the write pointer and full flag logic
`timescale 1ns / 1ps

module wptr_full(
    input w_clk,
    input w_rstn,
    input w_en,
    input [ADDR_WIDTH:0] wq2_rptr,
    output reg [ADDR_WIDTH:0] wptr_gray,
    output [ADDR_WIDTH-1:0] w_addr,
    output full
    );
    
    parameter ADDR_WIDTH=4;
    
    reg [ADDR_WIDTH:0] wptr_bin;
    wire [ADDR_WIDTH:0] wptr_bin_nxt,wptr_gray_nxt;
    
    assign wptr_bin_nxt=wptr_bin+(w_en&(~full));
    assign wptr_gray_nxt=wptr_bin_nxt^(wptr_bin_nxt>>1);
    
    assign full=(wptr_gray_nxt=={~wq2_rptr[ADDR_WIDTH:ADDR_WIDTH-1],wq2_rptr[ADDR_WIDTH-2:0]});
    
    assign w_addr=wptr_bin[ADDR_WIDTH-1:0];
    
    always@(posedge w_clk or negedge w_rstn) begin
        if(!w_rstn) begin
            wptr_bin<=0;
            wptr_gray<=0;
        end
        else begin
            wptr_bin<=wptr_bin_nxt;
            wptr_gray<=wptr_gray_nxt;
        end
    end
    
endmodule
  