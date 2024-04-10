; RAM[15:0] = Filter Coefficients
; RAM[47:16] = Samples
; RAM[48] = M (# Coefficients)
; RAM[49] = N (# Samples)
; RAM[...:50] = Filtered Samples

; v15 = Memory Increment by 1
; v14 = Memory Increment by 16
; v13 = 0 = Coefficients Memory Addresss[0]
; v12 = 48 = Samples Memory Address[0]
; v11 = 48 = Filtered Samples Memory Addresss[0]

; r14 = 0.00390625 = 0x0001 (q7.8) => Memory Increment
mov r14, #0.00390625

; r13 = M Memory Address
mov r13, #31.2421875
; mul r13, r13, r14
ldr r13, r13

; r12 = N Memory Address
mov r12, #31.24609375
; mul r12, r12, r14
ldr r12, r12

; v10 = 0 = n index
subv v10, v10, v10

_filter_loop:
  ; r0 = y_n
  mov r0, #0

  ; v9 = 0 = m_index
  subv v9, v9, v9

  _sum_loop:
    ; v0 = &x_v[0] + n_index
    addv v0, v12, v10
    ; v0 = (&x_v[0] + n_index) + m_index
    addv v0, v0, v9
    ; v0 = x_v
    ldrv v0, v0

    ; v1 = &h_v[0] + m_index
    addv v1, v13, v9
    ; v1 = h_v
    ldrv v1, v1

    ; v2 = y_n_v_i = x_v .* h_v
    mulv v2, v0, v1
    ; r10 = sum(y_n_v_i)
    sumv r10, v2
    ; r0 = r0 + sum(y_n_v_i)
    add r0, r0, r10

    ; v9 = m_index + 16 -> Vectorial
    addv v9, v9, v14
    ; r1 = m_index + 16
    sumv r1, v9

    ; if M > m_index, continue sum_loop
    cmp r11, r13, r1
    bgt _sum_loop

    ; r11 = current result address
    sumv r11, v11
    ; Stores y_n in memory
    str r0, r11
    ; v11 = next result address
    addv v11, v11, v15

    ; v10 = n_index + 1 -> Vectorial
    addv v10, v10, v15
    ; r2 = n_index + 1
    sumv r2, v10
    
    ; r3 = Memory decrement 16 positions
    sumv r3, v14
    sub r3, r12, r3

    ; if (N - 16) > n_index, calculate next y_n
    cmp r3, r3, r2
    bgt _filter_loop