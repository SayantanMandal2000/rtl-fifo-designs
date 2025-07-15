`timescale 1ns / 1ps

module tb_async_fifo();

    parameter WIDTH = 4, DEPTH = 8;

    reg w_clk;
    reg r_clk;
    reg rst_n;
    reg wr_rq, rd_rq;
    wire full, empty;
    reg [WIDTH-1:0] wdata;
    wire [WIDTH-1:0] rdata;

    // Internal variables for FIFO verification
    reg [WIDTH-1:0] fifo [0:DEPTH-1]; // Verification FIFO
    reg [$clog2(DEPTH)-1:0] wptr = 0; // Write pointer
    reg [$clog2(DEPTH)-1:0] rptr = 0;  // Read pointer

    // Instantiate the FIFO top module
    async_fifo #(WIDTH, DEPTH) fifo_inst (
        .w_clk(w_clk),
        .r_clk(r_clk),
        .rst_n(rst_n),
        .wr_rq(wr_rq),
        .rd_rq(rd_rq),
        .wdata(wdata),
        .rdata(rdata),
        .full(full),
        .empty(empty)
    );

    // Generate input clock (50 MHz = 20 ns period)
    initial begin
        w_clk = 0;
        forever #10 w_clk = ~w_clk;
    end

    initial begin
        r_clk = 0;
        forever #16.67 r_clk = ~r_clk;
    end

    initial begin
        rst_n = 1;
        wr_rq = 0;
        rd_rq = 0;
        wdata = 0;
        #10 rst_n = 0;  
        #20 rst_n = 1;  

        #13 wr_rq=1;rd_rq=1;
        fork
            // Write operation
            repeat (150) begin
                @(posedge w_clk);
                if (!full) begin
                    wdata = $random();           
                    fifo[wptr] = wdata;     
                    wptr = (wptr + 1) % DEPTH; 
                end
                             
                #10; 
            end
            
            forever begin
                @(posedge r_clk);
                if (!empty && rd_rq) begin               
                    rptr = (rptr + 1) % DEPTH; 
                end
               
            end
        join        
    end
  
endmodule
