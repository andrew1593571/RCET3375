;******************************************************************************
; *
; Filename: EEPROMRecording.asm *
; Date: March 21, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: When the record button is pressed, 10 keypad buttons are
;                recorded and stored in EEPROM for playback when play pressed *
; Github: https://github.com/andrew1593571/RCET3375.git *
; *
;******************************************************************************
  
    INCLUDE EEPROMRecordingSetup.inc
    #include "p16f883.inc"

; CONFIG1
; __config 0xE0F2
 __CONFIG _CONFIG1, _FOSC_HS & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
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
    BTFSC INTCON, RBIF
    GOTO IOCISR
    BANKSEL PIR1
    BTFSC PIR1, TMR2IF
    GOTO TMR2ISR
    RETFIE
    
IOCISR:
    RETFIE
    
TMR2ISR:
    RETFIE
    
MAIN:
    
    GOTO MAIN
    END