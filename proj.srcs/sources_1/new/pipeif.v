`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cun
// 
// Create Date: 2023/05/20 20:34:52
// Design Name: 
// Module Name: pipeif
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
module pipeif (memclk, pcsource, pc, bpc, rpc, jpc, npc, pc4, ins, upg_rst, upg_clk, upg_wen, upg_adr, upg_dat, upg_done);
    input memclk;
    input [31:0] pc, bpc, rpc, jpc;
    input [1:0] pcsource;
    output [31:0] npc, pc4, ins; //pc4 : pc + 4
    input upg_rst, upg_clk, upg_wen, upg_done;
    input [13:0] upg_adr;
    input [31:0] upg_dat;
    mux4x32 next_pc (pc4, bpc, rpc, jpc, pcsource, npc);
    assign pc4 = pc + 32'h4;
    pipeimem ist_mem(memclk, pc, ins, upg_rst, upg_clk, upg_wen, upg_adr, upg_dat, upg_done);

endmodule