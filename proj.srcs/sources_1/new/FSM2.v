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


module FSM2(clk_50Hz,rst_n, button, state);
    input clk_50Hz,rst_n,button;
    output reg[7:0] state;
    reg button_en;
    always @(posedge clk_50Hz or negedge rst_n) begin
        if (!rst_n) begin
            state<=0; // ready
            button_en=1;
        end
        else if (button) begin
            if (button_en) begin
                state<=state+1; // change state
                button_en=0;
            end
        end
        else begin
            state<=state; // default
            button_en=1;
        end
    end
endmodule
