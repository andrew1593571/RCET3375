;******************************************************************************
; *
; Filename: SixInterrupt.asm *
; Date: February 25, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: INPUT DESCRIPTION HERE *
; Github: https://github.com/andrew1593571/RCET3375.git *
; *
;******************************************************************************
  
    INCLUDE PIC16F883SixInterruptSetup.inc
    
    ;#####____TODO ADD CONFIGURATION BITS____#####
    
    ORG H'000'
    GOTO SETUP
    
    ORG H'004'
    GOTO INTERRUPT
    
SETUP:
    CALL INITIALIZE	    ;CALLS THE INITIALIZE SUBROUTINE IN INCLUDE FILE
    GOTO MAIN
    
INTERRUPT:
    RETFIE
    
MAIN:
    MOVLW H'31'
    MOVWF PORTC
    
    GOTO MAIN
    END