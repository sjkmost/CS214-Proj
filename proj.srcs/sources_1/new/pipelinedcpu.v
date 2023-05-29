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
module pipelinedcpu(clk, reset, button, io_r1, io_r2, io_w_led,seg_en,seg_out,state,start_pg,rx,tx);
    input clk;
    input reset, button;
    input [2:0] io_r1;
    input [7:0] io_r2;
    output io_w_led;
    output [7:0] seg_en,seg_out;
    input start_pg;
    input rx;
    output tx;
    reg clock,memclock,uart_clk;
    reg [31:0] cnt;
    parameter period=10000; // 100Hz
    always@(posedge clk) begin
        if (cnt==(period>>1)-1) begin
            clock=~clock;
            cnt<=0;
        end
        else cnt<=cnt+1;
    end
    reg [31:0] cnt2;
    parameter period2=5; // 20MHz
    always@(posedge clk) begin
        if (cnt2==(period2>>1)-1) begin
            memclock=~memclock;
            cnt2<=0;
        end
        else cnt2<=cnt2+1;
    end
    reg [31:0] cnt3;
    parameter period3=10; // 10MHz
    always@(posedge clk) begin
        if (cnt3==(period3>>1)-1) begin
            uart_clk=~uart_clk;
            cnt3<=0;
        end
        else cnt3<=cnt3+1;
    end
    wire resetn;
    output [7:0] state;
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
    wire brance, prebrance;
    wire upg_clk_o;
    wire upg_wen_o;
    wire upg_done_o;
    wire [14:0] upg_adr_o;
    wire [31:0] upg_dat_o;
    reg upg_rst;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            upg_rst <= 1;
        end else begin
            upg_rst <= ~start_pg;
        end
    end
    assign resetn = ~reset & upg_rst; // resetn for cpu modules
    uart_bmpg_0 uart(
        .upg_clk_i(uart_clk), 
        .upg_rst_i(upg_rst), 
        .upg_rx_i(rx), 
        .upg_clk_o(upg_clk_o), 
        .upg_wen_o(upg_wen_o), 
        .upg_adr_o(upg_adr_o), 
        .upg_dat_o(upg_dat_o), 
        .upg_done_o(upg_done_o), 
        .upg_tx_o(tx));
    FSM2 fsm(clk, reset, button, state);
    pipepc prog_cnt (npc, wpcir, clock, resetn, pc);
    pipeif if_stage (memclock, pcsource, pc, bpc, da, jpc, npc, pc4, ins, 
                     upg_rst, upg_clk_o, upg_wen_o & ~upg_adr_o[14], upg_adr_o[13:0], upg_dat_o, upg_done_o);
    pipeir inst_reg (pc4, ins, wpcir, clock, resetn, dpc4, inst, brance, prebrance);
    pipeid id_stage (mwreg, mrn, ern, ewreg, em2reg, mm2reg, dpc4, inst,
                    wrn, wdi, ealu, malu, mmo, wwreg, clock, resetn,
                    bpc, jpc, pcsource, wpcir, dwreg, dm2reg, dwmem,
                    daluc, daluimm, da, db, dimm, drn, dshift, djal, state, brance, prebrance);
    pipedereg de_reg(dwreg, dm2reg, dwmem, daluc, daluimm, da, db, dimm,
                    drn, dshift, djal, dpc4, clock, resetn,
                    ewreg, em2reg, ewmem, ealuc, ealuimm, ea, eb, eimm,
                    ern0, eshift, ejal, epc4);
    pipeexe exe_stage(ealuc, ealuimm, ea, eb, eimm, eshift, ern0, epc4,
                    ejal, ern, ealu);
    pipeemreg em_reg(ewreg, em2reg, ewmem, ealu, eb, ern, clock, resetn,
                    mwreg, mm2reg, mwmem, malu, mb, mrn);
    pipemem mem_stage(state, mwmem, malu, mb, clock, memclock, io_r1, io_r2, io_w_led, io_w_seg1, io_w_seg2, io_w_seg3, mmo, 
                    upg_rst, upg_clk_o, upg_wen_o & upg_adr_o[14], upg_adr_o[13:0], upg_dat_o, upg_done_o);
    pipemwreg mw_reg(mwreg, mm2reg, mmo, malu, mrn, clock, resetn,
                    wwreg, wm2reg, wmo, walu, wrn);
    mux2x32 wb_stage(walu, wmo, wm2reg, wdi);
    seg_display sd(clk,1'b1,io_w_seg1,io_w_seg2,io_w_seg3,seg_en,seg_out);
endmodule
