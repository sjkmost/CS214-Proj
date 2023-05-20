`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/20 20:57:14
// Design Name: 
// Module Name: dffe32
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


module dffe32(d, clk, clrn, e, q);
    input [31:0] d;
    input clk, clrn, e;
    output reg [31:0] q;
    always @(negedge clrn or posedge clk) begin
        if (clrn == 0) begin
            q <= 0;
        end else begin
            q <= d;
        end
    end
endmodule
