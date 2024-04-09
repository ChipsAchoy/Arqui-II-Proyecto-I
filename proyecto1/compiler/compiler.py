import sys
import os

from compiler_config import (
    MEMORY_SIZE,
    EMPTY_NIBBLE,
    STALL_BYTES,
    OP_CODES,
    SCALAR_DATA_CMD,
    VECTOR_DATA_CMD,
    BRANCH_CMD,
    IND,
    inst_types,
    scalar_registers,
    vector_registers
)


def split_bytes(binary_string):
    result = []
    for i in range(int(len(binary_string) / 8)):
        result.append(f'{binary_string[i * 8:(i + 1) * 8]}')
    return result
  
  
def to_binary_string(number, width):
    if(number < 0):
        return f'{number % (1 << width):0{width}b}'
    else:
        return f'{number:0{width}b}'
    
    
def to_q7_8(number):
    decimal_representation = round(abs(number) * (2 ** 8))
    
    binary_representation = to_binary_string(decimal_representation, 15)
    
    signed_bit = True if number < 0 else False
    if signed_bit:
        binary_representation = f'1{binary_representation}'
    else:
        binary_representation = f'0{binary_representation}'

    return binary_representation
    
    
def get_immediate_operand(operand):
    try:
        float_operand = float(operand.replace('#', ''))
        binary_operand = to_q7_8(float_operand)
        
        if(float_operand < -128 or float_operand > 127.99):
            raise Exception(
                f'Error: immediate operand "{operand}" out of range. Max value is 127.99 and min value is -128.')
            
        print(f'Immediate Representation: {float_operand} -> {binary_operand}')
            
        return split_bytes(binary_operand)
    except Exception as error:
        raise Exception(str(error))


def get_operand(operand, type):
    try:
        if type == 'scalar':
            return scalar_registers[operand]
        elif type == 'vector':
            return vector_registers[operand]
        else:
            raise Exception(f'Error: invalid operand "{operand}"')
    except Exception as error:
        raise Exception(str(error))
    

def branch_instruction(op_code, cond_key, branch_label, labels):
    try:
        for label in labels:
            if(label['label_name'] == branch_label):
                cmd = BRANCH_CMD
                ind = IND['immediate']
                cond = None
                for inst_type in inst_types:
                    if(inst_type['type'] == 'branch'):
                        cond = inst_type['cond'][cond_key]
                
                if(cond == None):
                    raise Exception(f'Invalid condition: {cond_key}')
                
                label_pc = to_binary_string(label['current_pc'], 16)
                label_pc = split_bytes(label_pc)
                
                return [op_code, cmd, ind, cond, EMPTY_NIBBLE] + label_pc
            
        raise Exception(f'Unknown Label {branch_label}.')
    except Exception as error:
        raise Exception(str(error))


def memory_instruction(op_code, cmd, type, operands):
    if(type == 'scalar'):
        operand_1 = get_operand(operands[0], 'scalar')
        operand_2 = get_operand(operands[1], 'scalar')
    else:
        operand_1 = get_operand(operands[0], 'vector')
        operand_2 = get_operand(operands[1], 'vector')

    fill = [EMPTY_NIBBLE for _ in range(4)]
    ind = IND[type]
    
    result = [op_code, cmd, ind, operand_1, operand_2] + fill
        
    return result


def data_instruction(op_code, cmd, type, operands):
    if(cmd == SCALAR_DATA_CMD['CMP']):
        operand_1 = get_operand(operands[0], type)
        operand_2 = get_operand(operands[1], type)
        
        if(operands[2][0] == '#'):
            operand_3 = get_immediate_operand(operands[2])
            ind = IND['cmp_immediate']
            
            result = [op_code, cmd, ind, operand_1, operand_2] + operand_3
        else:
            operand_3 = get_operand(operands[2], type)
            ind = IND['cmp_scalar']
            fill = [EMPTY_NIBBLE for _ in range(3)]
            
            result = [op_code, cmd, ind, operand_1, operand_2] + fill
            result.append(operand_3)
    elif(cmd == SCALAR_DATA_CMD['MOV']):
        operand_1 = get_operand(operands[0], type)
        operand_2 = EMPTY_NIBBLE
        operand_3 = get_immediate_operand(operands[1])
        ind = IND['immediate']
        
        result = [op_code, cmd, ind, operand_1, operand_2] + operand_3
    elif(cmd == SCALAR_DATA_CMD['SLL'] and type == 'scalar'):
        operand_1 = get_operand(operands[0], type)
        operand_2 = get_operand(operands[1], type)
        fill = [EMPTY_NIBBLE for _ in range(4)]
        ind = IND[type]
        
        result = [op_code, cmd, ind, operand_1, operand_2] + fill
    elif(cmd == VECTOR_DATA_CMD['SUMV'] and type == 'vector'):
        operand_1 = get_operand(operands[0], 'scalar')
        operand_2 = get_operand(operands[1], 'vector')
        fill = [EMPTY_NIBBLE for _ in range(4)]
        ind = IND[type]
        
        result = [op_code, cmd, ind, operand_1, operand_2] + fill
    else:
        operand_1 = get_operand(operands[0], type)
        operand_2 = get_operand(operands[1], type)
        operand_3 = get_operand(operands[2], type)
        fill = [EMPTY_NIBBLE for _ in range(3)]
        ind = IND[type]
        
        result = [op_code, cmd, ind, operand_1, operand_2] + fill
        result.append(operand_3)
    
    return result


def stall_instruction():
    return STALL_BYTES


def get_inst_type(cmd_key):
    for inst_type in inst_types:
        if(inst_type['type'] == 'branch'):
            if(cmd_key in inst_type['cond']):
                op_code = inst_type['op_code']
                cmd = BRANCH_CMD
                type = inst_type['type']
                return op_code, cmd, type
        
        if cmd_key in inst_type['cmd']:
            op_code = inst_type['op_code']
            cmd = inst_type['cmd'][cmd_key]
            type = inst_type['type']
            return op_code, cmd, type
        
    raise Exception(f'Error: invalid operation "{cmd_key}"')


def decode_instruction(cmd_key, operands, labels):
    try:
        op_code, cmd, type = get_inst_type(cmd_key)
        
        if(op_code == OP_CODES['DATA']):
            return data_instruction(op_code, cmd, type, operands)
        elif(op_code == OP_CODES['MEMORY']):
            return memory_instruction(op_code, cmd, type, operands)
        elif(op_code == OP_CODES['BRANCH']):
            label = operands[0]
            return branch_instruction(op_code, cmd_key, label, labels)
        else:
            raise Exception(f'Error: invalid operation "{cmd_key}"')
    except Exception as error:
        raise Exception(str(error))


def split_instruction(instruction):
    instruction = instruction.split(' ', 1)
    
    cmd_key = instruction[0]
    operands = instruction[1].replace(' ', '').split(',')
    
    return cmd_key, operands


def compile_instructions(instructions, labels, compiled_file): 
    pc = 0
    for instruction in instructions:
        print('-'*75)
        print(f'Instruction: {instruction}')
        if(instruction == 'nop'):
            instruction_bytes = stall_instruction()
            print(f'Adding Stall...')
            print(instruction_bytes)
            print(f'PC: {pc}')
        else:
            cmd_key, operands = split_instruction(instruction)
            instruction_blocks = decode_instruction(cmd_key, operands, labels)
            instruction_bits = "".join(instruction_blocks)
            instruction_bytes = split_bytes(instruction_bits)
            
            print(instruction)
            print(instruction_blocks)
            print(instruction_bytes)
            print(f'PC: {pc}')
            print(f'Instruction length: {len(instruction_bits)}')
        print('-'*75)

        for byte in instruction_bytes:
            hex_byte = '{:02x}'.format(int(byte, 2))
            compiled_file.write(f'{hex_byte}\n')
            pc += 1

    while pc < MEMORY_SIZE:
        for STALL_BYTE in STALL_BYTES:
            hex_byte = '{:02x}'.format(int(STALL_BYTE, 2))
            compiled_file.write(f'{hex_byte}\n')
            pc += 1


def is_branch_instruction(instruction):
    if(instruction == None):
        return False
    
    operation = split_instruction(instruction)[0]
    for inst_type in inst_types:
        if(inst_type['type'] == 'branch'):
            if(operation in inst_type['cond']):
                return True
    
    return False

def has_dependencies(instruction_0, instruction_1, instruction_2):  
    operands_0 = split_instruction(instruction_0)[1]
    operands_1 = split_instruction(instruction_1)[1]
    
    if(instruction_2 != None):
        operands_2 = split_instruction(instruction_2)[1]
    else:
        operands_2 = None
    
    if(is_branch_instruction(instruction_0)):
        return False
    if(is_branch_instruction(instruction_1)):
        operands_1 = None
    if(is_branch_instruction(instruction_2)):
        operands_2 = None
        
    dependency_instruction = None
    dependency_operand = None
    
    if(operands_1 != None):
        if(operands_0[0] == operands_1[1]):
            dependency_instruction = instruction_1
            dependency_operand = operands_1[1]
        
        if((len(operands_1) == 3) and (operands_0[0] == operands_1[2])):
            dependency_instruction = instruction_1
            dependency_operand = operands_1[2]    
    
    if(operands_2 != None):
        if(operands_0[0] == operands_2[1]):
            dependency_instruction = instruction_2
            dependency_operand = operands_2[1]
        
        if((len(operands_2) == 3) and (operands_0[0] == operands_2[2])):
            dependency_instruction = instruction_2
            dependency_operand = operands_2[2]
    
    if((dependency_instruction != None) and (dependency_operand != None)):
        print(f'Dependency Found: Instruction "{dependency_instruction}" needs "{dependency_operand}" from instruction "{instruction_0}"')
        return True
    
    return False


def resolve_dependencies(instructions, labels):
    new_instructions = []
    
    print('-'*100)
    for index in range (len(instructions)):
        current_pc = index * 4
        instruction_0 = instructions[index]
        
        new_instructions.append(instruction_0)
        
        if((index + 1) == len(instructions)):
            break
        else:
            instruction_1 = instructions[index + 1]
        
        if((index + 2) < len(instructions)):
            instruction_2 = instructions[index + 2]
        else:
            instruction_2 = None

        new_instructions.append('nop')
        new_instructions.append('nop')
        new_instructions.append('nop')
        new_instructions.append('nop')
        new_instructions.append('nop')
        for label in labels:
            if(label['original_pc'] > current_pc):
                label['current_pc'] += 20
                print(f'Updating Label "{label["label_name"]}" PC from {label["current_pc"] - 20} to {label["current_pc"]}')
            
        # if(has_dependencies(instruction_0, instruction_1, instruction_2)):
        #     new_instructions.append('nop')
        #     new_instructions.append('nop')
        #     new_instructions.append('nop')
        #     for label in labels:
        #         if(label['original_pc'] > current_pc):
        #             label['current_pc'] += 12
        #             print(f'Updating Label "{label["label_name"]}" PC from {label["current_pc"] - 12} to {label["current_pc"]}')
                    
        # if(is_branch_instruction(instruction_0)):
        #     new_instructions.append('nop')
        #     new_instructions.append('nop')
        #     new_instructions.append('nop')
        #     new_instructions.append('nop')
        #     new_instructions.append('nop')
        #     for label in labels:
        #         if(label['original_pc'] > current_pc):
        #             label['current_pc'] += 20
        #             print(f'Updating Label "{label["label_name"]}" PC from {label["current_pc"] - 20} to {label["current_pc"]}')
                    
    for instruction in new_instructions:
        print(instruction)
                    
    print('-'*100)
    
    return new_instructions, labels


def read_instructions(instructions_file):
    pc = 0
    labels = []
    instructions = []
    for instruction in instructions_file:
        instruction = instruction.strip().lower()

        if(instruction == '' or instruction[0] == ';'):
            continue
        elif(instruction[-1] == ':'):
            label = {
                'label_name': instruction[:-1], 
                'original_pc': pc,
                'current_pc': pc
            }
            labels.append(label)
            continue
        else:
            instructions.append(instruction)
            pc += 4
            
    return instructions, labels

  
def main():
    instructions_file_path = sys.argv[1]
    compiled_file_path = sys.argv[2]

    if(os.path.exists(compiled_file_path)):
        os.remove(compiled_file_path)

    instructions_file = open(instructions_file_path, 'r')
    compiled_file = open(compiled_file_path, 'a')
    
    try:
        instructions, labels = read_instructions(instructions_file)
        instructions, labels = resolve_dependencies(instructions, labels)
        
        compile_instructions(instructions, labels, compiled_file)
    except Exception as error:
        print(str(error))
        os.remove(compiled_file_path)
        sys.exit(1)


if __name__ == '__main__': main()