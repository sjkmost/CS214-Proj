`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cun
// 
// Create Date: 2023/05/20 20:34:52
// Design Name: 
// Module Name: pipeimem
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

module pipeimem(clk, a, inst);
    input clk;
    input [31:0] a;
    output [31:0] inst;
    
    
    ROM instmem(
        .clka(clk),
        .addra(a[15:2]),
        .douta(inst)
    );
endmodule