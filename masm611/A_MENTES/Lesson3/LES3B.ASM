.MODEL SMALL
.STACK
.CODE
main proc
  CALL read_char
  XOR DH, DH

  CALL cr_lf
  CALL write_binary

  CALL cr_lf
  CALL write_decimal

  CALL cr_lf
  CALL write_hexa

  MOV AH,4Ch
  INT 21h
main endp
END main
