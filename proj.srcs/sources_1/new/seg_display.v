`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 15:23:04
// Design Name: 
// Module Name: seg_display
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

module seg_enc(
    input [3:0] a,
    output [7:0] rt
    );
    reg [7:0] ret;
    assign rt=ret;
    always @(*) begin
        case(a)
            4'h0: ret= 8'b0000_0011;
            4'h1: ret= 8'b1001_1111;
            4'h2: ret= 8'b0010_0101;
            4'h3: ret= 8'b0000_1101;
            4'h4: ret= 8'b1001_1001;
            4'h5: ret= 8'b0100_1001;
            4'h6: ret= 8'b0100_0001;
            4'h7: ret= 8'b0001_1111;
            4'h8: ret= 8'b0000_0001;
            4'h9: ret= 8'b0000_1001;
            4'ha: ret= 8'b0001_0001;
            4'hb: ret= 8'b1100_0001;
            4'hc: ret= 8'b1110_0101;
            4'hd: ret= 8'b1000_0101;
            4'he: ret= 8'b0110_0001;
            4'hf: ret= 8'b0111_0001;
            default: ret=8'b1111_1111;
        endcase
    end
endmodule

module seg_display(
    input clk,wr_en, //The clk of Minisys
    input [15:0] out1,
    input [7:0] out2,out3,
    output [7:0] seg_en,seg_out
    );
    reg clkout;
    reg [31:0] cnt;
    reg [2:0] scan_cnt;
    reg [3:0] Y_reg;
    reg [7:0] bit_sel_reg;
    parameter period=2000;
    seg_enc seg_enc0(Y_reg,seg_out);
    assign seg_en=wr_en?bit_sel_reg:8'b1111_1111;
    always@(posedge clk) begin
        if (cnt==(period>>1)-1) begin
            clkout=~clkout;
            cnt<=0;
        end
        else cnt<=cnt+1;
    end
    always@(posedge clkout) begin
        if (scan_cnt==3'b111) scan_cnt<=0;
        else scan_cnt<=scan_cnt+1;
    end
    always@(scan_cnt)
    begin
        case(scan_cnt)
            3'b000:bit_sel_reg=8'b1111_1110;
            3'b001:bit_sel_reg=8'b1111_1101;
            3'b010:bit_sel_reg=8'b1111_1011;
            3'b011:bit_sel_reg=8'b1111_0111;
            3'b100:bit_sel_reg=8'b1110_1111;
            3'b101:bit_sel_reg=8'b1101_1111;
            3'b110:bit_sel_reg=8'b1011_1111;
            3'b111:bit_sel_reg=8'b0111_1111;
            default:bit_sel_reg=8'b1111_1111;
        endcase
    end
    always@(scan_cnt,out1,out2,out3)
    begin
        case(scan_cnt)
            0: Y_reg<=out1[15:12];
            1: Y_reg<=out1[11:8];
            2: Y_reg<=out1[7:4];
            3: Y_reg<=out1[3:0];
            4: Y_reg<=out3[7:4];
            5: Y_reg<=out3[3:0];
            6: Y_reg<=out2[7:4];
            7: Y_reg<=out2[3:0];
            default Y_reg=4'b0000;
        endcase
    end
endmodule