; RAM[15:0] = Filter Coefficients
; RAM[47:16] = Samples
; RAM[48] = M (# Coefficients)
; RAM[49] = N (# Samples)
; RAM[...:50] = Filtered Samples

; r14 = 0.00390625 = 0x0001 (q7.8) => Memory Increment
mov r14, #0.00390625

; r0 = 0 = Coefficients Memory Addresss[0]
mov r0, #0

; r1 = Samples Memory Address[0]
mov r13, #48
mul r1, r14, r13

; n => Current Sample
mov r2, #0
; m => Current Coefficient 
mov r3, #0

; r13 = M Memory Address
mov r13, #31.2421875
; r4 = [r13] = M
ldr r4, r13 

; r13 = N Memory Address
mov r13, #31.24609375
; r5 = [r13] = N
ldr r5, r13

_filter_loop:
	; m = 0
	mov r3, #0
	; r6 = y_n
	mov r6, #0

	_sum_loop:
		; r13 = [&coeff[0] + m]
		add r13, r0, r3
		; r7 = [r13] = [&coeff[0] + m] => h_m
		ldr r7, r13
		; r12 = r2 - r3 = (n - m)
		sub r12, r2, r3
		; r12 = &samples[0] + (n - m) => &x(n - m)
		add r12, r1, r12
		; r8 = x(n - m)
		ldr r8, r12
		; r9 = h_m * x(n - m)
		mul r9, r7, r8
		; r6 = y_n + h_m * x(n - m)
		add r6, r6, r9

		cmp r13, r2, r3
		; if n > m, check that m < M
		bgt _check_m_lt_M
		; if n <= m, go to next y_n
		cmp r13, r13, r13
		beq _next_y_n

			_check_m_lt_M:
				; r3 = m++
				add r3, r3, r14
				cmp r13, r4, r3
				; if M > m, use the next coefficient
				bgt _sum_loop

		_next_y_n:
			; r13 = &filtered[0]
			mov r13, #15.625
			; r13 = &filtered[0] + n
			add r13, r13, r2
			; [&filtered[0] + n] = y_n
			str r6, r13
			; r2++ = n++
			add r2, r2, r14
			cmp r13, r5, r2
			; if N > n, calculate y_n_p1
			bgt _filter_loop