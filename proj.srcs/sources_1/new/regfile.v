`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/20 21:41:32
// Design Name: 
// Module Name: regfile
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


module regfile(rna, rnb, d, wn, we, clk, clrn, qa, qb);
    input [5:0] rna, rnb, wn;
    input [31:0] d;
    input we, clk, clrn;
    output [31:0] qa, qb;
    reg [31:0] register [1:31];

    assign qa = rna ? register[rna] : 0;
    assign qb = rnb ? register[rnb] : 0;

    always @(posedge clk or negedge clrn) begin
        if (!clrn) begin
            integer i;
            for (i = 1; i < 32; i = i + 1) begin
                register[i] <= 0;
            end
        end else if (we && wn) begin
            register[wn] <= d;
        end
    end
endmodule
