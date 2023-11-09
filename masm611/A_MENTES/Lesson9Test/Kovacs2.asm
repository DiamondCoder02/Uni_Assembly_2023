.MODEL SMALL 
.STACK 
.DATA 
adat_1 DB "First number to multiply",10,13,0
adat_2 DB "Second number",10,13,0
adat_3 DB "Third number",10,13,0

number_1 DW 2
number_2 DW 3
number_3 DW 4

.CODE 
main proc 
	MOV AX, DGROUP ;Adatszegmens beállítása 
	MOV DS, AX 
	LEA BX, adat_1 ;Az adat_1 címe BX-be 
	CALL write_string ;Kiírás 
	CALL read_decimal ;Karakter beolvasása 
	CALL cr_lf ;Soremelés

	LEA BX, adat_2 ;Az adat_2 címe BX-be 
	CALL write_string ;Kiírás
	CALL read_decimal ;Karakter beolvasása 
	CALL cr_lf ;Soremelés

	LEA BX, adat_3 ;Az adat_3 címe BX-be 
	CALL write_string ;Kiírás 
	CALL read_decimal ;Karakter beolvasása 
	CALL cr_lf ;Soremelés

	MOV AH,4Ch ;Kilépés 
	INT 21h 
main endp

read_decimal proc 
	PUSH AX ;AX mentése a verembe 
	PUSH BX ;BX mentése a verembe 
	MOV BL, 10 ;BX-be a számrendszer alapszáma, ezzel szorzunk 
	XOR AX, AX ;AX törlése 
read_decimal_new: 
	CALL read_char ;Egy karakter beolvasása 
	CMP DL, CR ;ENTER ellenőrzése 
	JE read_decimal_end ;Vége, ha ENTER volt az utolsó karakter 
	SUB DL, "0" ;Karakterkód minusz ”0” kódja 
	MUL BL ;AX szorzása 10-zel 
	ADD AL, DL ;A következő helyi érték hozzáadása 
	JMP read_decimal_new ;A következő karakter beolvasása 
read_decimal_end: 
	MOV DL, AL ;DL-be a beírt szám 
	POP BX ;AB visszaállítása 
	POP AX ;AX visszaállítása 
	RET ;Visszatérés a hívó rutinba 
read_decimal endp

CR EQU 13 ;CR-be a kurzor a sor elejére kód 
LF EQU 10 ;LF-be a kurzor új sorba kód 
cr_lf proc 
	PUSH DX ;DX mentése a verembe 
	MOV DL, CR 
	CALL write_char ;kurzor a sor elejére 
	MOV DL, LF 
	CALL write_char ;Kurzor egy sorral lejjebb 
	POP DX ;DX visszaállítása 
	RET ;Visszatérés a hívó rutinba 
cr_lf endp

read_char proc ;Karakter beolvasása. A beolvasott karakter DL-be kerül 
	PUSH AX ;AX mentése a verembe 
	MOV AH, 1 ;AH-ba a beolvasás funkciókód 
	INT 21h ;Egy karakter beolvasása, a kód AL-be kerül 
	MOV DL, AL ;DL-be a karakter kódja 
	POP AX ;AX visszaállítása 
	RET ;Visszatérés a hívó rutinba 
read_char endp

write_string proc ;BX-ben címzett karaktersorozat kiírása 0 kódig. 
	PUSH DX ;DX mentése a verembe 
	PUSH BX ;BX mentése a verembe 
write_string_new: 
	MOV DL, [BX]  ;DL-be egy karakter betöltése 
	OR DL, DL ;DL vizsgálata 
	JZ write_string_end ;0 esetén kilépés 
	CALL write_char ;Karakter kiírása 
	INC BX ;BX a következő karakterre mutat 
	JMP write_string_new ;A következő karakter betöltése 
write_string_end: 
	POP BX ;BX visszaállítása 
	POP DX ;DX visszaállítása 
	RET ;Visszatérés 
write_string endp

write_char proc ;A DL-ben lévő karakter kiírása a képernyőre 
	PUSH AX ;AX mentése a verembe 
	MOV AH, 2 ; AH-ba a képernyőre írás funkciókódja 
	INT 21h ; Karakter kiírása 
	POP AX ;AX visszaállítása 
	RET ;Visszatérés a hívó rutinba 
write_char endp

END main