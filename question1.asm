.data
enterWav:       .asciiz "Enter a wave file name:\n"
enterBytes:     .asciiz "Enter the file size (in bytes):\n"
infoMsg:        .asciiz "Information about the wave file:\n================================\n"
hardDir:        .asciiz "/Users/ethan/Documents/UCT/second-year/CSC-S/Assignments/Repos/ARCH1/arch_assign_input/question1_input/q1_t1_in.wav"
nextLine:       .asciiz "\n"
channelsMsg:    .asciiz "Number of channels: "
sampleMsg:      .asciiz "Sample rate: "
bytesMsg:       .asciiz "Byte rate: "
bitsMsg:        .asciiz "Bits per sample: "
                .align  256
dir:            .space  256
    #bytes:          .space  10000000
buffer:         .space  45

.text
                .globl  main
main:

    li      $v0,                4
    la      $a0,                enterWav
    syscall

    jal     getdir

    li      $v0,                4
    la      $a0,                enterBytes
    syscall

    jal     getbytes


    jal     openfile
    jal     readFile


    la      $s0,                buffer

    li      $v0,                4
    la      $a0,                infoMsg
    syscall

    jal     loadChannels
    jal     loadSampleRate
    jal     loadByteRate
    jal     loadBitsPerSample

    jal     printChannels
    jal     printSample
    jal     printByte
    jal     printBits

    # Close the file
    li      $v0,                16                                                                                                              # system call for close file
    move    $a0,                $s6                                                                                                             # file descriptor to close
    syscall                                                                                                                                     # close file


    j       exit



loadChannels:                                                                                                                                   # $s0
    lh      $s1,                22($s0)
    jr      $ra

loadSampleRate:
    lw      $s2,                24($s0)
    jr      $ra

loadByteRate:
    lw      $s3,                28($s0)
    jr      $ra

loadBitsPerSample:
    lh      $s4,                34($s0)
    jr      $ra



printChannels:
    li      $v0,                4
    la      $a0,                channelsMsg
    syscall
    li      $v0,                1
    move    $a0,                $s1
    syscall
    jal     printNextLine

printSample:
    li      $v0,                4
    la      $a0,                sampleMsg
    syscall
    li      $v0,                1
    move    $a0,                $s2
    syscall
    jal     printNextLine

printByte:
    li      $v0,                4
    la      $a0,                bytesMsg
    syscall
    li      $v0,                1
    move    $a0,                $s3
    syscall
    jal     printNextLine

printBits:
    li      $v0,                4
    la      $a0,                bitsMsg
    syscall
    li      $v0,                1
    move    $a0,                $s4
    syscall
    j       exit

printNextLine:
    li      $v0,                4
    la      $a0,                nextLine
    syscall
    jr      $ra



readFile:
    li      $v0,                14                                                                                                              # system call for read from file
    move    $a0,                $s6                                                                                                             # file descriptor
    la      $a1,                buffer                                                                                                          # address of buffer to which to read
    li      $a2,                45                                                                                                              # hardcoded buffer length
    syscall
    jr      $ra


addNull:
    la      $t0,                dir
    


getbytes:                                                                                                                                       #asks for input bytes(integer), saves in bytes
    li      $v0,                5
    syscall
    #move    $t0,                $v0
    #sw      $t0,                bytes
    jr      $ra


getdir:
    li      $v0,                8
    la      $a0,                dir
    li      $a1,                526
    syscall
    jr      $ra

openfile:
    li      $v0,                13                                                                                                              # system call for open file
    la      $a0,                dir                                                                                                             # board file name
    li      $a1,                0                                                                                                               # Open for reading
    li      $a2,                0
    syscall                                                                                                                                     # open a file (file descriptor returned in $v0)
    move    $s6,                $v0
    jr      $ra

exit:
    addi    $v0,                $0,             10
    syscall

