// Description: Parameterized synchronous FIFO using MSB toggle-based full/empty detection.
`timescale 1ns / 1ps

module fifo_sync_msb(
    input clk,   
    input rst,
    input wr_en,
    input rd_en,
    input [DATA_WIDTH-1:0] wr_data,   
    output reg [DATA_WIDTH-1:0]rd_data,  
    output full,
    output empty
    );
    
    parameter DATA_WIDTH=8;    // Width of each data word
    parameter ADDR_WIDTH=3;    // Log2(DEPTH); for 8-depth FIFO, use 3
    parameter DEPTH=1<<ADDR_WIDTH;  // Total number of FIFO entries , depth=2^3=8
    
    
    reg [DATA_WIDTH-1:0] mem[0:DEPTH-1];  
    reg [ADDR_WIDTH:0] wr_ptr,rd_ptr; 
    
    
    // =========================================================================
    // WRITE OPERATION: Pushes data into FIFO memory when write enabled and not full
    // =========================================================================
    always@(posedge clk) begin
        if(rst)
            wr_ptr<=0;
        else if(wr_en && !full) begin
            mem[wr_ptr[ADDR_WIDTH-1:0]]<=wr_data;
            wr_ptr<=wr_ptr+1;
        end
    end
    
    // =========================================================================
    // READ OPERATION: Retrieves data from FIFO memory when enabled and not empty
    always@(posedge clk) begin
        if(rst) begin
           rd_data<=0;
            rd_ptr<=0;
        end
        else if(rd_en && !empty) begin
           rd_data<=mem[rd_ptr[ADDR_WIDTH-1:0]];
            rd_ptr<=rd_ptr+1;
        end
    end
    
    // =========================================================================
    // Status flag
    assign full=((wr_ptr[ADDR_WIDTH]!=rd_ptr[ADDR_WIDTH]) && (wr_ptr[ADDR_WIDTH-1:0]==rd_ptr[ADDR_WIDTH-1:0]));
    assign empty=(wr_ptr==rd_ptr);
    
endmodule
