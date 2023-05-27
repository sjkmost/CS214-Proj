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


module MemOrIO(state,mRead,mWrite,addr_in,addr_out,m_rdata,io_rdata1,io_rdata2,iwled,out1,out2,out3,r_wdata,r_rdata,write_data);
    input [7:0] state; // 0 for ready, 1 for read x, 2 for read a, 3 for read b, 4 for executing, 5 and larger for out
    input mRead; // read memory, from Controller
    input mWrite; // write memory, from Controller
    input [31:0] addr_in; // from alu_result in ALU
    output [31:0] addr_out; // address to Data-Memory
    input [31:0] m_rdata; // data read from Data-Memory
    input [2:0] io_rdata1; // data read from IO
    input [7:0] io_rdata2; 
    output reg iwled;
    output reg[15:0] out1;
    output reg[7:0] out2;
    output reg[7:0] out3;
    output [31:0] r_wdata; // data to Decoder(register file)
    input [31:0] r_rdata; // data read from Decoder(register file)
    output [31:0] write_data;
    assign write_data=state<2?io_rdata1:(state<4?io_rdata2:r_rdata);
    assign r_wdata=m_rdata;
    assign addr_out=state>4?((state<<2)-8):(state<4?((state<<2)-4):addr_in);
    always@(state, m_rdata)
    begin
        case(state)
            8'b0000_0000: begin
                out1<=0;
                out2<=0;
                out3<=0;
                iwled<=0;
            end
            8'b0000_0001: begin
                out1<=out1;
                out2<=out2;
                out3<=out3;
                iwled<=iwled;
            end
            8'b0000_0010: begin
                out1<=out1;
                out2<=out2;
                out3<=out3;
                iwled<=iwled;
            end
            8'b0000_0011: begin
                out1<=out1;
                out2<=out2;
                out3<=out3;
                iwled<=iwled;
            end
            8'b0000_0100: begin
                out1<=out1;
                out2<=out2;
                out3<=out3;
                iwled<=iwled;
            end
            8'b0000_0101:  begin
                out1<=out1;
                out2<=out2;
                out3<=out3;
                iwled<=m_rdata[0];
            end
            8'b0000_0110: begin
                out1<=m_rdata[15:0];
                out2<=out2;
                out3<=out3;
                iwled<=iwled;
            end
            8'b0000_0111: begin
                out1<=out1;
                out2<=m_rdata[7:0];
                out3<=out3;
                iwled<=iwled;
            end
            8'b0000_1000: begin
                out1<=out1;
                out2<=out2;
                out3<=m_rdata[7:0];
                iwled<=iwled;
            end
            default: begin
                out1<=out1;
                out2<=out2;
                out3<=out3;
                iwled<=iwled;
            end
        endcase
    end
endmodule
