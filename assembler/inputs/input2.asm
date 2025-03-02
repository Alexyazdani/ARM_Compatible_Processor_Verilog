MOV R0, #0              // Base Address (Dmem[0])
MOV R1, #1              // Base Address (Dmem[1])
MOV R2, #0              // Offset
MOV R3, #0              // Offset
NOP
NOP
NOP
LDR R4, [R0, R2]        // Load R0+R2 into R4
LDR R5, [R1, R3]        // Load R1+R3 into R5
NOP
NOP
NOP
ADD R5, R5, R2