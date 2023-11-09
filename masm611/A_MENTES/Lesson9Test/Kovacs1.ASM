.MODEL SMALL 
.STACK 
.DATA 
adat_1 DB "First number",10,13,0
adat_2 DB "Second number",10,13,0
adat_3 DB "Letter please",10,13,0

number_1 DW 0
number_2 DW 0
letter DB "d"

.CODE 
main proc 
	MOV AX, DGROUP ;Adatszegmens beállítása 
	MOV DS, AX 

	LEA BX, adat_1 ;Az adat_1 címe BX-be 
	; CALL write_string ;Kiírás 
	; CALL read_char ;Karakter beolvasása 
	CALL cr_lf ;Soremelés

	LEA BX, adat_2 ;Az adat_2 címe BX-be 
	; CALL write_string ;Kiírás 
	; CALL read_char ;Karakter beolvasása 
	; Why corrupt package?
	CALL cr_lf ;Soremelés

	LEA BX, adat_3 ;Az adat_3 címe BX-be 
	CALL write_string ;Kiírás 
	CALL read_char ;Karakter beolvasása 
	CALL cr_lf ;Soremelés

	CALL screen
	MOV AH,4Ch ;Kilépés 
	INT 21h 
main endp

screen proc
	MOV AX, 0B800h ;Képernyő-memória szegmenscíme ES-be 
	MOV ES, AX ;Állítsuk be a képernyőt 80x25-ös felbontásra.
	MOV AH, 0h ;Képernyőüzemmód 
	MOV AL, 3h ;80x25-ös felbontás, színes üzemmód 
	INT 10H 
	MOV DI, 1838 ;Képernyő közepének ofszetcíme 
	MOV AL, letter ;Kiírandó karakter 
	MOV AH, 128+16*7+4  ;Színkód: szürke háttér, piros karakter, villog 
	MOV ES:[DI], AX ;Karakter beírása a képernyő-memóriába 
	MOV AH, 4Ch ;Kilépés 
	INT 21h
screen endp

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
	MOV letter, AL ;DL-be a karakter kódja 
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