// R0 is loop counter for pop-operation
// start by decrementing
@R0
D=M
M=D-1
D=M
@POPEND
D;JLT // pop(0) outputs 0

// default set R2 to pop(0)=0
@R2
D=0
M=D

// default set R3 to pop(1)=1
@R3
D=1
M=D

@R0
D=M
@POPEND
D;JEQ // pop(1) outputs 1


(POPLOOP)
    // reset product storage bit for mult-op
    @R4
    D=0
    M=D

    // reset quotient storage bit for div-op
    @R5
    D=0
    M=D

    @5
    D=A
    @counter
    M=D

    (MULTLOOP) // perform multiply operation
        @R3
        D=M

        // destination
        @R4
        M=M+D

        @counter
        D=M
        M=D-1
        D=M
        @MULTLOOP
        D;JGT
        @MULTEND
        0;JMP
    (MULTEND)

    // set @5 to @4 / 2 
    @R5
    @divoutput
    D=0 // set output = 0
    M=D

    @R4 // input
    D=M
    @divinput
    M=D // input = R0
    @DIVEND
    D;JEQ

    @2 // divisor input
    D=A
    @divisor 
    M=D // divisor = R0
    @DIVEND
    D;JEQ // division by 0!

    (DIVLOOP)
        @divisor
        D=M

        @R4
        M=M-D // subtract divisor from input

        // @input
        D=M
        @DIVEND
        D;JLT

        @R5
        M=M+1

        @DIVLOOP
        0;JMP
    (DIVEND)
        
    // set @R6 to @R5
    @R5
    D=M
    @R6
    M=D
    
    // subtract @R6 by @R2
    @R2
    D=M
    @R6
    M=M-D
    
    // set @R2 to @R3
    @R3
    D=M
    @R2
    M=D
    // set @R3 to @R6
    @R6
    D=M
    @R3
    M=D

    // if popcounter == 0, end loop
    @R0
    D=M
    M=D-1
    D=M
    @POPLOOP
    D;JGT
    @POPEND
    0;JMP
    
(POPEND)

// set output variable to last output
@R3
D=M
@R1
M=D

// termination by infinite loop
(END)
    @END
    0;JMP