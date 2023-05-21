.data
in_x: .space 1 # x[2:0]
in_sw_a: .space 1 # sw[7:0] a
in_sw_b: .space 1 # sw[7:0] b
out_led: .space 1 # A bit, 1 for led on, 0 for led off
out_seg_a: .space 1 # An integer denoting a
out_seg_b: .space 1 # An integer denoting b
out_seg_c: .space 1 # An integer denoting the result
.text
lb $s0,in_x
lb $s1,in_sw_a
lb $s2,in_sw_b
beq $s0,$zero,if_0
addi $s3,$s0,-1
beq $s3,$zero,if_1
addi $s3,$s3,-1
sb $s1,out_seg_a #3'b111
sb $s2,out_seg_b
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
sb $s1,out_seg_a
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
sb $s4,out_led
j end
if_1: #3'b001
sb $s1,out_seg_a
move $s4,$zero
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
sb $s4,out_led
j end
if_2: # 3'b010
nor $s3,$s1,$s2
sb $s3,out_seg_c
j end
if_3: # 3'b011
or $s3,$s1,$s2
sb $s3,out_seg_c
j end
if_4: # 3'b100
xor $s3,$s1,$s2
sb $s3,out_seg_c
j end
if_5: # 3'b101
sltu $s3,$s1,$s2
sb $s3,out_led
j end
if_6: # 3'b110
slt $s3,$s1,$s2
sb $s3,out_led
end:
