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

module pipemem(we, addr, datain, clk, memclk, dataout);
    input [31:0] addr, datain;
    input clk, we, memclk;
    output [31:0] dataout;

    wire write_enable = we & ~clk;
    
    RAM ram(
        .clka(memclk),
        .wea(write_enable),
        .addra(addr[15:2]),
        .dina(datain),
        .douta(dataout)
    );
endmodule