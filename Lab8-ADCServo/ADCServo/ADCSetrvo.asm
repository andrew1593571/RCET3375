;******************************************************************************
; *
; Filename: FileName.asm *
; Date: March 10, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Drives a servo to 255 different positions using the analog in *
; Github: https://github.com/andrew1593571/RCET3375.git *
; *
;******************************************************************************
  
    INCLUDE ADCServoSetup.inc
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
    BTFSC PIR1, ADIF
    GOTO ANALOGISR
    
    BTFSC PIR1, TMR2IF
    GOTO TMR2ISR
    
    RETFIE
    
ANALOGISR:
    BCF PIR1, ADIF	    ;CLEAR ADIF FLAG
    MOVF ADRESH, W
    MOVWF ANALOGSTORE	    ;STORE ANALOG RESULTS IN REGISTER
    BSF ADCON0, GO
    RETFIE
    
TMR2ISR:
    BCF PIR1, TMR2IF	    ;CLEAR TMR2IF
    DECFSZ COUNTLSB	    ;IF COUNTLSB IS NOT 0, RETFIE
    RETFIE
    DECFSZ COUNTMSB	    ;IF COUNTMSB IS NOT 0, RETFIE
    RETFIE
    
    BTFSS PORTC, RC0
    GOTO STARTPW
    
    BCF PORTC, RC0
    MOVLW H'13'
    MOVWF COUNTMSB
    MOVLW H'88'
    MOVWF COUNTLSB
    RETFIE
    
STARTPW:
    MOVF ADRESH, W
    ADDLW H'FA'
    MOVWF COUNTLSB
    BTFSC STATUS, 0
    MOVLW H'02'
    BTFSS STATUS, 0
    MOVLW H'01'
    MOVWF COUNTMSB
    BSF PORTC, RC0
    RETFIE
    
MAIN:
    GOTO MAIN
    END