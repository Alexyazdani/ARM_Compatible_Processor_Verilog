# Preliminary Design Goals:
- 32-bit Armv7-A architecture
- Machine code will be stored/read from Instruction Cache
- Array to be sorted is a fixed size (currently 10 8-bit elements)
- Array to be sorted's memory region will be updated in place, and stored/written in Data Cache
- Assumption is that the unsorted array contains valid elements, that is, it is okay to read/write to that address space
- We need to implement the following ARM standard condition flags/registers (each is a single bit, 4-bits total):
  - N: Negative condition flag. Set to 1 if the result of the last flag-setting instruction was negative.
  - Z: Zero condition flag. Set to 1 if the result of the last flag-setting instruction was zero, and to 0 otherwise. A result of zero often indicates an equal result from a comparison.
  - V: Overflow condition flag. Set to 1 if the last flag-setting instruction resulted in an overflow condition, for example a signed overflow on an addition.
  - NOTE: C is another flag (carry), we have no need for it as of now.

# ARM Subset: Instruction Types for Reference
<img width="762" alt="image" src="https://github.com/user-attachments/assets/b433b4a1-a688-44ea-ba48-a3c32b30709f" />

# ARM Subset: Condition Codes to Implement
<img width="739" alt="image" src="https://github.com/user-attachments/assets/58e63a16-5b61-4e81-a6b9-488b0ad3ff95" />

# 5-Stage Pipeline Design
![image](https://github.com/user-attachments/assets/b2ca7c7e-a9e5-43a9-b6cb-da3cb33c9cdd)

# ARM Subset: List of Instructions to Implement:
## Data Processing Instructions:
<img width="717" alt="image" src="https://github.com/user-attachments/assets/9c51c7c0-888c-49bd-8860-71c18310a6ef" />

- MOV
  - Move (immediate) writes an immediate value to the destination register.
  - Cond: = 1110 (always execute)
  - OpCode: = 1101
  - Rd: = Op2
  - All other fields: = 0
- ADD
  - Add (immediate) adds an immediate value to a register value, and writes the result to the destination register.
  - Cond: = 1110 (always execute)
  - OpCode: = 0100
  - Rd:= Op1 + Op2
  - All other fields: = 0
- CMP
  - Compare (immediate) subtracts an immediate value from a register value. It updates the condition flags based on the result,
    and discards the result.
  - Cond: = 1110 (always execute)
  - OpCode: = 1010
  - Set condition codes on Op1 - Op2
  - S: = 1
  - Result is not written to register, flags are set:
  - N: Set to 1 when the result of the operation is negative, cleared to 0 otherwise.
  - Z: Set to 1 when the result of the operation is zero, cleared to 0 otherwise.
  - V: Set to 1 when the operation causes overflow, cleared to 0 otherwise.
  - All other fields: = 0

## Branching Instructions

<img width="740" alt="image" src="https://github.com/user-attachments/assets/18e67a80-e6ff-40da-993c-1e1d1695abba" />

- B
  -  Branch causes a branch to a target address.
  -  Cond: = 1110 (always)
  -  L: = 0
  -  offset: = Program counter to branch
- BEQ
  -  If equal: Branch causes a branch to a target address.
  -  Cond: = 0000 (equal)
  -  L: = 0
  -  offset: = Program counter to branch
- BNE
  -  If not equal: Branch causes a branch to a target address.
  -  Cond: = 0001 (not equal)
  -  L: = 0
  -  offset: = Program counter to branch
- BHI
  -  If unsigned higher: Branch causes a branch to a target address.
  -  Cond: = 1000 (unsigned higher)
  -  L: = 0
  -  offset: = Program counter to branch
    
## Single Data Transfer

<img width="717" alt="image" src="https://github.com/user-attachments/assets/72030d5b-6a45-4f60-b33a-1201eb93a5a0" />

- LDR
  - Load Register (immediate) calculates an address from a base register value and an immediate offset, loads a word from memory, and writes it to a register.
  - NOTE: We will be using register base, offsets and shifting, e.g:
    - `LDR R1, [R2, R3, LSL#2] ; Load R1 from contents of R2+R3*4`
  - Cond: = 1110 (always execute)
  - I: = 1
  - L: = 1
  - Rn: = Base Register Contents
  - Shift: = Shift Value
  - Offset: = Offset Register Contents
- STRLT
  - If signed less than: Store Register (immediate) calculates an address from a base register value and an immediate offset, and stores a word from a register to memory.
  - NOTE: We will be using register base, offsets and shifting, e.g:
    - `STRGT R1, [R2, R3, LSL#2] ; Store contents of R1 into R2+R3*4`
  - Cond: = 1100 (execute only when Z clear AND (N equals V))
  - I: = 1
  - L: = 0
  - Rn: = Base Register Contents
  - Shift: = Shift Value
  - Offset: = Offset Register Contents

## Misc.
- NOP
  - 11101100000000000000000000000000

# Build Notes:
- Apple Clang 12.0.0
- ASM reference: [https://godbolt.org/z/vYjbrcxbc](https://godbolt.org/z/rT15qrj5s)
