`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/20 20:50:33
// Design Name: 
// Module Name: mux4x32
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


module mux4x32(a0, a1, a2, a3, s, y); // 32-bit 4-multiplexer
    input [31:0] a0, a1, a2, a3;
    input [1:0] s;
    output [31:0] y;
    assign y = s[1] ? s[0] ? a3 : a2 : s[0] ? a1 : a0;
endmodule
