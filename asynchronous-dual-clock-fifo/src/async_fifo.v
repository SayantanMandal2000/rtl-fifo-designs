`timescale 1ns / 1ps

module async_fifo
#(parameter WIDTH = 4, 
  parameter DEPTH = 8
)
(
    input wire w_clk,          // Write clock
    input wire  r_clk,           // Read clock
    input wire rst_n,           // Active-low reset
    input wire wr_rq,           // Write request
    input wire rd_rq,           // Read request
    input wire [WIDTH-1:0] wdata, // Write data
    output wire full,           // FIFO full flag
    output wire empty,          // FIFO empty flag
    output wire [WIDTH-1:0] rdata // Read data
);

    // Internal wires for FIFO control and synchronization
    wire [$clog2(DEPTH)-1:0] waddr;    // Write address
    wire [$clog2(DEPTH)-1:0] raddr;    // Read address
    wire [$clog2(DEPTH):0] wptr;       // Write pointer
    wire [$clog2(DEPTH):0] rptr;       // Read pointer
    wire [$clog2(DEPTH):0] wsync_ptr2; // Synchronized read pointer in write clock domain
    wire [$clog2(DEPTH):0] rsync_ptr2; // Synchronized write pointer in read clock domain

    // Instantiate synchronization and FIFO modules
    // Read pointer to write clock domain synchronization
    sync_r2w #(.DEPTH(DEPTH)) sync_r2w_inst (
        .rptr(rptr),
        .w_clk(w_clk),
        .rst_n(rst_n),
        .wsync_ptr2(wsync_ptr2)
    );
    
    // Write pointer to read clock domain synchronization
    sync_w2r #(.DEPTH(DEPTH)) sync_w2r_inst (
        .wptr(wptr),
        .r_clk(r_clk),
        .rst_n(rst_n),
        .rsync_ptr2(rsync_ptr2)
    );
    
    // FIFO Memory Array
    // Dual clock write/read memory block
    fifo_mem #(.WIDTH(WIDTH), .DEPTH(DEPTH)) fifomem_inst (
        .w_clk(w_clk),
        .r_clk(r_clk),
        .wr_rq(wr_rq),
        .rd_rq(rd_rq),
        .full(full),
        .empty(empty),
        .waddr(waddr),
        .raddr(raddr),
        .wdata(wdata),
        .rdata(rdata)
    );
    
    // Full Flag Logic
    full #(.WIDTH(WIDTH), .DEPTH(DEPTH)) full_inst (
        .w_clk(w_clk),
        .rst_n(rst_n),
        .wr_rq(wr_rq),
        .wsync_ptr2(wsync_ptr2),
        .waddr(waddr),
        .wptr(wptr),
        .full(full)
    );
    
    // Empty Flag Logic
    empty #(.WIDTH(WIDTH), .DEPTH(DEPTH)) empty_inst (
        .r_clk(r_clk),
        .rst_n(rst_n),
        .rd_rq(rd_rq),
        .rsync_ptr2(rsync_ptr2),
        .raddr(raddr),
        .rptr(rptr),
        .empty(empty)
    );

endmodule
