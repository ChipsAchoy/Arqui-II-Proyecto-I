mov r0, #10
mov r1, #2
mov r2, #-10
mov r3, #-2

; ----------- ADD -----------

; r4 = (2) + (-10) = -8
add r4, r1, r2

; r4 = (10) + (-2) = 8
add r4, r0, r3

;r4 = (-2) + (10) = 8
add r4, r3, r0

;r4 = (-10) + (2) = -8
add r4, r2, r1

; r4 = (-10) + (-2) = -12
add r4, r2, r3

; r4 = (-2) + (-10) = -12
add r4, r3, r2

; r4 = (10) + (2) = 12
add r4, r0, r1

; r4 = (2) + (10) = 12
add r4, r1, r0

; ----------- SUB -----------

; r4 = (10) - (-2) = 12
sub r4, r0, r3

; r4 = (2) - (-10) = 12
sub r4, r1, r2

;r4 = (-10) - (2) = -12
sub r4, r2, r1

;r4 = (-2) - (10) = -12
sub r4, r3, r0

; r4 = (10) - (2) = 8
sub r4, r0, r1

; r4 = (2) - (10) = -8
sub r4, r1, r0

; r4 = (-10) - (-2) = -8
sub r4, r2, r3

; r4 = (-2) - (-10) = 8
sub r4, r3, r2

; ----------- SHIFT -----------

mov r0, #1
mov r1, #2
mov r2, #2

;r2 = r2 << 1 = 4
sll r2, r0

;r2 = r2 << 2 = 16
sll r2, r1

;r2 = r2 << 2 = 64
sll r2, r1

; addv v1, v2, v3
; subv v4, v2, v3
; mulv v5, v2, v3
; divv v6, v2, v3

; str r1, r2
; ldr r2, r3

; strv v1, r2
; ldrv v2, r3