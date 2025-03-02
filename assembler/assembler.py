r"""
Support List:
    Data Processing Instructions:
        - SUB
        - ADD
        - CMP
        - MOV
    Data Transfer Instructions:
        - LDR
        - STRLT
    Branch Instructions:
        - B
        - BEQ
        - BNE
        - BHI
    No Operation Instruction:
        - NOP
"""

import os
import re

class Instruction:
    def __init__(self, instr):
        self.instr = instr.split("//")[0].strip()
        self.fields = self.instr.split()
        self.mnemonic = self.fields[0].upper()
        self.process_instruction()

    def __repr__(self):
        return f"Instruction: {self.instr}\nType: {self.instr_type}\nOpcode: {self.opcode}\n"

    def process_instruction(self):
        if not self.fields:
            self.instr_type = None

        if self.mnemonic in {"MOV", "CMP", "ADD", "SUB"}:       # Data Processing Instructions
            self.instr_type = "00"
            self.cond = "1110"
            if self.mnemonic == "SUB":
                if self.fields[3][0] == "#":
                    self.I = "1"
                else:
                    self.I = "0"
                self.opcode = "0010"
                self.S = "0"
                self.Rd = str(bin(int(self.fields[1][1:].replace(",", "")))[2:].zfill(4))
                self.Rn = str(bin(int(self.fields[2][1:].replace(",", "")))[2:].zfill(4))
                self.Op2 = str(bin(int(self.fields[3][1:].replace(",", "")))[2:].zfill(12))
            elif self.mnemonic == "ADD":
                if self.fields[3][0] == "#":
                    self.I = "1"
                else:
                    self.I = "0"
                self.opcode = "0100"
                self.S = "0"
                self.Rd = str(bin(int(self.fields[1][1:].replace(",", "")))[2:].zfill(4))
                self.Rn = str(bin(int(self.fields[2][1:].replace(",", "")))[2:].zfill(4))
                self.Op2 = str(bin(int(self.fields[3][1:].replace(",", "")))[2:].zfill(12))
            elif self.mnemonic == "CMP":
                if self.fields[2][0] == "#":
                    self.I = "1"
                else:
                    self.I = "0"
                self.opcode = "1010"
                self.S = "1"
                self.Rn = str(bin(int(self.fields[1][1:].replace(",", "")))[2:].zfill(4))
                self.Rd = "0000"
                self.Op2 = str(bin(int(self.fields[2][1:].replace(",", "")))[2:].zfill(12))
            elif self.mnemonic == "MOV":
                if self.fields[2][0] == "#":
                    self.I = "1"
                else:
                    self.I = "0"
                self.opcode = "1101"
                self.S = "0"
                self.Rn = "0000"
                self.Rd = str(bin(int(self.fields[1][1:].replace(",", "")))[2:].zfill(4))
                self.Op2 = str(bin(int(self.fields[2][1:].replace(",", "")))[2:].zfill(12))
            self.binary = f"{self.cond}{self.instr_type}{self.I}{self.opcode}{self.S}{self.Rn}{self.Rd}{self.Op2}"

        elif self.mnemonic in {"LDR", "STRLT"}:          # Data Transfer Instructions
            self.instr_type = "01"
            if self.mnemonic == "LDR":
                self.cond = "1110"
                self.L = "1"
                self.Rd = str(bin(int(self.fields[1][1:].replace(",", "")))[2:].zfill(4))
                self.Rn = str(bin(int(self.fields[2].replace("[", "")[1:].replace(",", "")))[2:].zfill(4))
                if self.fields[3][0] == "#":
                    self.I = "1"
                else:
                    self.I = "0"
                self.Op2 = str(bin(int(self.fields[3].replace("]", "")[1:].replace(",", "")))[2:].zfill(12))
            elif self.mnemonic == "STRLT":
                self.cond = "1011"
                self.L = "0"
                self.Rd = "0000"
                self.Rn = str(bin(int(self.fields[1][1:].replace(",", "")))[2:].zfill(4))
                if self.fields[2][0] == "#":
                    self.I = "1"
                else:
                    self.I = "0"
                self.Op2 = str(bin(int(self.fields[2][1:].replace(",", "")))[2:].zfill(12))

            self.binary = f"{self.cond}{self.instr_type}{self.I}0000{self.L}{self.Rn}{self.Rd}{self.Op2}"

        elif self.mnemonic in {"B", "BEQ", "BNE", "BHI"}:       # Branch Instructions
            self.instr_type = "10"
            self.branch_target = str(bin(int(self.fields[1][1:].strip()))[2:].zfill(24))
            if self.mnemonic == "B":
                self.cond = "1110"
                self.link = 0
            elif self.mnemonic == "BEQ":
                self.cond = "0000"
                self.link = 0
            elif self.mnemonic == "BNE":
                self.cond = "0001"
                self.link = 0
            elif self.mnemonic == "BHI":
                self.cond = "1000"
                self.link = 0
            self.binary = f"{self.cond}{self.instr_type}1{self.link}{self.branch_target}"

        elif self.mnemonic == "NOP":                            # No Operation Instruction
            self.instr_type = "11"
            self.binary = "11101100000000000000000000000000"

        else:
            self.instr_type = None

def preprocess_assembly_file(input_filename):
    script_dir = os.path.dirname(os.path.abspath(__file__))
    input_filename = os.path.join(script_dir, input_filename)
    tmp_filename = os.path.join(script_dir, input_filename+"_tmp")
    if not os.path.exists(input_filename):
            return
    labels = {}
    Instructions = []
    with open(input_filename, "r") as infile:
        line_number = 0
        for line in infile:
            stripped = re.sub(r"\s+", " ", line.split("//")[0].strip())
            if not stripped:
                continue
            if stripped[-1] == ":":
                labels[stripped[:-1]] = line_number
            else:
                Instructions.append(stripped)
                line_number += 1
    with open(tmp_filename, "w") as outfile:
        for instr in Instructions:
            fields = instr.split()
            if fields[0].upper() in {"B", "BEQ", "BNE", "BHI"} and fields[1] in labels:
                absolute_target = labels[fields[1]]
                instr = f"{fields[0]} #{absolute_target}"
            outfile.write(f"{instr}\n")
    

def process_assembly_file(input_filename, output_filename):
    preprocess_assembly_file(input_filename)
    script_dir = os.path.dirname(os.path.abspath(__file__))
    input_filename = os.path.join(script_dir, input_filename)
    output_filename = os.path.join(script_dir, output_filename)
    if not os.path.exists(input_filename):
            print(f"Error: {input_filename} not found.")
            return
    Instructions = []
    with open(input_filename+"_tmp", "r") as infile:
        for line in infile:
            instruction = Instruction(line)
            if instruction.instr_type:
                Instructions.append(instruction)
    with open(output_filename, "w") as outfile:
        for instr in Instructions:
            outfile.write(f"{instr.binary}\n")
    # os.remove(input_filename+"_tmp")

def main():
    process_assembly_file("inputs/sort.asm", "outputs/sort.bin")

if __name__ == "__main__":
    main()
