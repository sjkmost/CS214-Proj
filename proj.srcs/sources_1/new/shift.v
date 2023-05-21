`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/20 22:02:32
// Design Name: 
// Module Name: shift
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


module shift(d, sa, right, arith, r);
    input [31:0] d;
    input [4:0] sa;
    input right, arith;
    output reg [31:0] r;
    always @(*) begin
        if (!right) begin
            r <= d << sa;
        end else if (!arith) begin
            r <= d >> sa;
        end else begin
            r <= $signed(d) >>> sa;
        end
    end
endmodule
