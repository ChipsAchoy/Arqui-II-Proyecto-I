mov r0, #1
mov r1, #20

loop_1:
  sub r1, r1, r0
  cmp r2, r1, #10
  bgt loop_1

; add r3, r0, r0
; mov r0, #0

; loop_2:
;   add r0, r0, r1
;   cmp r2, r0, r3
;   bne loop_2

; add r3, r0, r0
; mov r0, #0

; loop_3:
;   add r0, r0, r1
;   cmp r2, r0, r3
;   bne loop_3

mov r1, #0
mov r2, #0
mov r3, #0