`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cun
// 
// Create Date: 2023/05/20 20:34:52
// Design Name: 
// Module Name: pipemem
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

module pipemem(state, we, addr, datain, clk, memclk, io_r1, io_r2, io_w__led, io_w_seg_1, io_w_seg_2, io_w_seg_3, dataout, upg_rst, upg_clk, upg_wen, upg_adr, upg_dat, upg_done);
    input [7:0] state;
    input [31:0] addr, datain;
    input [2:0] io_r1;
    input [7:0] io_r2;
    input clk, we, memclk;
    output io_w__led;
    output [15:0] io_w_seg_1;
    output [7:0] io_w_seg_2, io_w_seg_3;
    output [31:0] dataout;
    
    input upg_rst, upg_clk, upg_wen, upg_done;
    input [13:0] upg_adr;
    input [31:0] upg_dat;
    wire [31:0] memin, memout, memaddr;
//    output [31:0] test_addr;
//    assign test_addr=memaddr;
    wire write_enable;
    assign write_enable = (we && ~clk) || ( (state < 4) && (state > 0) );
    MemOrIO io_processor(memclk,state, write_enable, write_enable, addr, memaddr, memout, io_r1, io_r2, io_w__led, io_w_seg_1, io_w_seg_2, io_w_seg_3, dataout, datain, memin);
    
    wire kick = upg_rst | (~upg_rst & upg_done);
    
    RAM ram(
        .clka(kick ? memclk : upg_clk),
        .wea(kick ? write_enable : upg_wen),
        .addra(kick ? memaddr[15:2] : upg_adr),
        .dina(kick ? memin : upg_dat),
        .douta(memout)
    );
endmodule