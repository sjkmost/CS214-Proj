.data
in_x: .word 0 # x[2:0]
in_sw_a: .word 0 # sw[7:0] a
in_sw_b: .word 0 # sw[7:0] b
out_led: .word 0 # A bit, 1 for error
out_seg: .word 0 # An integer denoting the result
out_seg_2: .word 0 # remainder
stack_info: .space 256 # each byte is an element
.text
start:
sw $zero,out_led($zero)
sw $zero,out_seg($zero)
sw $zero,out_seg_2($zero)
lw $s0,in_x($zero)
lw $s1,in_sw_a($zero)
lw $s2,in_sw_b($zero)
beq $s0,$zero,if_0
addi $s3,$s0,-1
beq $s3,$zero,if_1
addi $s3,$s3,-1
beq $s3,$zero,if_2
addi $s3,$s3,-1
beq $s3,$zero,if_3
addi $s3,$s3,-1
beq $s3,$zero,if_4
addi $s3,$s3,-1
beq $s3,$zero,if_5
addi $s3,$s3,-1
beq $s3,$zero,if_6
#3'b111
andi $t0,$s1,128
beq $t0,$zero,label_pos_1_1
lui $t0,-1
or $s1,$s1,$t0
ori $s1,$s1,-256
label_pos_1_1:
andi $t0,$s2,128
beq $t0,$zero,label_pos_2_1
lui $t0,-1
or $s2,$s2,$t0
ori $s2,$s2,-256
label_pos_2_1:
sllv $s3,$s2,$s1
srav $s4,$s2,$s3
sub $s4,$s1,$s4
sw $s3,out_seg($zero)
sw $s4,out_seg_2($zero)
j end
if_0: # 3'b000
srl $t0,$s1,7
sw $t0,out_led($zero)
bne $t0,$zero,end
addi $t0,$s1,1
srav $t0,$t0,$s1
srl $t0,$t0,1
sw $t0,out_seg($zero)
j end
positive:
j end
if_1: #3'b001
andi $a0,$s1,255
or $s3,$zero,$zero
jal sum_0
sw $v0,out_seg($zero)
sw $s3,out_seg_2($zero)
j end
if_2: # 3'b010
andi $a0,$s1,255
or $s3,$zero,$zero
jal sum_1
sw $v0,out_seg($zero)
j end
if_3: # 3'b011
andi $a0,$s1,255
or $s3,$zero,$zero
jal sum_2
sw $v0,out_seg($zero)
j end
if_4: # 3'b100
add $s3,$s1,$s2
srl $s4,$s1,7 # sign of s1
srl $s5,$s2,7 # sign of s2
srl $s6,$s3,7 # sign of s3
andi $s4,$s4,1
andi $s5,$s5,1
andi $s6,$s6,1
xor $s5,$s4,$s5
andi $s3,$s3,255
xor $s4,$s4,$s6
xori $s5,$s5,1
and $s4,$s4,$s5
andi $t0,$s3,128
beq $t0,$zero,label_pos_1
lui $t0,-1
or $s3,$s3,$t0
ori $s3,$s3,-256
label_pos_1:
sw $s3,out_seg($zero)
sw $s4,out_led($zero)
j end
if_5: # 3'b101
sub $s3,$s1,$s2
srl $s4,$s1,7 # sign of s1
srl $s5,$s2,7 # sign of s2
srl $s6,$s3,7 # sign of s3
andi $s4,$s4,1
andi $s5,$s5,1
andi $s6,$s6,1
xor $s5,$s4,$s5
andi $s3,$s3,255
xor $s4,$s4,$s6
and $s4,$s4,$s5
andi $t0,$s3,128
beq $t0,$zero,label_pos_2
lui $t0,-1
or $s3,$s3,$t0
ori $s3,$s3,-256
label_pos_2:
sw $s3,out_seg($zero)
sw $s4,out_led($zero)
j end
if_6: # 3'b110
srav $s3,$s1,$s2
sw $s3,out_seg($zero)
j end
sum_0: # 3'b010
addi $sp,$sp,-8
sw $ra,4($sp)
sw $a0,0($sp)
addi $s3,$s3,2
slti $t0,$a0,1
beq $t0,$zero,L0
or $v0,$zero,$zero
addi $sp,$sp,8
addi $s3,$s3,2
jr $ra
L0:
addi $a0,$a0,-1
jal sum_0
lw $a0,0($sp)
addi $s3,$s3,2
lw $ra,4($sp)
addi $sp,$sp,8
add $v0,$a0,$v0
jr $ra
sum_1: # 3'b010
addi $sp,$sp,-8
sw $ra,4($sp)
sw $a0,0($sp)
sw $a0,stack_info($s3)
addi $s3,$s3,4
slti $t0,$a0,1
beq $t0,$zero,L1
or $v0,$zero,$zero
addi $sp,$sp,8
jr $ra
L1:
addi $a0,$a0,-1
jal sum_1
lw $a0,0($sp)
lw $ra,4($sp)
addi $sp,$sp,8
add $v0,$a0,$v0
jr $ra
sum_2: # 3'b011
addi $sp,$sp,-8
sw $ra,4($sp)
sw $a0,0($sp)
slti $t0,$a0,1
beq $t0,$zero,L2
or $v0,$zero,$zero
addi $sp,$sp,8
sw $a0,stack_info($s3)
addi $s3,$s3,4
jr $ra
L2:
addi $a0,$a0,-1
jal sum_2
lw $a0,0($sp)
sw $a0,stack_info($s3)
addi $s3,$s3,4
lw $ra,4($sp)
addi $sp,$sp,8
add $v0,$a0,$v0
jr $ra
end:
j end
