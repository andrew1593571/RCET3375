;******************************************************************************
; *
; Filename: SubroutineDelay.asm *
; Date: February 07, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: 500ms Delay using Subroutine *
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

CBLOCK H'20'	    ;DEFINES A LIST OF CONSTANTS AT SPECIFIC ADDRESSES
    COUNT1	    ;ADDRESS 0x20
    COUNT2	    ;ADDRESS 0x21
    COUNT3	    ;ADDRESS 0x22
    COUNT4	    ;ADDRESS 0x23
    COUNT5	    ;ADDRESS 0x24
    COUNT6	    ;ADDRESS 0x25
ENDC
    
SETUP:
    BANKSEL PORTC   ;SELECT MEMORYBANK WITH PORTC
    CLRF PORTC	    ;CLEAR PORTC
    BANKSEL TRISC   ;SET TRISTATE C TO OUTPUT
    MOVLW H'00'
    MOVWF TRISC
    BANKSEL PORTC   ;WRITE 5 TO THE LED MATRIX
    MOVLW H'35'
    MOVWF PORTC
    CLRF COUNT1	    ;CLEAR COUNT REGISTERS
    CLRF COUNT2	    
    CLRF COUNT3	    
    CLRF COUNT4
    CLRF COUNT5
    CLRF COUNT6
    GOTO MAIN

    
DELAY:			    ;SUBROUTINE FOR ROUGHLY 500ms DELAY
    MOVLW H'81'		    ;SET COUNT2 TO 0x81
    MOVWF COUNT2
    MOVLW H'05'		    ;SET COUNT3 TO 0x05
    MOVWF COUNT3
    MOVLW H'04'		    ;SET THE COUNT5 TO 0x04
    MOVWF COUNT5
    MOVLW H'4F'		    ;SET THE COUNT6 TO 0x4F
    MOVWF COUNT6
    
DELAYPRIMARY:		    ;MAJORITY OF THE DELAY FOR ZERO
    DECFSZ COUNT1
    GOTO DELAYPRIMARY
    DECFSZ COUNT2
    GOTO DELAYPRIMARY
    MOVLW H'81'		    ;SET COUNT2 TO 0x81
    MOVWF COUNT2
    DECFSZ COUNT3
    GOTO DELAYPRIMARY
    
DELAYSECONDARY:		    ;FINER ADJUSTMENT THAN WITH PRIMARY
    DECFSZ COUNT4
    GOTO DELAYSECONDARY
    DECFSZ COUNT5
    GOTO DELAYSECONDARY
    
DELAYTERTIARY:		    ;DIALS IN THE DELAY TO THREE BELOW REQUIRED
    DECFSZ COUNT6
    GOTO DELAYTERTIARY
    RETURN
    

MAIN:
    MOVLW H'35'		    ;WRITE 5 TO THE DISPLAY
    MOVWF PORTC
    
    CALL DELAY		    ;CALL THE DELAY SUBROUTINE
    NOP			    ;NOP TO GET FROM THE GENERIC SUBROUTINE TO EXACT
    NOP
    NOP
        
    MOVLW H'30'		    ;WRITE 0 TO THE DISPLAY
    MOVWF PORTC
    
    CALL DELAY		    ;CALL THE DELAY SUBROUTINE
    NOP			    ;NOP TO GET FROM THE GENERIC SUBROUTINE TO EXACT
    
    GOTO MAIN		    ;LOOP INDEFINITELY
    END