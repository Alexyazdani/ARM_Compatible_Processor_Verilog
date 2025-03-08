    MOV   R12, #0         // i = 0 (Outer loop counter)
    NOP
    NOP
    NOP
    B     CHECK_I         // Jump to check i condition

OUTER_LOOP:
    ADD   R12, R12, #1    // i++

CHECK_I:
    CMP   R12, #9         // if i == 9, end
    NOP
    BEQ   END

    MOV   R2, #0          // j = 0 (Inner loop counter)
    NOP
    NOP
    NOP

CHECK_J:
    CMP   R2, #8          // if j == 8, go to next i
    NOP
    BEQ   OUTER_LOOP

    ADD   R3, R2, #1      // Next index j+1
    NOP
    NOP
    NOP

    LDR   R4, [R2, #0]    // Load A[j]
    NOP
    NOP
    NOP
    LDR   R5, [R3, #0]    // Load A[j+1]
    NOP
    NOP
    NOP
    CMP   R5, R4          // Compare A[j+1] < A[j] ?
    NOP
    STRLT R4, [R3, #0]    // Swap A[j] and A[j+1] if needed
    STRLT R5, [R2, #0]  
    NOP
    NOP
    NOP
    ADD   R2, R2, #1      // j++
    B     CHECK_J         // Loop back for inner loop

END:
    NOP
    NOP
    NOP
    NOP

IDLE_LOOP:
    NOP
    NOP
    NOP
    B     IDLE_LOOP
