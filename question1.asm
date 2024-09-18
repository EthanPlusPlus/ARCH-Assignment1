.data
enterWav:   .asciiz "Enter a wave file name:\n"
enterBytes: .asciiz "Enter the file size (in bytes):\n"
hardDir:    .asciiz "/Users/ethan/Documents/UCT/second-year/CSC-S/Assignments/Repos/ARCH1/arch_assign_input/question1_input/q1_t1_in.wav"
            .align  2
dir:        .space  64
bytes:      .space  32
buffer:     .space  45

.text
            .globl  main
main:

    li      $v0,            4
    la      $a0,            enterWav
    syscall

    #jal     getdir

    li      $v0,            4
    la      $a0,            enterBytes
    syscall

    jal     getbytes


    li      $v0,            13                                                                                                              # system call for open file
    la      $a0,            hardDir                                                                                                         # board file name
    li      $a1,            0                                                                                                               # Open for reading
    li      $a2,            0
    syscall                                                                                                                                 # open a file (file descriptor returned in $v0)
    move    $s6,            $v0                                                                                                             # save the file descriptor

    jal     readFile
    jal     printBuffer
    jal     readBuffer

    li      $v0,            4
    sw      $t1,            buffer
    la      $a0,            buffer
    syscall

    # Close the file
    li      $v0,            16                                                                                                              # system call for close file
    move    $a0,            $s6                                                                                                             # file descriptor to close
    syscall                                                                                                                                 # close file


    j       exit

readBuffer:
    la      $t0,            buffer
    #add $t0, buffer, $zero
    lw      $t1,            4($t0)
    jr      $ra



printBuffer:
    li      $v0,            4
    la      $a0,            buffer
    syscall
    jr      $ra


readFile:
    li      $v0,            14                                                                                                              # system call for read from file
    move    $a0,            $s6                                                                                                             # file descriptor
    la      $a1,            buffer                                                                                                          # address of buffer to which to read
    li      $a2,            45                                                                                                              # hardcoded buffer length
    syscall
    jr      $ra


getbytes:                                                                                                                                   #asks for input bytes(integer), saves in bytes
    li      $v0,            5
    syscall
    move    $t0,            $v0
    sw      $t0,            bytes
    jr      $ra


getdir:
    li      $v0,            8
    la      $a0,            dir
    li      $a1,            64
    syscall
    jr      $ra

exit:
    addi    $v0,            $0,         10
    syscall

