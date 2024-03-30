MEMORY_SIZE = 400 # In bytes

EMPTY_NIBBLE = '0000'

STALL_BYTES = [
    '11000000',
    '00000000',
    '00000000',
    '00000000'
]

OP_CODES = {
    'DATA':   '00',
    'MEMORY': '01',
    'BRANCH': '10'
}

SCALAR_DATA_CMD = {
    'ADD': '000',
    'SUB': '001',
    'MUL': '010',
    'DIV': '011',
    'MOD': '100',
    'SLL': '101',
    'MOV': '110',
    'CMP': '111'
}

SCALAR_MEMORY_CMD = {
    'STR': '000',
    'LDR': '001'
}

VECTOR_DATA_CMD = {
    'ADDV': '000',
    'SUBV': '001',
    'MULV': '010',
    'DIVV': '011',
}

VECTOR_MEMORY_CMD = {
    'STRV': '000',
    'LDRV': '001'
}


BRANCH_CMD = '110'


BRANCH_COND = {
    'EQ':   '0000',
    'NE':   '0001',
    'HS':   '0010',
    'LO':   '0011',
    'MI':   '0100',
    'PL':   '0101',
    'VS':   '0110',
    'VC':   '0111',
    'HI':   '1000',
    'LS':   '1001',
    'GE':   '1010',
    'LT':   '1011',
    'GT':   '1100',
    'LE':   '1101',
    'JUMP': '1110'
}

IND = {
    'scalar':        '000',
    'cmp_scalar':    '001',
    'immediate':     '010',
    'cmp_immediate': '011',
    'vector':        '100'
}

inst_types = [
    {
        'op_code': OP_CODES['DATA'],
        'type': 'scalar',
        'cmd': {
            'add': SCALAR_DATA_CMD['ADD'],
            'sub': SCALAR_DATA_CMD['SUB'],
            'mul': SCALAR_DATA_CMD['MUL'],
            'div': SCALAR_DATA_CMD['DIV'],
            'mod': SCALAR_DATA_CMD['MOD'],
            'sll': SCALAR_DATA_CMD['SLL'],
            'mov': SCALAR_DATA_CMD['MOV'],
            'cmp': SCALAR_DATA_CMD['CMP']
        }
    },
    {
        'op_code': OP_CODES['MEMORY'],
        'type': 'scalar',
        'cmd': { 
            'str': SCALAR_MEMORY_CMD['STR'],
            'ldr': SCALAR_MEMORY_CMD['LDR']
        }
    },
    {
        'op_code': OP_CODES['DATA'],
        'type': 'vector',
        'cmd': {
            'addv': VECTOR_DATA_CMD['ADDV'],
            'subv': VECTOR_DATA_CMD['SUBV'],
            'mulv': VECTOR_DATA_CMD['MULV'],
            'divv': VECTOR_DATA_CMD['DIVV']
        }   
    },
    {
        'op_code': OP_CODES['MEMORY'],
        'type': 'vector',
        'cmd': {
            'strv': VECTOR_MEMORY_CMD['STRV'],
            'ldrv': VECTOR_MEMORY_CMD['LDRV']
        }
    },
    {
        'op_code': OP_CODES['BRANCH'],
        'type': 'branch',
        'cmd': BRANCH_CMD,
        'cond': {
            'beq':  BRANCH_COND['EQ'],
            'bne':  BRANCH_COND['NE'],
            'bhs':  BRANCH_COND['HS'],
            'blo':  BRANCH_COND['LO'],
            'bmi':  BRANCH_COND['MI'],
            'bpl':  BRANCH_COND['PL'],
            'bvs':  BRANCH_COND['VS'],
            'bvc':  BRANCH_COND['VC'],
            'bhi':  BRANCH_COND['HI'],
            'bls':  BRANCH_COND['LS'],
            'bge':  BRANCH_COND['GE'],
            'blt':  BRANCH_COND['LT'],
            'bgt':  BRANCH_COND['GT'],
            'ble':  BRANCH_COND['LE'],
            'jump': BRANCH_COND['JUMP']
        }
    }
]

scalar_registers = {
    'r0':  '0000',
    'r1':  '0001',
    'r2':  '0010',
    'r3':  '0011',
    'r4':  '0100',
    'r5':  '0101',
    'r6':  '0110',
    'r7':  '0111',
    'r8':  '1000',
    'r9':  '1001',
    'r10': '1010',
    'r11': '1011',
    'r12': '1100',
    'r13': '1101',
    'r14': '1110',
    'r15': '1111'
}

vector_registers = {
    'v0':  '0000',
    'v1':  '0001',
    'v2':  '0010',
    'v3':  '0011',
    'v4':  '0100',
    'v5':  '0101',
    'v6':  '0110',
    'v7':  '0111',
    'v8':  '1000',
    'v9':  '1001',
    'v10': '1010',
    'v11': '1011',
    'v12': '1100',
    'v13': '1101',
    'v14': '1110',
    'v15': '1111'
}