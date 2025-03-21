;******************************************************************************
; *
; Filename: EEPROMRecording.asm *
; Date: March 21, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: When the record button is pressed, 10 keypad buttons are
                recorded and stored in EEPROM for playback when play pressed *
; Github: https://github.com/andrew1593571/RCET3375.git *
; *
;******************************************************************************
  
    INCLUDE EEPROMRecordingSetup.inc
    
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