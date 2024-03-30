mov r2, #1

loop:
  add r1, r1, r2
  cmp r4, r1, #3
  blt loop

add r4, r1, r1
mov r1, #0