.MODEL SMALL 
.STACK 
.CODE 
main proc ;Főprogram 
	CALL read_binary ;Karakter beolvasása 
	XOR DH, DH ;DH törlése 
	CALL cr_lf ;Soremelés 
	CALL write_binary ;Karakterkód konvertálása bináris számmá és kiírása a képernyőre 
	MOV AH,4Ch ;Kilépés 
	INT 21h 
main endp
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
write_binary proc ;kiírandó adat a DL-ben 
	PUSH BX ;BX mentése a verembe 
	PUSH CX ;CX mentése a verembe 
	PUSH DX ;DX mentése a verembe 
	MOV BL, DL ;DL másolása BL-be 
	MOV CX, 8 ;Ciklusváltozó (CX) beállítása 
binary_digit: 
	XOR DL, DL ;DL törlése 
	RCL BL, 1 ;Rotálás balra eggyel, kilépő bit a CF-be 
	ADC DL, "0" ;DL = DL + 48 + CF 
	CALL write_char ;Bináris digit kiírása 
	LOOP binary_digit ;Vissza a ciklus elejére 
	POP DX ;DX visszaállítása 
	POP CX ;CX visszaállítása 
	POP BX ;BX visszaállítása 
	RET ;Visszatérés a hívó rutinba 
write_binary endp
read_char proc ;Karakter beolvasása. A beolvasott karakter DL-be kerül 
	PUSH AX ;AX mentése a verembe 
	MOV AH, 1 ;AH-ba a beolvasás funkciókód 
	INT 21h ;Egy karakter beolvasása, a kód AL-be kerül 
	MOV DL, AL ;DL-be a karakter kódja 
	POP AX ;AX visszaállítása 
	RET ;Visszatérés a hívó rutinba 
read_char endp
write_char proc ;A DL-ben lévő karakter kiírása a képernyőre 
	PUSH AX ;AX mentése a verembe 
	MOV AH, 2 ; AH-ba a képernyőre írás funkciókódja 
	INT 21h ; Karakter kiírása 
	POP AX ;AX visszaállítása 
	RET ;Visszatérés a hívó rutinba 
write_char endp
read_binary proc
	PUSH AX ;AX mentése a verembe
	XOR AX, AX ;AX törlése
read_binary_new:
	CALL read_char ;Egy karakter beolvasása
	CMP DL, CR ;ENTER ellenőrzése
	JE read_binary_end ;Vége, ha ENTER volt az utolsó karakter
	SUB DL, "0" ;Karakterkód minusz ”0” kódja
	SAL AL, 1 ;Szorzás 2-vel, shift eggyel balra
	ADD AL, DL ;A következő helyi érték hozzáadása
	JMP read_binary_new ;A következő karakter beolvasása
read_binary_end:
	MOV DL, AL ;DL-be a beírt szám
	POP AX ;AX visszaállítása
	RET ;Visszatérés a hívó rutinba
read_binary endp
END 
