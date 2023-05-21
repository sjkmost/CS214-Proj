`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cun
// 
// Create Date: 2023/05/20 20:34:52
// Design Name: 
// Module Name: pipelinedcpu
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


module pipelinedcpu(clock, memclock, resetn, pc, inst, ealu, malu, walu);
    input clock, memclock, resetn;
    output [31:0] pc, inst, ealu, malu, walu;
    wire [31:0] bpc, jpc, npc, pc4, ins, dpc4, inst, da, db, dimm, ea, eb, eimm;
    wire [31:0] epc4, mb, mmo, wmo, wdi;
    wire [4:0] drn, ern0, ern, mrn, wrn;
    wire [3:0] daluc, ealuc;
    wire[1:0] pcsource;
    wire wpcir;
    wire dwreg, dm2reg, dwmem, daluimm, dshift, djal;
    wire ewreg, em2reg, ewmem, ealuimm, eshift, ejal;
    wire mwreg, mm2reg, mwmem;
    wire wwreg, wm2reg;
    pipepc prog_cnt (npc, wpcir, clock, resetn, pc);
    //TODO

endmodule
