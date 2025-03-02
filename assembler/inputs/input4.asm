    MOV R0 #10
    MOV R1 #10
    NOP
    NOP
    NOP
    CMP R0, R1
    NOP
    BEQ  LABEL_1
    B    LABEL_2
LABEL_1:
    ADD R2, R0, R1
    NOP
    NOP
    B    LABEL_3
LABEL_2:
    NOP
    B    LABEL_2
LABEL_3:
    NOP          // END PROGRAM