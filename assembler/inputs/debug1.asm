    MOV     R0, #0      // Base address of DMEM
    MOV     R1, #1
    MOV     R2, #2
    MOV     R3, #3
    MOV     R4, #4
    MOV     R5, #5
    MOV     R6, #6
    MOV     R7, #7
    MOV     R8, #8
    MOV     R9, #9

    NOP
    NOP
    NOP

    // Write to DMEM
    STR     R1, [R0]  
    ADD     R0, R0, #1
    NOP
    NOP
    NOP

    STR     R2, [R0]  
    ADD     R0, R0, #1
    NOP
    NOP
    NOP

    STR     R3, [R0]  
    ADD     R0, R0, #1
    NOP
    NOP
    NOP

    STR     R4, [R0]  
    ADD     R0, R0, #1
    NOP
    NOP
    NOP

    STR     R5, [R0]  
    ADD     R0, R0, #1
    NOP
    NOP
    NOP

    STR     R6, [R0]  
    ADD     R0, R0, #1
    NOP
    NOP
    NOP

    STR     R7, [R0]  
    ADD     R0, R0, #1
    NOP
    NOP
    NOP

    STR     R8, [R0]  
    ADD     R0, R0, #1
    NOP
    NOP
    NOP

    STR     R9, [R0]  

    // Reset base address
    MOV     R0, #0  
    NOP
    NOP
    NOP

    // Read from DMEM
    LDR     R10, [R0, #0]  
    LDR     R10, [R0, #0]  
    NOP
    NOP
    NOP

    LDR     R11, [R0, #1]  
    LDR     R11, [R0, #1]  
    NOP
    NOP
    NOP

    LDR     R12, [R0, #2]  
    LDR     R12, [R0, #2]  
    NOP
    NOP
    NOP

    LDR     R13, [R0, #3]  
    LDR     R13, [R0, #3]  
    NOP
    NOP
    NOP

    LDR     R14, [R0, #4]  
    LDR     R14, [R0, #4]  
    NOP
    NOP
    NOP

    LDR     R15, [R0, #5]  
    LDR     R15, [R0, #5]  
    NOP
    NOP
    NOP
    STR R2, #0
    STR R2, #1
    STR R2, #2
    STR R2, #3
    STR R2, #4
    STR R5, #5
    STR R5, #6
    STR R5, #7
    STR R5, #8
    STR R5, #9
    NOP
loop_1:
    NOP
    NOP
    NOP
    b loop_1