// R0 is loop counter for pop-operation
// start by decrementing
@R0
D=M
M=D-1
D=M
@POPEND
D;JLT // pop(0) outputs 0

// default set popnm2 to pop(0)=0
@popnm2
D=0
M=D

// default set popnm1 to pop(1)=1
@popnm1
D=1
M=D

@R0
D=M
@POPEND
D;JEQ // pop(1) outputs 1


(POPLOOP)
    // reset product storage bit for mult-op
    @product
    D=0
    M=D

    // reset quotient storage bit for div-op
    @quotient
    D=0
    M=D

    @5
    D=A
    @
    M=D

    (MULTLOOP) // perform multiply operation
        @popnm1
        D=M

        // destination
        @product
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
    @quotient
    // @divoutput
    D=0 // set output = 0
    // M=D

    @product // input
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

        @product
        M=M-D // subtract divisor from input

        // @input
        D=M
        @DIVEND
        D;JLT

        @quotient
        M=M+1

        @DIVLOOP
        0;JMP
    (DIVEND)
        
    // set @result to @quotient
    @quotient
    D=M
    @result
    M=D
    
    // subtract @result by @popnm2
    @popnm2
    D=M
    @result
    M=M-D
    
    // set @popnm2 to @popnm1
    @popnm1
    D=M
    @popnm2
    M=D
    // set @popnm1 to @result
    @result
    D=M
    @popnm1
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
@popnm1
D=M
@R1
M=D

// termination by infinite loop
(END)
    @END
    0;JMP