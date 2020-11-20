// input
// divisor
// output

// set output = 0

// (LOOP)
// subtract divisor from input
// if input < 0, JMP (END)
// increment output by 1
// if input < divisor, JMP (END)

// terminate by inf loop

@R2
@output
D=0 // set output = 0
M=D

@R0 // input
D=M
@input
M=D // input = R0
@END
D;JEQ

@R1 // divisor input
D=M
@divisor 
M=D // divisor = R0
@END
D;JEQ // division by 0!

(LOOP)
    @divisor
    D=M

    @input
    M=M-D // subtract divisor from input

    // @input
    D=M
    @END
    D;JLT

    @output
    M=M+1

    @LOOP
    0;JMP

    
(END)
    @END
    0;JMP