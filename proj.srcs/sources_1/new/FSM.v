`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cun
// 
// Create Date: 2023/05/22 15:21:51
// Design Name: 
// Module Name: FSM
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
//done
module FSM(clrn, a_button, b_button, CPU_button, state);
    input clrn, a_button, b_button, CPU_button;
    output reg[1:0] state;
    always @(*) begin
        if(clrn == 0) begin
            state <= 2'b00; //initial state
        end else if (a_button) begin
            state <= 2'b01; //input A state
        end else if (b_button) begin
            state <= 2'b10; //input B state
        end else if (CPU_button) begin
            state <= 2'b11; //CPU run state
        end else begin
            state <= state; //default
        end
    end

endmodule
