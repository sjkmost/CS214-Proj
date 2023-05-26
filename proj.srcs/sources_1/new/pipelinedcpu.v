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
//TODO add IO change
module pipelinedcpu(clk, reset, button, io_r1, io_r2, io_w_led,seg_en,seg_out);
    input clk, reset, button;
    input [2:0] io_r1;
    input [7:0] io_r2;
    output io_w_led;
    output [7:0] seg_en,seg_out;
    reg clock,memclock;
    reg [31:0] cnt;
    parameter period=10000;
    always@(posedge clk) begin
        if (cnt==(period>>1)-1) begin
            clock=~clock;
            cnt<=0;
        end
        else cnt<=cnt+1;
    end
    reg [31:0] cnt2;
    parameter period2=2000;
    always@(posedge clk) begin
        if (cnt2==(period2>>1)-1) begin
            memclock=~memclock;
            cnt2<=0;
        end
        else cnt2<=cnt2+1;
    end
//    cpuclk cpuclk1(
//        .clk_in1(clk),
//        .clk_out1(clock)
//    );
//    memclk memclk1(
//        .clk_in1(clk),
//        .clk_out1(memclock)
//    );
    wire resetn;
    assign resetn=~reset;
    wire [7:0] state;
    wire [31:0] bpc, jpc, npc, pc4, ins, dpc4, inst, da, db, dimm, ea, eb, eimm;
    wire [31:0] epc4, mb, mmo, wmo, wdi;
    wire [4:0] drn, ern0, ern, mrn, wrn;
    wire [3:0] daluc, ealuc;
    wire [1:0] pcsource;
    wire wpcir;
    wire dwreg, dm2reg, dwmem, daluimm, dshift, djal;
    wire ewreg, em2reg, ewmem, ealuimm, eshift, ejal;
    wire mwreg, mm2reg, mwmem;
    wire wwreg, wm2reg;
    wire [31:0] pc,ealu,malu,walu;
    wire [15:0] io_w_seg1;
    wire [7:0] io_w_seg2,io_w_seg3;
    FSM2 fsm(reset, button, state);
    pipepc prog_cnt (npc, wpcir, clock, resetn, pc);
    pipeif if_stage (memclock, pcsource, pc, bpc, da, jpc, npc, pc4, ins);
    pipeir inst_reg (pc4, ins, wpcir, clock, resetn, dpc4, inst);
    pipeid id_stage (mwreg, mrn, ern, ewreg, em2reg, mm2reg, dpc4, inst,
                    wrn, wdi, ealu, malu, mmo, wwreg, clock, resetn,
                    bpc, jpc, pcsource, wpcir, dwreg, dm2reg, dwmem,
                    daluc, daluimm, da, db, dimm, drn, dshift, djal, state);
    pipedereg de_reg(dwreg, dm2reg, dwmem, daluc, daluimm, da, db, dimm,
                    drn, dshift, djal, dpc4, clock, resetn,
                    ewreg, em2reg, ewmem, ealuc, ealuimm, ea, eb, eimm,
                    ern0, eshift, ejal, epc4);
    pipeexe exe_stage(ealuc, ealuimm, ea, eb, eimm, eshift, ern0, epc4,
                    ejal, ern, ealu);
    pipeemreg em_reg(ewreg, em2reg, ewmem, ealu, eb, ern, clock, resetn,
                    mwreg, mm2reg, mwmem, malu, mb, mrn);
    pipemem mem_stage(state, mwmem, malu, mb, clock, memclock, io_r1, io_r2, io_w_led, io_w_seg1, io_w_seg2, io_w_seg3);
    pipemwreg mw_reg(mwreg, mm2reg, mmo, malu, mrn, clock, resetn,
                    wwreg, wm2reg, wmo, walu, wrn);
    mux2x32 wb_stage(walu, wmo, wm2reg, wdi);
    seg_display sd(clk,1,io_w_seg1,io_w_seg2,io_w_seg3,seg_en,seg_out);
endmodule
