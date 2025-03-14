;******************************************************************************
; *
; Filename: PICInterface.asm *
; Date: March 14, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Interfaces via UART to receive and execute commands *
; Github: https://github.com/andrew1593571/RCET3375.git *
; *
;******************************************************************************
  
    INCLUDE PICInterfaceSetup.inc
    #include "p16f883.inc"

; CONFIG1
; __config 0xE0FA
 __CONFIG _CONFIG1, _FOSC_HS & _WDTE_ON & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
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
    BTFSC PIR1, RCIF	    ;IF UART RECEIVE INTERRUPT, GOTO UARTRECEIVE ISR
    GOTO UARTRECEIVE
    
    BTFSC PIR1, TMR2IF	    ;IF TIMER2 INTERRUPT, GOTO TMR2ISR
    GOTO TMR2ISR
    
    RETFIE
    
UARTRECEIVE:
    
TMR2ISR:
    BCF PIR1, TMR2IF	    ;CLEAR TMR2IF
    DECFSZ COUNTLSB	    ;IF COUNTLSB IS NOT 0, RETFIE
    RETFIE
    DECFSZ COUNTMSB	    ;IF COUNTMSB IS NOT 0, RETFIE
    RETFIE
    
    BTFSS PORTC, RC0	    ;IF RC0 IS LOW, START THE PULSE WIDTH
    GOTO STARTPW
    
    BCF PORTC, RC0	    ;SET RC0 LOW
    MOVLW H'13'		    ;LOAD MSB OF PULSE SPACE COUNT
    MOVWF COUNTMSB	    
    MOVLW H'88'		    ;LOAD LSB OF PULSE SPACE COUNT
    MOVWF COUNTLSB
    RETFIE
    
STARTPW:
    MOVF SERVOPOS, W	    ;MOVE SERVOPOS INTO W, ADD 250
    ADDLW H'FA'
    MOVWF COUNTLSB	    ;MOVE W INTO COUNT LSB
    BTFSC STATUS, 0	    ;IF OVERFLOW, LOAD 2 INTO MSB
    MOVLW H'02'
    BTFSS STATUS, 0	    ;IF NO OVERFLOW, LOAD 1 INTO MSB
    MOVLW H'01'
    MOVWF COUNTMSB
    BSF PORTC, RC0	    ;SET PORTC
    RETFIE

    
MAIN:
    GOTO MAIN
    END