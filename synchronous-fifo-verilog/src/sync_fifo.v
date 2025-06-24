// Description: Parameterized synchronous FIFO using counter-based full/empty detection.
`timescale 1ns / 1ps

module sync_fifo(
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
    reg [ADDR_WIDTH-1:0] wr_ptr,rd_ptr; 
    reg [ADDR_WIDTH:0] count; //element count
    
    // =========================================================================
    // WRITE OPERATION: Pushes data into FIFO memory when write enabled and not full
    // =========================================================================
    always@(posedge clk) begin
        if(rst)
            wr_ptr<=0;
        else if(wr_en && !full) begin
            mem[wr_ptr]<=wr_data;
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
           rd_data<=mem[rd_ptr];
            rd_ptr<=rd_ptr+1;
        end
    end
    
    // =========================================================================
    // ELEMENT COUNT LOGIC: Tracks the number of elements currently stored in the FIFO
    always@(posedge clk) begin
        if(rst)
            count<=0;
        else begin
            if(wr_en && !full)
                count<=count+1;   // Increment due to entry of new data (write only)
            else if(rd_en && !empty)
                count<=count-1;   // Decrement due to removal of data (read only)
            else
                count<=count;
        end
    end
    
    // =========================================================================
    // Status flag
    assign full=(count==DEPTH);
    assign empty=(count==0);
    
endmodule

