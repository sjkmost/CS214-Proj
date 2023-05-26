`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/26 14:27:11
// Design Name: 
// Module Name: cpu_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_test();
    reg clk;
    reg mclk;
    reg reset;
    reg button;
    reg [2:0] io_r1;
    reg [7:0] io_a=8'b0000_0001;
    reg [7:0] io_b=8'b0000_0010;
    reg [7:0] io_r2;
    wire io_w_led;
    wire [7:0] seg_en,seg_out;
    wire [15:0] out1;
    wire [7:0] out2,out3;
    wire [31:0] pc;
    wire [7:0] state;
    wire [31:0] addr,maddr,ins;
    wire [31:0] alua, alub;
    pipelinedcpu cpu0(clk,mclk,reset,button,io_r1,io_r2,io_w_led,seg_en,seg_out,out1,out2,out3,pc,state,addr,maddr,ins, alua, alub);
    always #10 clk=~clk;
    always #1 mclk=~mclk;
    initial begin
        clk=0;
        mclk=0;
        reset=0;
        button=0;
        io_r1=3'b111;
        io_r2=8'b0000_0001;
        #1 reset=1;
        #1 reset=0;
        #8 button=~button;
        #1 button=~button;
        #1 io_r2=3-io_r2;
        #8 button=~button;
        #1 button=~button;
        #1 io_r2=3-io_r2;
        #8 button=~button;
        #1 button=~button;
        #1 io_r2=3-io_r2;
        #8 button=~button;
        #800 button=~button;
        #1 button=~button;
        #9 button=~button;
        #1 button=~button;
        #9 button=~button;
        #1 button=~button;
        #9 button=~button;
        #1 button=~button;
    end
endmodule