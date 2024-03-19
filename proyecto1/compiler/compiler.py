import sys
import os

from compiler_config import (
    MEMORY_SIZE,
    EMPTY_NIBBLE,
    STALL_NIBBLES,
    OP_CODES,
    SCALAR_DATA_CMD,
    SCALAR_MEMORY_CMD,
    VECTOR_DATA_CMD,
    VECTOR_MEMORY_CMD,
    BRANCH_CMD,
    IND,
    inst_types,
    scalar_registers,
    vector_registers
)

# instructions_file_path = sys.argv[1]
# compiled_file_path = sys.argv[2]
instructions_file_path = './instructions.asm'
compiled_file_path = './compiled_instructions.mem'

if (os.path.exists(compiled_file_path)):
    os.remove(compiled_file_path)

instructions_file = open(instructions_file_path, 'r')
compiled_file = open(compiled_file_path, 'a')


def split_nibbles(binary_string):
    result = []
    for i in range(int(len(binary_string)/4)):
        result.append(f'{binary_string[i*4:(i+1)*4]}')
    return result
  
def to_binary_string(number, width):
    if (number < 0):
        return f'{number % (1 << width):0{width}b}'
    else:
        return f'{number:0{width}b}'
    
    
def to_q7_8(number):
    signed_bit = True if number < 0 else False
    decimal_representation = round(abs(number) * (2 ** 8))

    if signed_bit:
        decimal_representation = (decimal_representation ^ 0xFFFF) + 1

    return to_binary_string(decimal_representation, 16)
    
    
def get_immediate_operand(operand):
    try:
        float_operand = float(operand.replace('#', ''))
        binary_operand = to_q7_8(float_operand)
        
        if(float_operand < -128 or float_operand > 127.99):
            raise Exception(
                f'Error: immediate operand "{operand}" out of range. Max value is 127.99 and min value is -128.')
            
        print(f'Immediate Representation: {float_operand} -> {binary_operand}')
            
        return split_nibbles(binary_operand)
    except Exception as error:
        raise Exception(str(error))


def get_operand(operand, type):
    try:
        if type == 'scalar':
            return scalar_registers[operand]
        elif type == 'vector':
            return vector_registers[operand]
        else:
            raise KeyError
    except KeyError:
        raise Exception(f'Error: invalid operand "{operand}"')
    

def memory_instruction(op_code, cmd, type, operands):
    if (type == 'scalar'):
        operand_1 = get_operand(operands[0], 'scalar')
        operand_2 = get_operand(operands[1], 'scalar')
    else:
        operand_1 = get_operand(operands[0], 'vector')
        operand_2 = get_operand(operands[1], 'scalar')

    fill = [EMPTY_NIBBLE for _ in range(4)]
    ind = IND[type]
    
    result = [op_code, cmd, ind, operand_1, operand_2] + fill
        
    return result


def data_instruction(op_code, cmd, type, operands):
    if (cmd == SCALAR_DATA_CMD['MOV']):
        operand_1 = get_operand(operands[0], type)
        operand_2 = EMPTY_NIBBLE
        operand_3 = get_immediate_operand(operands[1])
        ind = IND['immediate']
        
        result = [op_code, cmd, ind, operand_1, operand_2] + operand_3
    elif (cmd == SCALAR_DATA_CMD['SLL']):
        operand_1 = get_operand(operands[0], type)
        operand_2 = get_operand(operands[1], type)
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


def get_inst_type(cmd_key):
    for inst_type in inst_types:
        if cmd_key in inst_type['cmd']:
            op_code = inst_type['op_code']
            cmd = inst_type['cmd'][cmd_key]
            type = inst_type['type']
            return op_code, cmd, type

    raise Exception(f'Error: invalid operation "{cmd_key}"')


def decode_instruction(cmd_key, operands, current_pc, labels):
    try:
        op_code, cmd, type = get_inst_type(cmd_key)

        if (op_code == OP_CODES['DATA']):
            return data_instruction(op_code, cmd, type, operands)
        elif (op_code == OP_CODES['MEMORY']):
            return memory_instruction(op_code, cmd, type, operands)
        # elif (inst_type == 'branch'):
        #     return branch_instruction(op_code, operands, current_pc, labels)
        else:
            raise Exception(f'Error: invalid operation "{cmd_key}"')
    except Exception as error:
        raise Exception(str(error))


pc = 0
labels = []
instructions = []
for instruction in instructions_file:
    instruction = instruction.strip().lower()

    if (instruction == '' or instruction[0] == ';'):
        continue
    # elif (instruction[-1] == ':'):
    #     label = {'label_name': instruction[:-1], 'pc': pc}
    #     labels.append(label)
    #     continue

    instructions.append(instruction)
    pc += 8

pc = 0
try:
    for instruction in instructions:
        instruction = instruction.split(' ', 1)
        
        cmd_key = instruction[0]
        operands = instruction[1].replace(' ', '').split(',')
        
        instruction_blocks = decode_instruction(cmd_key, operands, pc, labels)
        instruction_bits = "".join(instruction_blocks)
        instruction_nibbles = split_nibbles(instruction_bits)
        
        print('-'*75)
        print(instruction)
        print(instruction_blocks)
        print(instruction_nibbles)
        print(f'PC: {pc}')
        print(f'Instruction length: {len(instruction_bits)}')
        print('-'*75)

        for nibble in instruction_nibbles:
            compiled_file.write(f'{nibble}\n')
            pc += 1

    while pc < MEMORY_SIZE:
        for STALL_NIBBLE in STALL_NIBBLES:
            compiled_file.write(f'{STALL_NIBBLE}\n')
            pc += 1

except Exception as error:
    print(str(error))
    os.remove(compiled_file_path)
    sys.exit(1)