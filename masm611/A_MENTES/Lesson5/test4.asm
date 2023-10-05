.MODEL SMALL 
.STACK 
.CODE
main proc ;Főprogram 
	CALL read_char ;Karakter beolvasása 
	CALL write_char ;Karakter kiírása 
	INT 21h 
main endp 
read_char proc ;Karakter beolvasása. A beolvasott karakter DL-be kerül 
	PUSH AX ;AX mentése a verembe 
	MOV AH, 1 ;AH-ba a beolvasás funkciókód 
	INT 21h ;Egy karakter beolvasása, a kód AL-be kerül 
	MOV DL, AL ;DL-be a karakter kódja 
	POP AX ;AX visszaállítása 
	CMP DX,	27  ; Compare the DX value with zero
	JE  L7      ; If yes, then jump to label L7
	RET ;Visszatérés a hívó rutinba 
	L7: MOV AH, 4Ch ;Kilépés
	END main
read_char endp 

write_char proc ;A DL-ben lévő karakter kiírása a képernyőre 
	PUSH AX ;AX mentése a verembe 
	MOV AH, 2 ; AH-ba a képernyőre írás funkciókódja 
	INT 21h ; Karakter kiírása 
	POP AX ;AX visszaállítása 
	RET ;Visszatérés a hívó rutinba 
write_char endp

END main