mov r1, #1

loop_1:
  add r0, r0, r1
  cmp r2, r0, #4
  bne loop_1

add r3, r0, r0
mov r0, #0

loop_2:
  add r0, r0, r1
  cmp r2, r0, r3
  bne loop_2

add r3, r0, r0
mov r0, #0

loop_3:
  add r0, r0, r1
  cmp r2, r0, r3
  bne loop_3

mov r1, #0
mov r2, #0
mov r3, #0