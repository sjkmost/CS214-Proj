`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cun
// 
// Create Date: 2023/05/20 20:34:52
// Design Name: 
// Module Name: pipepc
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
module pipepc(npc, wpc, clk, clrn, pc);
    input [31:0] npc;
    input wpc, clk, clrn;
    output[31:0] pc;
    dffe32 program_counter (npc, clk, clrn, wpc,  pc);

endmodule