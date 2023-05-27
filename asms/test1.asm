.data
in_x: .word 0 # x[2:0]
in_sw_a: .word 0 # sw[7:0] a
in_sw_b: .word 0 # sw[7:0] b
out_led: .word 0 # A bit, 1 for led on, 0 for led off
out_seg_c: .word 0 # An integer denoting the result
out_seg_a: .word 0 # An integer denoting a
out_seg_b: .word 0 # An integer denoting b
.text
start:
sw $zero,out_seg_a($zero)
sw $zero,out_seg_b($zero)
sw $zero,out_seg_c($zero)
sw $zero,out_led($zero)
lw $s0,in_x($zero)
lw $s1,in_sw_a($zero)
andi $t0,$s1,128
beq $t0,$zero,label_pos_1
lui $t0,-1
or $s1,$s1,$t0
ori $s1,$s1,-256
label_pos_1:
lw $s2,in_sw_b($zero)
andi $t0,$s2,128
beq $t0,$zero,label_pos_2
lui $t0,-1
or $s2,$s2,$t0
ori $s2,$s2,-256
label_pos_2:
beq $s0,$zero,if_0
addi $s3,$s0,-1
beq $s3,$zero,if_1
addi $s3,$s3,-1
sw $s1,out_seg_a($zero) #3'b111
sw $s2,out_seg_b($zero)
beq $s3,$zero,if_2
addi $s3,$s3,-1
beq $s3,$zero,if_3
addi $s3,$s3,-1
beq $s3,$zero,if_4
addi $s3,$s3,-1
beq $s3,$zero,if_5
addi $s3,$s3,-1
beq $s3,$zero,if_6
j end
if_0: # 3'b000
sw $s1,out_seg_a($zero)
ori $s4,$zero,1
andi $s3,$s1,1 # bit0
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit1
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit2
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit3
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit4
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit5
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit6
xor $s4,$s4,$s3
sw $s4,out_led($zero)
j end
if_1: #3'b001
sw $s1,out_seg_a($zero)
or $s4,$zero,$zero
andi $s3,$s1,1 # bit0
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit1
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit2
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit3
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit4
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit5
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit6
srl $s1,$s1,1
xor $s4,$s4,$s3
andi $s3,$s1,1 # bit7
xor $s4,$s4,$s3
sw $s4,out_led($zero)
j end
if_2: # 3'b010
nor $s3,$s1,$s2
sw $s3,out_seg_c($zero)
j end
if_3: # 3'b011
or $s3,$s1,$s2
sw $s3,out_seg_c($zero)
j end
if_4: # 3'b100
xor $s3,$s1,$s2
sw $s3,out_seg_c($zero)
j end
if_5: # 3'b101
sltu $s3,$s1,$s2
sw $s3,out_led($zero)
j end
if_6: # 3'b110
slt $s3,$s1,$s2
sw $s3,out_led($zero)
end:
j end
