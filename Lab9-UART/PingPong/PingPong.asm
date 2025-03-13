;******************************************************************************
; *
; Filename: PingPong.asm *
; Date: March 13, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Receives UART, transmits the received bits via UART *
; Github: https://github.com/andrew1593571/RCET3375.git *
; *
;******************************************************************************
  
    INCLUDE PingPongSetup.inc
    
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