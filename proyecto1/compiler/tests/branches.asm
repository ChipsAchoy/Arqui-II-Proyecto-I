mov r1, #1

loop:
  add r0, r0, r1
  cmp r2, r0, #4
  bne loop

add r3, r0, r0
mov r0, #0