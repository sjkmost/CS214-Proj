.data
in_x: .space 1 # x[2:0]
in_sw_a: .space 1 # sw[7:0] a
in_sw_b: .space 1 # sw[7:0] b
out_led: .space 1 # A bit, 1 for error
out_seg: .word # An integer denoting the result
out_seg_2: .word # remainder
stack_info: .space 10 # each byte is an element
.text
#test
li $s1,-127
sb $s1,in_sw_a
li $s1,126
sb $s1,in_sw_b
li $s1,5
sb $s1,in_x
#
lb $s0,in_x
lb $s1,in_sw_a
lb $s2,in_sw_b
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
div $s3,$s1,$s2
mul $s4,$s2,$s3
sub $s4,$s1,$s4
sw $s3,out_seg
sw $s4,out_seg_2
j end
if_0: # 3'b000
slt $t0,$s1,$zero
sb $t0,out_led
bne $t0,$zero,end
addi $t0,$s1,1
mul $t0,$t0,$s1
div $t0,$t0,2
sw $t0,out_seg
j end
positive:
j end
if_1: #3'b001
andi $s1,$s1,255
la $s3,stack_info
move $a0,$s1
jal sum_0
sw $v0,out_seg
sw $s3,out_seg_2
j end
if_2: # 3'b010
andi $s1,$s1,255
la $s3,stack_info
move $a0,$s1
jal sum_1
sw $v0,out_seg
j end
if_3: # 3'b011
andi $s1,$s1,255
la $s3,stack_info
move $a0,$s1
jal sum_2
sw $v0,out_seg
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
sw $s3,out_seg
sb $s4,out_led
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
sw $s3,out_seg
sb $s4,out_led
j end
if_6: # 3'b110
mul $s3,$s1,$s2
sw $s3,out_seg
j end
sum_0: # 3'b010
addi $sp,$sp,-8
sw $ra,4($sp)
sw $a0,($sp)
addi $s3,$s3,2
slti $t0,$a0,1
beq $t0,$zero,L0
addi $v0,$zero,1
addi $sp,$sp,8
addi $s3,$s3,2
jr $ra
L0:
addi $a0,$a0,-1
jal sum_0
lw $a0,($sp)
addi $s3,$s3,2
lw $ra,4($sp)
addi $sp,$sp,8
add $v0,$a0,$v0
jr $ra
sum_1: # 3'b010
addi $sp,$sp,-8
sw $ra,4($sp)
sw $a0,($sp)
sb $a0,($s3)
addi $s3,$s3,1
slti $t0,$a0,1
beq $t0,$zero,L1
addi $v0,$zero,1
addi $sp,$sp,8
jr $ra
L1:
addi $a0,$a0,-1
jal sum_1
lw $a0,($sp)
lw $ra,4($sp)
addi $sp,$sp,8
add $v0,$a0,$v0
jr $ra
sum_2: # 3'b011
addi $sp,$sp,-8
sw $ra,4($sp)
sw $a0,($sp)
slti $t0,$a0,1
beq $t0,$zero,L2
addi $v0,$zero,1
addi $sp,$sp,8
sb $a0,($s3)
addi $s3,$s3,1
jr $ra
L2:
addi $a0,$a0,-1
jal sum_2
lw $a0,($sp)
sb $a0,($s3)
addi $s3,$s3,1
lw $ra,4($sp)
addi $sp,$sp,8
add $v0,$a0,$v0
jr $ra
end:
