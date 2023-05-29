`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cun
// 
// Create Date: 2023/05/20 20:34:52
// Design Name: 
// Module Name: pipeimem
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

module pipeimem(clk, a, inst, upg_rst, upg_clk, upg_wen, upg_adr, upg_dat, upg_done);
    input clk;
    input [31:0] a;
    output [31:0] inst;
    input upg_rst, upg_clk, upg_wen, upg_done;
    input [13:0] upg_adr;
    input [31:0] upg_dat;
    
    wire kick = upg_rst | (~upg_rst & upg_done); // if in UART communication mode
    
    RAM_inst inst_mem(
        .clka(kick ? clk : upg_clk), 
        .wea(kick ? 0 : upg_wen), 
        .addra(kick ? a[15:2] : upg_adr), 
        .dina(kick ? 0 : upg_dat), 
        .douta(inst)
    );
    
//     ROM instmem(
//         .clka(clk),
//         .addra(a[15:2]),
//         .douta(inst)
//     );
endmodule