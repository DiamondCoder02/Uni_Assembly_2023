.MODEL SMALL 
.STACK 
.CODE 
CR EQU 13
LF EQU 10
main proc 
	MOV AH, 2Ah 
	INT 21h 
	CALL cr_lf 
	CALL write_decimal ;A nap kiírása 
	CALL cr_lf 
	MOV DL,DH 
	CALL write_decimal ;A hónap kiírása 
	CALL cr_lf 
	MOV DL, CH 
	CALL write_binary ;Az év felső bájtjának kiírása 
	CALL cr_lf 
	MOV DL, CL 
	CALL write_binary ;Az év alsó bájtjának kiírása 
	CALL cr_lf 
	MOV DL, AL 
	CALL write_decimal ;A hét napja sorszámának kiírása 
	CALL cr_lf 
	MOV AH,4Ch ;Kilépés 
	INT 21h 
main endp 


write_char proc
    PUSH AX
    MOV AH, 2
    INT 21h
    POP AX
    RET
write_char endp
cr_lf proc
    PUSH DX
    MOV DL, CR
    CALL write_char
    MOV DL, LF
    CALL write_char
    POP DX
    RET
cr_lf endp
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
write_hexa_digit proc
    PUSH DX
    CMP DL, 10
    JB non_hexa_letter
    ADD DL, "A"-"0"-10
non_hexa_letter:
    ADD DL, "0"
    CALL write_char
    POP DX
    RET
write_hexa_digit endp
write_decimal proc
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH SI
    XOR DH, DH
    MOV AX, DX
    MOV SI, 10
    XOR CX, CX
decimal_non_zero:
    XOR DX, DX
    DIV SI
    PUSH DX
    INC CX
    OR AX, AX
    JNE decimal_non_zero
decimal_loop:
    POP DX
    CALL write_hexa_digit
    LOOP decimal_loop
    POP SI
    POP DX
    POP CX
    POP AX
    RET
write_decimal endp
end main