
_interrupt:

;USB1.c,9 :: 		void interrupt(){
;USB1.c,10 :: 		USB_Interrupt_Proc();
	CALL        _USB_Interrupt_Proc+0, 0
;USB1.c,11 :: 		}
L_end_interrupt:
L__interrupt20:
	RETFIE      1
; end of _interrupt

_main:

;USB1.c,13 :: 		void main() {
;USB1.c,14 :: 		trisb = 0;
	CLRF        TRISB+0 
;USB1.c,15 :: 		portb = 0;
	CLRF        PORTB+0 
;USB1.c,16 :: 		ADCON1 = 0x0f;
	MOVLW       15
	MOVWF       ADCON1+0 
;USB1.c,17 :: 		CMCON = 7;
	MOVLW       7
	MOVWF       CMCON+0 
;USB1.c,19 :: 		HID_Enable(&readbuff, &writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;USB1.c,21 :: 		while(1){
L_main0:
;USB1.c,22 :: 		counter = 0;
	CLRF        _counter+0 
;USB1.c,23 :: 		while(!HID_Read());
L_main2:
	CALL        _HID_Read+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
	GOTO        L_main2
L_main3:
;USB1.c,24 :: 		for(i = 0; i < 4; i++){
	CLRF        _i+0 
L_main4:
	MOVLW       4
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;USB1.c,25 :: 		check[i] = readbuff[i];
	MOVLW       _check+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_check+0)
	MOVWF       FSR1H 
	MOVF        _i+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _readbuff+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FSR0H 
	MOVF        _i+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;USB1.c,24 :: 		for(i = 0; i < 4; i++){
	INCF        _i+0, 1 
;USB1.c,26 :: 		}
	GOTO        L_main4
L_main5:
;USB1.c,27 :: 		while(counter < 4){
L_main7:
	MOVLW       4
	SUBWF       _counter+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main8
;USB1.c,28 :: 		check[counter] = (char)toupper(check[counter]);
	MOVLW       _check+0
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_check+0)
	MOVWF       FLOC__main+1 
	MOVF        _counter+0, 0 
	ADDWF       FLOC__main+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__main+1, 1 
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_toupper_character+0 
	CALL        _toupper+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;USB1.c,29 :: 		counter++;
	INCF        _counter+0, 1 
;USB1.c,30 :: 		}
	GOTO        L_main7
L_main8:
;USB1.c,31 :: 		if(check[0] == 'U' && check[1] == 'P')
	MOVF        _check+0, 0 
	XORLW       85
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
	MOVF        _check+1, 0 
	XORLW       80
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
L__main18:
;USB1.c,32 :: 		portb++;
	MOVF        PORTB+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       PORTB+0 
	GOTO        L_main12
L_main11:
;USB1.c,33 :: 		else if (check[0] == 'D' && check[1] == 'O' && check[2] == 'W' && check[3] == 'N')
	MOVF        _check+0, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
	MOVF        _check+1, 0 
	XORLW       79
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
	MOVF        _check+2, 0 
	XORLW       87
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
	MOVF        _check+3, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
L__main17:
;USB1.c,34 :: 		portb--;
	DECF        PORTB+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       PORTB+0 
	GOTO        L_main16
L_main15:
;USB1.c,35 :: 		else;
L_main16:
L_main12:
;USB1.c,38 :: 		}
	GOTO        L_main0
;USB1.c,40 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
