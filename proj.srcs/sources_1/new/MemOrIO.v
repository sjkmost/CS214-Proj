`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 21:48:04
// Design Name: 
// Module Name: MemOrIO
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


module MemOrIO(state,mRead,mWrite,addr_in,addr_out,m_rdata,io_rdata1,io_rdata2,io_wdata_led,io_wdata_seg_out1,io_wdata_seg_out2,io_wdata_seg_out3,r_wdata,r_rdata,write_data);
    input [7:0] state; // 0 for ready, 1 for read x, 2 for read a, 3 for read b, 4 for executing, 5 and larger for out
    input mRead; // read memory, from Controller
    input mWrite; // write memory, from Controller
    input [31:0] addr_in; // from alu_result in ALU
    output [31:0] addr_out; // address to Data-Memory
    input [31:0] m_rdata; // data read from Data-Memory
    input [2:0] io_rdata1; // data read from IO
    input [7:0] io_rdata2; 
    output io_wdata_led;
    output [15:0] io_wdata_seg_out1;
    output [7:0] io_wdata_seg_out2;
    output [7:0] io_wdata_seg_out3;
    output [31:0] r_wdata; // data to Decoder(register file)
    input [31:0] r_rdata; // data read from Decoder(register file)
    output reg[31:0] write_data;
    reg [31:0] addrout;
    assign addr_out=addrout;
    always@(state,r_rdata)
    begin
        case(state)
            1: write_data<=io_rdata1; // input x
            2: write_data<=io_rdata2; // input a
            3: write_data<=io_rdata2; // input b
            default: write_data<=r_rdata; // executing
        endcase
    end
    assign r_wdata=m_rdata;
    always@(state,addr_in)
    begin
        case(state)
            1: addrout<=0; // read x
            2: addrout<=4; // read a
            3: addrout<=8; // read b
            4: addrout<=addr_in; // executing
            default: addrout<=((state<<2)-8); // output
        endcase
    end
    reg iwled;
    assign io_wdata_led=iwled;
    reg [15:0] out1;
    reg [7:0] out2,out3;
    assign io_wdata_seg_out1=out1;
    assign io_wdata_seg_out2=out2;
    assign io_wdata_seg_out3=out3;
    always@(state,m_rdata)
    begin
        case(state)
            0:;
            1:;
            2:;
            3:;
            4:;
            5: iwled<=m_rdata[0];
            6: out1<=m_rdata[15:0];
            7: out2<=m_rdata[7:0];
            default: out3<=m_rdata[7:0];
        endcase
    end
endmodule
