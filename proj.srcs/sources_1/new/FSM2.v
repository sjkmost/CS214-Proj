`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/23 10:27:56
// Design Name: 
// Module Name: FSM2
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


module FSM2(rst, button, state);
    input rst,button;
    output reg[7:0] state;
    always @(posedge button or posedge rst) begin
        if (rst) begin
            state<=8'b0000_0000; // ready
        end
        else if (button) begin
            state<=state+1; // change state
        end
        else begin
            state<=state;
        end
    end
endmodule