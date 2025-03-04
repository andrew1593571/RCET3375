;******************************************************************************
; *
; Filename: Stoplight.asm *
; Date: March 04, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Simulates a stoplight using switches and LEDs *
; Github: https://github.com/andrew1593571/RCET3375.git *
; *
;******************************************************************************
  
    INCLUDE StoplightSetup.inc
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
    GOTO INTERRUPT
    
SETUP:
    CALL INITIALIZE	    ;CALLS THE INITIALIZE SUBROUTINE IN INCLUDE FILE
    GOTO MAIN
    
INTERRUPT:
    BTFSC INTCON, RBIF	    ;IF INTERRUPT ON CHANGE, GOTO CHECKPORTB
    GOTO CHECKFORCARS
    
    BANKSEL PIR1
    BTFSC PIR1, TMR2IF	    ;IF INTERRUPT BY TIMER2, GOTO TIMERINT
    GOTO TIMERINT
    
    CALL CONFIGINT	    ;CALLS CONFIGINT FROM INCLUDE FOR UNKNOWN INTERRUPT
    RETFIE
    
CHECKFORCARS:  
    BCF INTCON, RBIF	    ;CLEAR THE RBIF FLAG
    
    BANKSEL PORTB
    BTFSC PORTB, RB0	    ;IF RB0 HIGH, SET NSCARS FLAG
    BSF LIGHTMODE, 7
    
    BTFSC PORTB, RB1	    ;IF RB1 HIGH, SET EWCARS FLAG
    BSF LIGHTMODE, 6
    RETFIE

TIMERINT:
    BCF PIR1, TMR2IF	    ;CLEAR THE TIMER2 FLAG
    
    BANKSEL INTCOUNT
    DECFSZ INTCOUNT	    ;DECREASE INTCOUNT, IF NOT 0, RETURN FROM INTERRUPT
    RETFIE
    
    MOVLW H'F0'		    ;RESET THE INTCOUNT
    MOVWF INTCOUNT
    
    BTFSC PORTC, RC0	    ;IF N/S IS GREEN, GOTO NSGREENLIGHT
    GOTO NSGREENLIGHT
    
    BTFSC PORTC, RC3	    ;IF E/W IS GREEN, GOTO EWGREENLIGHT
    GOTO EWGREENLIGHT
    
    BTFSC PORTC, RC1	    ;IF N/S IS YELLOW, GOTO NSYELLOWLIGHT
    GOTO NSYELLOWLIGHT
    
    BTFSC PORTC, RC4	    ;IF E/W IS YELLOW, GOTO EWYELLOWLIGHT
    GOTO EWYELLOWLIGHT
    
    GOTO SETUP		    ;IF NO CONDITIONS HAVE BEEN MET, ERROR, GOTO SETUP

NSGREENLIGHT:
    DECFSZ GRNCOUNT	    ;DECREASE GRNCOUNT, IF NOT 0, RETURN FROM INTERRUPT 
    RETFIE
    
    BTFSC LIGHTMODE, 6	    ;IF EWCARS FLAG IS SET, CHANGE TO YELLOW ON N/S
    GOTO NSGTOY
    BTFSS LIGHTMODE, 7	    ;ELSEIF NSCARS FLAG IS CLEARED, CHANGE TO YELLOW
    GOTO NSGTOY
    
    BCF LIGHTMODE, 7	    ;ELSE, CLEAR NSCARS FLAG, RESET GRNCOUNT, RETURN
    MOVLW H'05'
    MOVWF GRNCOUNT
    RETFIE
    
NSGTOY:			    ;NORTH SOUTH CHANGE FROM GREEN TO YELLOW
    BCF LIGHTMODE, 6	    ;CLEAR THE EWCARS FLAG
    BCF PORTC, RC0	    ;TURN OFF GREEN LIGHT
    BSF PORTC, RC1	    ;TURN ON YELLOW LIGHT
    RETFIE
    
EWGREENLIGHT:
    RETFIE
    
NSYELLOWLIGHT:
    RETFIE
    
EWYELLOWLIGHT:
    RETFIE
    
MAIN:
    GOTO MAIN
    END