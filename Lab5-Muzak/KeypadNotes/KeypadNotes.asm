;******************************************************************************
; *
; Filename: KeypadNotes.asm *
; Date: February 14, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Plays a different note with each button on a keypad *
; Github: https://github.com/andrew1593571/RCET3375.git *
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
    BANKSEL ANSEL	;DISABLE ANALOG INPUTS ON PORTA
    MOVLW H'00'
    MOVWF ANSEL
    BANKSEL PORTA	;CLEAR PORT A
    CLRF PORTA
    BANKSEL TRISA	;SET PORT A AS OUTPUTS
    MOVLW H'00'
    MOVWF TRISA
    
    BANKSEL ANSELH	;DISABLE ANALOG INPUTS ON PORTB
    MOVLW H'00'
    MOVWF ANSELH
    BANKSEL IOCB	;DISABLE INTERRUPT ON CHANGE
    MOVLW H'00'
    MOVWF IOCB
    BANKSEL WPUB	;DISABLE PORTB WEAK PULL-UPS
    MOVLW H'00'
    MOVWF WPUB
    BANKSEL PORTB	;CLEAR PORTB
    CLRF PORTB
    BANKSEL TRISB	;SET RB0..RB3 AS OUTPUTS, RB4..RB7 AS INPUTS
    MOVLW H'F0'
    MOVWF TRISB
    
    BANKSEL PORTB	;SELECT BANK 0
    GOTO MAIN
    
MAIN:
    
    GOTO MAIN
    END