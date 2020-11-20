// default set R2 to pop(0)=0
@R2
D=0
@nm2
M=D

// default set R3 to pop(1)=1
@R3
D=1
@nm1
M=D

// loop counter for pop-operation
@R0
D=M
@popcounter

(POPLOOP)
    // decrement logic for pop loop counter
    @popcounter
    D=M
    M=D-1
    D=M
    @POPLOOP
    D;JGT
    @POPEND
    0;JMP

    
    // reset product storage bit for mult-op
    @R4
    D=0
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
        @LOOP
        D;JGT
        @MULTEND
        0;JMP
    (MULTEND)

    // set @5 to @4 / 2 
    // *            *
    // * DIV(@4, 2) *
    // *            *

    // set @6 to @5
    @R5
    D=M
    @R6
    M=D

    M=D-3 // subtract @6 by 3
    
    // set @2 to @3
    @nm1
    D=M
    @nm2
    M=D
    // set @3 to @
    @R6
    D=M
    @nm1
    M=D
    // if popcounter == 0, end loop
    @popcounter
    @POPLOOP
    D;JGT
    @POPEND
    0;JMP
(POPEND)

// set output variable to last output
@nm1
D=M
@R1
M=D

// termination by infinite loop
(END)
    @END
    0;JMP