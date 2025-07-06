// Top level module of Asynchronous Dual Clock FIFO
`timescale 1ns / 1ps

module async_fifo(
    input w_clk,
    input w_rstn,
    input w_en,
    input [DATA_WIDTH-1:0] w_data,
    input r_clk,
    input r_rstn,
    input r_en,
    output [DATA_WIDTH-1:0] r_data,
    output full,
    output empty
    );
    
    parameter DATA_WIDTH=8;
    parameter ADDR_WIDTH=3;
    
    wire [ADDR_WIDTH-1:0] w_addr,r_addr;
    wire [ADDR_WIDTH:0] wptr,rptr,wq2_rptr,rq2_wptr;
    
    fifo_mem memory(w_clk,(w_en&(!full)),w_data,w_addr,r_clk,(r_en&(!empty)),r_addr,r_data);
        
    sync_r2w rd2wr(w_clk,w_rstn,rptr,wq2_rptr);
    
    sync_w2r wr2rd(r_clk,r_rstn,wptr,rq2_wptr);
    
    wptr_full w_full(w_clk,w_rstn,w_en,wq2_rptr,wptr_gray,w_addr,full);
    
    rptr_empty r_empty(r_clk,r_rstn,r_en,rq2_wptr,rptr_gray,r_addr,empty);
    
endmodule
