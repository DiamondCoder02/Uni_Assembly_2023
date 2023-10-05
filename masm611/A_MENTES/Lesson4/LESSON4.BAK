.MODEL SMALL
.STACK
.CODE
write_char proc
PUSH AX
MOV AH, 2
INT 21h
POP AX
RET
write_char endp
write_binary proc
PUSH BX
PUSH CX
PUSH DX
MOV BL, DL
MOV CX, 8
binary_digit:
XOR DL, DL
RCL BL, 1
ADC DL, "0"
CALL write_char
LOOP binary_digit
POP DX
POP CX
POP BX
RET
write_binary endp
END write_binary
