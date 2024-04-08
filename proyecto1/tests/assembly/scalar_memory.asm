; Index
mov r0, #0
; Index Increment
mov r1, #1  
; Stop Condition
mov r2, #10
; Memory increment (0.00390625 = 1)
mov r3, #0.00390625
; Memory address
mov r4, #0
;Value To Store
mov r5, #25

write_loop:
  ; Stores r5 = 25 in the address pointed by r4
  str r5, r4
  ; Increments memory address by 1
  add r4, r4, r3
  ; Increments index by 1
  add r0, r0, r1
  ; Checks stop condition
  cmp r14, r0, r2
  bne write_loop

mov r5, #0
