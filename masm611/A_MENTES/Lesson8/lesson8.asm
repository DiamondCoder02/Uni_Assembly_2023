.MODEL SMALL
.STACK
.CODE
main proc
	MOV AX, 0B800h
	MOV ES, AX
	MOV AH, 0
	MOV AL, 3h
	INT 10H
	MOV DI, 1838
	MOV AL, "*"
	MOV AH, 128+16*7+4
	MOV ES:[DI], AX
	MOV AH, 4Ch
	INT 21H
main endp
END main