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
    
SETUP
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
    MOVLW H'20'
    MOVWF PORTC
    
    GOTO MAIN
    
MAIN
    
    END