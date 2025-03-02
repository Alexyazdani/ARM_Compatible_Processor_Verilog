    mov   r12, #0         // Init “i” to zero
    nop
    nop
    nop
    b     .LBB0_2         // Branch to label
.LBB0_1:
    cmp   r12, #9         // Compare “i” and value 9
    nop
    beq   .LBB0_5         // Branch to label (END), if equal (i==9)
.LBB0_2:
    mov   r2, r12         // Save R12 (current, “i”) into R2
    nop
    nop
    nop
    add   r12, r12, #1    // i++
    cmp   r2, #8          // Compare R2 and value 7
    nop
    bhi   .LBB0_1         // Branch to label, if unsigned higher
    mov   r3, r2          // Update “j” (next) with i
    nop
    nop
    nop
.LBB0_4:
    add   r9, r3, #1      // Used as offset into next index
    nop 
    nop
    nop
    ldr   r5, [r3, #1]    // Load R5 with R3+1 (next index)
    ldr   r4, [r2, #0]    // Load R4 with R2+0 (current index)
    nop
    nop
    nop
    cmp   r5, r4          // Compare next and current (used for SWAP)
    nop
    strlt r4, r9          // Store R4 into R3+1, if R5 < R4 (signed)
    strlt r5, r2          // Store R5 into R2+0, if R5 < R4 (signed)
    cmp   r3, #8          // Compare “j” with value 8
    add   r3, r3, #1      // j++
    nop
    mov r10, r9   // Store j into R10 for debugging
    mov r11, r2   // Store i into R11 for debugging
    bne   .LBB0_4         // Branch to label, if not equal (j!=8)
    b     .LBB0_1         // Branch to label
.LBB0_5:                  // PROGRAM END
    nop
    nop
    nop
    nop
.LBB06:
    nop
    nop
    nop
    b .LBB06