`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cun
// 
// Create Date: 2023/05/20 20:34:52
// Design Name: 
// Module Name: pipeidcu
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
module pipeidcu(mwreg, mrn, ern, ewreg, em2reg, mm2reg, rsrtequ, func, op, rs, rt,
                wreg, m2reg, wmem, aluc, regrt, aluimm, fwda, fwdb, nostall, sext,
                pcsource, shift, jal, state, prebrance);
    input mwreg, ewreg, em2reg, mm2reg, rsrtequ;
    input [4:0] mrn, ern, rs, rt;
    input [5:0] func, op;
    input [7:0] state; //the current state sign // state == 4 means CPU runs
    input prebrance;
    output wreg, m2reg, wmem, regrt, aluimm, sext, shift, jal;
    output [3:0] aluc;
    output [1:0] pcsource;
    output [1:0] fwda, fwdb; //the forwarding selection
    output nostall;
    reg [1:0] fwda, fwdb;
    wire r_type, i_add, i_sub, i_and, i_or, i_nor, i_xor, i_sll, i_srl, i_sra, i_jr, i_div, i_mul, i_slt, i_sltu;
    wire i_addi, i_andi, i_ori, i_xori, i_lw, i_sw, i_beq, i_bne, i_lui, i_j, i_jal, i_slti;
    and(r_type, ~op[5], ~op[4], ~op[3], ~op[2], ~op[1], ~op[0]);
    and(i_add, r_type,  func[5], ~func[4], ~func[3], ~func[2], ~func[1], ~func[0]);
    and(i_sub, r_type,  func[5], ~func[4], ~func[3], ~func[2],  func[1], ~func[0]);
    and(i_and, r_type,  func[5], ~func[4], ~func[3],  func[2], ~func[1], ~func[0]);
    and(i_or , r_type,  func[5], ~func[4], ~func[3],  func[2], ~func[1],  func[0]);
    and(i_nor, r_type,  func[5], ~func[4], ~func[3],  func[2],  func[1],  func[0]);
    and(i_xor, r_type,  func[5], ~func[4], ~func[3],  func[2],  func[1], ~func[0]);
    and(i_sll, r_type, ~func[5], ~func[4], ~func[3], ~func[2], ~func[1], ~func[0]);
    and(i_srl, r_type, ~func[5], ~func[4], ~func[3], ~func[2],  func[1], ~func[0]);
    and(i_sra, r_type, ~func[5], ~func[4], ~func[3], ~func[2],  func[1],  func[0]);
    and(i_jr , r_type, ~func[5], ~func[4],  func[3], ~func[2], ~func[1], ~func[0]);
    and(i_div, r_type, ~func[5], ~func[4], ~func[3],  func[2], ~func[1], ~func[0]);
    and(i_mul, r_type, ~func[5], ~func[4], ~func[3],  func[2],  func[1],  func[0]);
    and(i_slt, r_type,  func[5], ~func[4],  func[3], ~func[2],  func[1], ~func[0]);
    and(i_sltu,r_type,  func[5], ~func[4],  func[3], ~func[2],  func[1],  func[0]);
    and(i_addi, ~op[5],  ~op[4],   op[3],  ~op[2],  ~op[1], ~op[0]);
    and(i_andi, ~op[5],  ~op[4],   op[3],   op[2],  ~op[1], ~op[0]);
    and(i_ori , ~op[5],  ~op[4],   op[3],   op[2],  ~op[1],  op[0]);
    and(i_xori, ~op[5],  ~op[4],   op[3],   op[2],   op[1], ~op[0]);
    and(i_lw  ,  op[5],  ~op[4],  ~op[3],  ~op[2],   op[1],  op[0]);
    and(i_sw  ,  op[5],  ~op[4],   op[3],  ~op[2],   op[1],  op[0]);
    and(i_beq , ~op[5],  ~op[4],  ~op[3],   op[2],  ~op[1], ~op[0], ~prebrance);
    and(i_bne , ~op[5],  ~op[4],  ~op[3],   op[2],  ~op[1],  op[0], ~prebrance);
    and(i_lui , ~op[5],  ~op[4],   op[3],   op[2],   op[1],  op[0]);
    and(i_j   , ~op[5],  ~op[4],  ~op[3],  ~op[2],   op[1], ~op[0], ~prebrance);
    and(i_jal , ~op[5],  ~op[4],  ~op[3],  ~op[2],   op[1],  op[0], ~prebrance);
    and(i_slti, ~op[5],  ~op[4],   op[3],  ~op[2],   op[1], ~op[0]);
    wire i_rs = i_add | i_sub | i_and | i_or | i_nor | i_xor | i_jr  | i_mul | i_div | i_slt  | i_sltu | i_addi |
                i_andi| i_ori | i_xori| i_lw | i_sw  | i_beq | i_bne | i_slti;
    wire i_rt = i_add | i_sub | i_and | i_or | i_nor | i_xor | i_mul | i_div | i_slt | i_sltu | i_sll  | i_srl  |
                i_sra | i_sw  | i_beq | i_bne;
    assign nostall = (~(ewreg & em2reg & (ern != 0) & (i_rs & (ern == rs) | i_rt & (ern == rt) ) ) ) & (state == 4); // state == 4 means CPU runs
    
    always @(ewreg or mwreg or ern or mrn or em2reg or mm2reg or rs or rt) begin
        fwda = 2'b00; // default: no hazards
        if(ewreg & (ern != 0) & (ern == rs) & ~em2reg) begin
            fwda = 2'b01; // exe_alu
        end else begin
            if (mwreg & (mrn != 0) & (mrn == rs) & ~mm2reg) begin
                fwda = 2'b10; //mem_alu
            end else begin
                if(mwreg & (mrn != 0) & (mrn == rs) &  mm2reg) begin
                    fwda = 2'b11; //mem_lw
                end
            end
        end
        fwdb = 2'b00; // default: no hazards
        if(ewreg & (ern != 0) & (ern == rt) & ~em2reg) begin
            fwdb = 2'b01; // exe_alu
        end else begin
            if (mwreg & (mrn != 0) & (mrn == rt) & ~mm2reg) begin
                fwdb = 2'b10; //mem_alu
            end else begin
                if(mwreg & (mrn != 0) & (mrn == rt) &  mm2reg) begin
                    fwdb = 2'b11; //mem_lw
                end
            end
        end
    end

    assign wreg    = (i_add | i_sub | i_and | i_or  | i_nor | i_xor | i_sll | i_mul | i_div |
                      i_slt | i_sltu| i_srl | i_sra | i_addi| i_andi| i_ori | i_xori|
                      i_lw  | i_lui | i_jal | i_slti) & nostall & ~prebrance; // if write register
    assign regrt   =  i_addi| i_andi| i_ori | i_xori| i_lw  | i_lui | i_slti; // if rt is target register
    assign jal     =  i_jal;
    assign m2reg   =  i_lw; // if choose register data
    assign shift   =  i_sll | i_srl | i_sra;
    assign aluimm  =  i_addi| i_andi| i_ori | i_xori| i_lw  | i_lui | i_sw  | i_slti;
    assign sext    =  i_addi| i_lw  | i_sw  | i_beq | i_bne | i_slti;
    assign aluc[3] =  i_sra | i_div | i_mul | i_slt | i_sltu| i_slti| i_nor;
    assign aluc[2] =  i_sub | i_or  | i_nor | i_div | i_srl | i_sra | i_sltu| i_ori | i_lui;
    assign aluc[1] =  i_xor | i_sll | i_srl | i_sra | i_xori| i_beq | i_slt | i_sltu|
                      i_bne | i_lui | i_slti;
    assign aluc[0] =  i_and | i_or  | i_nor | i_sll | i_srl | i_sra | i_andi|
                      i_ori;
    assign wmem    =  i_sw & nostall & ~prebrance;
    assign pcsource[1] = i_jr | i_j | i_jal;
    assign pcsource[0] = i_beq & rsrtequ | i_bne & ~rsrtequ | i_j | i_jal;


endmodule