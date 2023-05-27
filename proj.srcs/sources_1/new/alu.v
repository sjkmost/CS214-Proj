`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/20 22:08:52
// Design Name: 
// Module Name: alu
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

// 0 0 0 0 ADD
// 0 1 0 0 SUB
// 1 0 0 0 MUL
// 1 1 0 0 DIV
// X 0 0 1 AND
// X 1 0 1 OR
// X 0 1 0 XOR
// X 1 1 0 LUI
// 0 0 1 1 SLL
// 0 1 1 1 SRL
// 1 1 1 1 SRA
//module alu(a, b, aluc, r, z, v);
module alu(a, b, aluc, r, z);
    input [31:0] a, b;
    input [3:0] aluc;
    output [31: 0] r;
//    output z, v;
    output z;
    wire [31:0] r_addsub = aluc[2] ? a - b : a + b;
    wire [31:0] r_div = a[31] ? b[31] ? (-a) / (-b) : -((-a) / b) : b[31] ? -(a / (-b)) : a / b;
    wire [31:0] r_muldiv = aluc[2] ? r_div : a * b;
    wire [31:0] r_arith = aluc[3] ? r_muldiv : r_addsub;
    wire [31:0] r_and = a & b;
    wire [31:0] r_or = a | b;
    wire [31:0] r_andor = aluc[2] ? r_or : r_and;
    wire [31:0] r_xor = a ^ b;
    wire [31:0] r_lui = {b[15:0], 16'b0};
    wire [31:0] r_xorlui = aluc[2] ? r_lui : r_xor;
    wire [31:0] r_sh;
    shift shifter(b, a[4:0], aluc[2], aluc[3], r_sh);
    mux4x32 selector(r_arith, r_andor, r_xorlui, r_sh, aluc[1:0], r);
    assign z = !(!r);
//    assign v = !aluc[1:0] && 
//               ((aluc[2] && ((a[31] && !b[31] && !r[31]) || (!a[31] && b[31] && r[31]))) ||
//               ((!aluc[2] && ((a[31] && b[31] && !r[31]) || (!a[31] && !b[31] && r[31])))));
endmodule
