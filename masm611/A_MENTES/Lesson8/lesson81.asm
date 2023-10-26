.MODEL SMALL 
.STACK 
.DATA 
	x DB 10 ;X coordinate
	y DB 10 ;Y coordinate
	kar DB "A" ;Character to be displayed
	att DB 4 ;Attribute
.CODE 
main proc
	MOV AX, dgroup
	MOV DS, AX 
	MOV AX, 0B800h
	MOV ES, AX 
	XOR AX, AX 
	MOV BL, 160 
	MOV AL, y 
	DEC AL 
	MUL BL 
	MOV DI, AX 
	XOR AX, AX
	MOV AL, x 
	DEC AL 
	SHL AL, 1 
	ADD DI, AX 

	MOV AL, kar 
	MOV AH, att 
	MOV ES:[DI], AX 
	MOV AH, 4Ch 
	INT 21h 
main endp