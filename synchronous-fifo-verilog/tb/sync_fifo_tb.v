`timescale 1ns / 1ps

module sync_fifo_tb();

    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en; 
    reg [7:0] wr_data;  //8-bit data
    wire [7:0] rd_data;
    wire full;
    wire empty;
    
    fifo_sync_msb dut(clk,rst,wr_en,rd_en,wr_data,rd_data,full,empty);
  //sync_fifo_counter dut(clk,rst,wr_en,rd_en,wr_data,rd_data,full,empty);
    
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    
    initial begin
        rst=1;
        #10 rst=0;
    end
    
    initial begin
        wr_en=0; rd_en=0; 
        #10 wr_en=1;
        #5 wr_data=8'h50;
        #10 wr_en=1; wr_data=8'hA9;
        #10 wr_data=8'hF0;
        #10 wr_data=8'hEF;
        #10 wr_data=8'h3F;
        #10 wr_data=8'hE9;
        #10 wr_data=8'h01;
        #10 wr_data=8'hFF;
        #10 wr_data=8'h6C;
        #10 wr_data=8'hAC;
        #10 wr_en=0;
        #10 rd_en=1;
        #100 $finish;
    end
    
endmodule
