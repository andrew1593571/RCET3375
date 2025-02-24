;******************************************************************************
; *
; Filename: DisplayOne.asm *
; Date: February 24, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Displays a One on the Dot Matrix Display *
; Github: https://github.com/andrew1593571/RCET3375.git *
; *
;******************************************************************************
  
    INCLUDE PIC16F883Lab6Interrupts.inc
    
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