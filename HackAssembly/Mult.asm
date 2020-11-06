@R2
D=0
M=D

@R1 // counter input
D=M
@counter
M=D // counter = R1
@END
D;JEQ

@R0 // base input
D=M
@base 
M=D // base = R0

(LOOP)
    @base
    D=M

    @R2 // output -> product of base and counter
    M=M+D // increment output by base

    @counter
    D=M
    M=D-1
    D=M
    @LOOP
    D;JGT
    @END
    0;JMP
(END)
    @END
    0;JMP


    