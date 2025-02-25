;******************************************************************************
; *
; Filename: CombinedInterrupt.asm *
; Date: February 25, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Interrupts to display either a six or a seven *
; Github: https://github.com/andrew1593571/RCET3375.git *
; *
;******************************************************************************
  
    INCLUDE PIC16F883CombinedInterruptSetup.inc
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
    GOTO CHECKPORTB	    
    GOTO RESETINTERRUPTS    ;ELSE RESET ALL INTERRUPTS
    
CHECKPORTB:
    BTFSC PORTB, RB0	    ;IF RB0 BUTTON IS PRESSED, DISPLAY SEVEN
    GOTO DISPLAYSEVEN
    BTFSC PORTB, RB1	    ;IF RB1 BUTTON IS PRESSED, DISPLAY SIX
    GOTO DISPLAYSIX
    
RESETINTERRUPTS:
    MOVWF STOREW	    ;STORE W INTO GENERAL REGISTER
    MOVF STATUS, 0	    ;MOVE STATUS REGISTER INTO W
    MOVWF STORESTATUS	    ;MOVE W INTO STORESTATUS REGISTER
    MOVLW B'10001000'	    ;CONFIGURE INTERRUPT CONTROL REGISTER TO DEFAULT
    MOVWF INTCON
    MOVF STORESTATUS, 0	    ;MOVE STORESTATUS INTO W REGISTER
    MOVWF STATUS	    ;MOVE W INTO THE STATUS REGISTER
    MOVF STOREW, 0	    ;RESTORE W REGISTER
    RETFIE
    
DISPLAYSEVEN: 
    RETFIE
    
DISPLAYSIX:
    RETFIE
    
MAIN:
    
    GOTO MAIN
    END