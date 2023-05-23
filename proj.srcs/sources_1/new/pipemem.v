`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cun
// 
// Create Date: 2023/05/20 20:34:52
// Design Name: 
// Module Name: pipemem
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

module pipemem(state, we, addr, datain, clk, memclk, io_r1, io_r2, io_w_led, io_w_seg1, io_w_seg2, io_w_seg3, dataout);
    input [7:0] state;
    input [31:0] addr, datain;
    input [2:0] io_r1;
    input [7:0] io_r2;
    input clk, we, memclk;
    output io_w_led;
    output [15:0] io_w_seg1;
    output [7:0] io_w_seg2, io_w_seg3;
    output [31:0] dataout;

    wire [31:0] memin, memout, memaddr;
    wire write_enable = we & ~clk;
    
    MemOrIO io_processor(state, write_enable, write_enable, addr, memaddr, memout, io_r1, io_r2, io_w_led, io_w_seg1, io_w_seg2, io_w_seg3, dataout, datain, memin);
    
    RAM ram(
        .clka(memclk),
        .wea(write_enable),
        .addra(addr[15:2]),
        .dina(memin),
        .douta(memout)
    );
endmodule