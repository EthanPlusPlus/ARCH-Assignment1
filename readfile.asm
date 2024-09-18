.data
	url: .asciiz "/Users/H.txt"
	buffer: .space 45

.text
.globl main

main:

	li $v0, 13
	la $a0, url
	li $a1, 0
	li $a2, 0
	syscall
	
	move $t0, $v0

	li $v0, 14
	move $a0, $t0
	la $a1, buffer
	li $a2, 45
	syscall

	li $v0, 4
	la $a0, buffer
	syscall