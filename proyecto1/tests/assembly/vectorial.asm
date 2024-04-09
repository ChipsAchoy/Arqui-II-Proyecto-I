; Index
mov r0, #0
; Index Increment
mov r1, #1  
; Stop Condition
mov r2, #10
; Memory increment (0.00390625 = 1)
mov r3, #0.00390625
; Memory Offset (0.05859375 = 15)
mov r4, #0.05859375
; Memory address
mov r5, #0

; RAM0 = 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
; RAM1 = 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15

write_loop:
  ; Stores r0 = index in the address pointed by r4
  str r0, r5
  ; Increments memory address by 1
  add r4, r4, r3
  ; Increments index by 1
  add r0, r0, r1
  ; Checks stop condition
  cmp r14, r0, r2
  bne write_loop

mov r5, #0
