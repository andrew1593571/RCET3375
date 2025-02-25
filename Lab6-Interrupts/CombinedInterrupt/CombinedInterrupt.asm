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
    
    GOTO MAIN
    END