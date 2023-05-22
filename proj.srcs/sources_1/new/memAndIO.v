`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cun
// 
// Create Date: 2023/05/22 15:21:51
// Design Name: 
// Module Name: memAndIO
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

module memAndIO(we, addr, datain, clk, memclk, dataout, state, in_x, in_a, in_b);
    input [31:0] addr, datain;
    input clk, we, memclk;
    input [1:0] state;
    input [2:0] in_x;
    input [7:0] in_a;
    input [7:0] in_b;
    output [31:0] dataout;
    wire [2:0] x;
    reg [7:0] a;
    reg [7:0] b;
    assign x = in_x;
    always @(in_a, clrn) begin
        if(clrn == 0) begin
            a <= 0;
        end else if(state == 2'b01)begin
            a <= in_a;
        end else begin
            a <= a;
        end
    end
    always @(in_b, clrn) begin
        if(clrn == 0) begin
            b <= 0;
        end else if(state == 2'b10)begin
            b <= in_b;
        end else begin
            b <= b;
        end
    end
    wire [31:0] realAddr = addr - 12;
    reg [31:0] realDataout;
    pipemem realMem(we, realAddr, datain, clk, memclk, realDataout);
    
    always @(*) begin
        if(addr == 32'h0000_0000)begin
            dataout <= x;
        end else if(addr == 32'h0000_0001) begin
            dataout <= a;
        end else if(addr == 32'h0000_0002) begin
            dataout <= b;
        end else begin
            dataout <= realDataout;
        end
    end

endmodule