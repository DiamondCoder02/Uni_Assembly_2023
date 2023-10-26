.MODEL SMALL 
.STACK 
.DATA 
adat DB "A" ;Egy bájt („A” kódjának) elhelyezése az adatszegmensre 
.CODE 
main proc 
	MOV AX, DGROUP ;Adatszegmens helyének lekérdezése 
	MOV DS, AX ;DS beállítása, hogy az adatszegmensre mutasson 
	LEA BX, adat ;Az adat offset címének betöltése BX-be 
	MOV DL, [BX] ;DL-be tölti a BX-el címzett memória tartalmát 
	CALL write_char ;Karakter kiírása 
	MOV AH,4Ch ;Visszatérés az operációs rendszerbe 
	INT 21h 
main endp 
