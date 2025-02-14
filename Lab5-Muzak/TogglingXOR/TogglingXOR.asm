;******************************************************************************
; *
; Filename: FileName.asm *
; Date: February 14, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Sends toggling data out Port C b0, reads from Port B B0 *
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
    BANKSEL ANSELH  ;DISABLE ANALOG INPUTS ON PORT B
    MOVLW H'00'
    MOVWF ANSELH
    
    BANKSEL IOCB    ;DISABLE INTERRUPT ON CHANGE FOR PORT B
    MOVLW H'00'
    MOVWF IOCB
    
    BANKSEL PORTB   ;CLEAR PORT B, SET TRISTATE B TO INPUT
    CLRF PORTB	    
    BANKSEL TRISB
    MOVLW H'FF'
    MOVWF TRISB
    
    BANKSEL WPUB    ;DISABLE PORT B PULL-UPS
    MOVLW H'00'
    MOVWF WPUB
    
    BANKSEL PORTC   ;CLEAR PORT C, SET AS OUTPUTS
    CLRF PORTC
    BANKSEL TRISC
    MOVLW H'00'
    MOVWF TRISC
    
    BANKSEL PORTC   ;LOAD A HIGH INTO PORTC BIT 0
    MOVLW H'01'
    MOVWF PORTC
    
    CLRW	    ;CLEAR THE W REGISTER
    GOTO MAIN
    
MAIN:
    MOVLW H'01'	    ;MOVE 0x01 INTO THE W REGISTER
    XORWF PORTB,0   ;XOR THE W REGISTER WITH PORTB, STORING RESULT IN W
    MOVWF PORTC	    ;MOVE THE RESULTS INTO PORTC
    
    GOTO MAIN	    ;LOOP INDEFINITELY
    END
