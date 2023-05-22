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

//ledout 32'h0000_0003 1bit
//out1 32'h0000_0004 16bits
//out2 32'h0000_0008 8bits
//out3 32'h0000_000c 8bits

module memAndIO(we, addr, datain, clk, memclk, dataout, state, in_x, in_a, in_b, ledout, out1, out2, out3);
    input [31:0] addr, datain;
    input clk, we, memclk;
    input [1:0] state;
    input [2:0] in_x;
    input [7:0] in_a;
    input [7:0] in_b;
    output [31:0] dataout;
    output ledout;
    output [15:0] out1;
    output [7:0] out2;
    output [7:0] out3;
    wire [2:0] x;
    wire write_enable = we & ~clk;
    reg [7:0] a;
    reg [7:0] b;
    reg ledout;
    reg [15:0] out1;
    reg [7:0] out2;
    reg [7:0] out3;
    assign x = in_x;
    always @(in_a or clrn) begin
        if(clrn == 0) begin
            a <= 0;
        end else if(state == 2'b01)begin
            a <= in_a;
        end else begin
            a <= a;
        end
    end
    always @(in_b or clrn) begin
        if(clrn == 0) begin
            b <= 0;
        end else if(state == 2'b10)begin
            b <= in_b;
        end else begin
            b <= b;
        end
    end
    wire [31:0] realAddr = addr - 16;
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

    always @(posedge clk or negedge clrn) begin
        if(write_enable && (addr == 32'h0000_0003) ) begin
            ledout <= datain[0:0];
        end else begin
            ledout <= ledout;
        end
    end
    always @(posedge clk or negedge clrn) begin
        if(write_enable && (addr == 32'h0000_0004) ) begin
            out1 <= datain[15:0];
        end else begin
            out1 <= out1;
        end
    end
    always @(posedge clk or negedge clrn) begin
        if(write_enable && (addr == 32'h0000_0008) ) begin
            out2 <= datain[7:0];
        end else begin
            out2 <= out2;
        end
    end
    always @(posedge clk or negedge clrn) begin
        if(write_enable && (addr == 32'h0000_000c) ) begin
            out3 <= datain[7:0];
        end else begin
            out3 <= out3;
        end
    end

endmodule