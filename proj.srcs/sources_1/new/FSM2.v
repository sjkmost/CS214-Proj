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


module FSM2(clk, rst, button, state, clk_10Hz);
    input clk,rst,button;
    output reg[7:0] state;
    output reg clk_10Hz;
    wire rst_n;
    assign rst_n=~rst;
    reg [31:0] cnt2;
    parameter period=2;
    always@(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            clk_10Hz<=0;
            cnt2<=0;
        end
        else if (cnt2==(period>>1)-1) begin
            clk_10Hz<=~clk_10Hz;
            cnt2<=0;
        end
        else begin
            clk_10Hz<=clk_10Hz;
            cnt2<=cnt2+1;
        end
    end
    reg [31:0] cnt;
    parameter period2=20;
    reg button_en;
    always @(posedge clk_10Hz or negedge rst_n) begin
        if (!rst_n) begin
            state<=8'b0000_0000; // ready
            button_en=1;
            cnt<=cnt;
        end
        else if (state<5||state==7) begin
            if (button) begin
                if (button_en) begin
                    state<=state+1; // change state
                    button_en=0;
                    cnt<=cnt;
                end
                else begin
                    state<=state;
                    button_en=0;
                    cnt<=cnt;
                end
            end
            else begin
                state<=state;
                button_en=1;
                cnt<=cnt;
            end
        end
        else if (state<7) begin
            state<=state+1;
            button_en=1;
            cnt<=cnt;
        end
        else begin
            if (cnt==(period>>1)-1) begin
                state<=state+1;
                button_en=1;
                cnt<=0;
            end
            else begin
                state<=state;
                button_en=1;
                cnt<=cnt+1;
            end
        end
    end
endmodule