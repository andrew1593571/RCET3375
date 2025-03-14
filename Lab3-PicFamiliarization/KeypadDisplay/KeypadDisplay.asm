;******************************************************************************
; *
; Filename: KeypadDisplay.asm *
; Date: February 03, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Displays a number or letter on the LED matrix using 4x4 keypad *
; *
;******************************************************************************
  
#include "p16f883.inc"

; CONFIG1
; __config 0xE0F1
 __CONFIG _CONFIG1, _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

 
    ORG H'000'
    GOTO SETUP
    
    ORG H'004'
    RETFIE
    
SETUP:
    BANKSEL ANSELH  ;DISABLE ANALOG INPUTS ON PORT B
    MOVLW H'00'
    MOVWF ANSELH
    BANKSEL IOCB    ;DISABLE INTERRUPT ON CHANGE FOR PORT B
    MOVLW H'00'
    MOVWF IOCB
    BANKSEL PORTB   ;CLEAR PORT B
    CLRF PORTB	    
    BANKSEL TRISB   ;SET TRISTATE B TO OUTPUT FOR 0-3 AND INPUT FOR 4-7
    MOVLW H'F0'
    MOVWF TRISB
    BANKSEL WPUB    ;DISABLE PORT B PULL-UPS
    MOVLW H'00'
    MOVWF WPUB
    
    BANKSEL PORTC   ;CLEAR PORT C, SET AS OUTPUTS, SET DISPLAY BLANK
    CLRF PORTC
    BANKSEL TRISC   ;SET TRISTATE C TO OUTPUT
    MOVLW H'00'
    MOVWF TRISC
    BANKSEL PORTC   ;WRITE A BLANK TO THE LED MATRIX
    MOVLW H'3F'
    MOVWF PORTC
    
    GOTO MAIN

DIS_ASTERISK	    ;WRITE AN ASTERISK TO THE LED MATRIX
    MOVLW H'2A'
    MOVWF PORTC
    GOTO MAIN
    
DIS_POUND	    ;WRITE A POUND TO THE LED MATRIX
    MOVLW H'23'
    MOVWF PORTC
    GOTO MAIN
    
DIS_A		    ;WRITE A TO THE LED MATRIX
    MOVLW H'41'
    MOVWF PORTC
    GOTO MAIN
    
DIS_B		    ;WRITE B TO THE LED MATRIX
    MOVLW H'42'
    MOVWF PORTC
    GOTO MAIN
    
DIS_C		    ;WRITE C TO THE LED MATRIX
    MOVLW H'43'
    MOVWF PORTC
    GOTO MAIN
    
DIS_D		    ;WRITE D TO THE LED MATRIX
    MOVLW H'44'
    MOVWF PORTC
    GOTO MAIN
    
DIS_0		    ;WRITE 0 TO THE LED MATRIX
    MOVLW H'30'
    MOVWF PORTC
    GOTO MAIN
    
DIS_1		    ;WRITE 1 TO THE LED MATRIX
    MOVLW H'31'
    MOVWF PORTC
    GOTO MAIN
    
DIS_2		    ;WRITE 2 TO THE LED MATRIX
    MOVLW H'32'
    MOVWF PORTC
    GOTO MAIN
    
DIS_3		    ;WRITE 3 TO THE LED MATRIX
    MOVLW H'33'
    MOVWF PORTC
    GOTO MAIN
    
DIS_4		    ;WRITE 4 TO THE LED MATRIX
    MOVLW H'34'
    MOVWF PORTC
    GOTO MAIN
    
DIS_5		    ;WRITE 0 TO THE LED MATRIX
    MOVLW H'35'
    MOVWF PORTC
    GOTO MAIN
    
DIS_6		    ;WRITE 6 TO THE LED MATRIX
    MOVLW H'36'
    MOVWF PORTC
    GOTO MAIN
    
DIS_7		    ;WRITE 7 TO THE LED MATRIX
    MOVLW H'37'
    MOVWF PORTC
    GOTO MAIN
    
DIS_8		    ;WRITE 8 TO THE LED MATRIX
    MOVLW H'38'
    MOVWF PORTC
    GOTO MAIN
    
DIS_9		    ;WRITE 9 TO THE LED MATRIX
    MOVLW H'39'
    MOVWF PORTC
    GOTO MAIN
    
MAIN
    BANKSEL PORTB   ;SELECT BANK 0
    CLRF PORTB	    ;CLEAR PORT B
    BSF PORTB, 0    ;SET RB0
    
    BTFSC PORTB, 4  ;CHECK C0
    GOTO DIS_1
    BTFSC PORTB, 5  ;CHECK C1
    GOTO DIS_2
    BTFSC PORTB, 6  ;CHECK C2
    GOTO DIS_3
    BTFSC PORTB, 7  ;CHECK C3
    GOTO DIS_A
    
    BCF PORTB, 0    ;CLEAR RB0
    BSF PORTB, 1    ;SET RB1
    
    BTFSC PORTB, 4  ;CHECK C0
    GOTO DIS_4
    BTFSC PORTB, 5  ;CHECK C1
    GOTO DIS_5
    BTFSC PORTB, 6  ;CHECK C2
    GOTO DIS_6
    BTFSC PORTB, 7  ;CHECK C3
    GOTO DIS_B
    
    BCF PORTB, 1    ;CLEAR RB1
    BSF PORTB, 2    ;SET RB2
    
    BTFSC PORTB, 4  ;CHECK C0
    GOTO DIS_7
    BTFSC PORTB, 5  ;CHECK C1
    GOTO DIS_8
    BTFSC PORTB, 6  ;CHECK C2
    GOTO DIS_9
    BTFSC PORTB, 7  ;CHECK C3
    GOTO DIS_C
    
    BCF PORTB, 2    ;CLEAR RB2
    BSF PORTB, 3    ;SET RB3
    
    BTFSC PORTB, 4  ;CHECK C0
    GOTO DIS_ASTERISK
    BTFSC PORTB, 5  ;CHECK C1
    GOTO DIS_0
    BTFSC PORTB, 6  ;CHECK C2
    GOTO DIS_POUND
    BTFSC PORTB, 7  ;CHECK C3
    GOTO DIS_D
    
    GOTO MAIN
    END