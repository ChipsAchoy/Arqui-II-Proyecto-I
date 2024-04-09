.global _start
_start:
	mov r0, #0x100 ; r0 = 0x100 
	lsl r0, r0, #0 ; r0 = r0 << 0 = 0x100
	
	mov r1, #0
	mov r2, #16
	
	_write_coeff:
		str r1, [r0]
		add r0, #4
		add r1, #1
		cmp r1, r2
		blt _write_coeff 
	
	mov r0, #0x100 ; r0 = 0x100
	lsl r0, r0, #0 ; Coefficients Memory Addresss [0] = r0 << 0 = 0x100
	
	mov r1, #0x100 ; r1 = 0x100
	lsl r1, r1, #4 ; r1 = 0x100 << 4 = 0x1000
	
	mov r2, #0
	mov r3, #32
	
	_write_samples:
		str r2, [r1]
		add r1, #4
		add r2, #1
		cmp r2, r3
		blt _write_samples
	
	mov r1, #0x100 ; Samples Memory Address [0] = 0x100
	lsl r1, r1, #4 ; Samples Memory Address [0] = 0x100 << 4 = 0x1000
	
	mov r2, #0x100 ; Filtered Samples Memory address [0] = 0x100
	lsl r2, r2, #8 ; Filtered Samples Memory address [0] = 0x100 << 8 = 0x10000
	
	mov r3, #0 ; n
	mov r4, #0 ; m
	mov r5, #16 ; M
	mov r6, #32 ; N
	
	_filter_loop:
		mov r4, #0 ; m = 0
		mov r7, #0 ; y_n
		
		_sum_loop:
			ldr r8, [r0, r4, lsl #2] ; r8 = [r0 + 4*r4] = h_m
			sub r12, r3, r4 ; r12 = r3 - r4 = (n - m)
			ldr r9, [r1, r12, lsl #2] ; r9 = [r1 + r12] = x(n - m)
			mul r10, r8, r9 ; r10 = r8 * r9 = h_m * x(n - m)
			add r7, r7, r10 ; r7 = r7 + h_m * x(n - m)
			add r4, r4, #1 ; r4 = r4 + 1 = m++
			
			cmp r3, r4
			bgt _check_m_lt_M ; if n > m, check that m < M
			b _next_y_n ; if n <= m, go to next y_n
			
			_check_m_lt_M:
				cmp r4, r5
				blt _sum_loop ; if m < M, use the next coefficient
				
		_next_y_n:	
			str r7, [r2, r3, lsl #2] ; [r2 + 4*r3] = r7 => [r2 + 4*n] = y_n
			add r3, r3, #1 ; r3 = r3 + 1 = n++
			cmp r3, r6
			blt _filter_loop ; if n < N, calculate y_n_p1