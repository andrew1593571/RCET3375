;******************************************************************************
; *
; Filename: PIC16F883CombinedInterruptSetup.inc *
; Date: February 25, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Defines registers, bits, and constants. Configures SF registers *
; Github: https://github.com/andrew1593571/RCET3375.git *
; *
;******************************************************************************
  
;***********************************************
;DEFINE GENERAL FUNCTION REGISTERS
;***********************************************

STOREW EQU H'20'	    ;USED TO STORE W FOR GENERAL INTERRUPTS
STORESTATUS EQU H'21'	    ;USED TO STORE STATUS FOR GENERAL INTERRUPTS
STOREW_SEVEN EQU H'22'	    ;USED TO STORE W DURING SEVEN INTERRUPT
STORESTATUS_SEVEN EQU H'23' ;USED TO STORE STATUS DURING SEVEN INTERRUPT
STOREW_SIX EQU H'24'	    ;USED TO STORE W DURING SIX INTERRUPT
STORESTATUS_SIX EQU H'25'   ;USED TO STORE STATUS DURING SIX INTERRUPT
SEVENCOUNTA EQU H'26'	    ;SEVEN DELAY COUNTA
SEVENCOUNTB EQU H'27'	    ;SEVEN DELAY COUNTB
SEVENCOUNTC EQU H'28'	    ;SEVEN DELAY COUNTC
SIXCOUNTA EQU H'29'	    ;SIX DELAY COUNTA
SIXCOUNTB EQU H'2A'	    ;SIX DELAY COUNTB
SIXCOUNTC EQU H'2B'	    ;SIX DELAY COUNTC

;***********************************************
;INITIALIZE PIC16F883 AND SETUP
;***********************************************

SETUP_CODE CODE	    ;START OF THE FILE
    
INITIALIZE:

;----------PORTA CONFIGURATION----------
    BANKSEL ANSEL
    MOVLW B'00000000'	;CONFIGURE PORTA ANALOG INPUTS
    MOVWF ANSEL
    
    BANKSEL TRISA
    MOVLW B'00000000'	;CONFIGURE PORTA TRISTATE BUFFER
    MOVWF TRISA
    
    BANKSEL PORTA
    CLRF PORTA		;CLEAR PORTA TO A KNOWN STATE
    
;----------PORTB CONFIGURATION----------
    BANKSEL ANSELH
    MOVLW B'00000000'	;CONFIGURE PORTB ANALOG INPUTS
    MOVWF ANSELH
    
    BANKSEL IOCB
    MOVLW B'00000011'	;CONFIGURE PORTB INTERRUPT ON CHANGE FOR EACH PIN
    MOVWF IOCB
    
    BANKSEL TRISB
    MOVLW B'00000011'	;CONFIGURE PORTB TRISTATE BUFFER
    MOVWF TRISB
    
    BANKSEL WPUB
    MOVLW B'00000000'	;CONFIGURE PORTB WEAK PULL UPS
    MOVWF WPUB
    
    BANKSEL PORTB
    CLRF PORTB		;CLEAR PORTB TO A KNOWN STATE

;----------PORTC CONFIGURATION----------
    BANKSEL TRISC
    MOVLW B'00000000'	;CONFIGURE PORTC TRISTATE BUFFER
    MOVWF TRISC
    
    BANKSEL PORTC
    CLRF PORTC		;CLEAR PORTC TO A KNOWN STATE
        
;----------INTERRUPT CONFIGURATION----------
    BANKSEL INTCON
    MOVLW B'10001000'	;CONFIGURE INTERRUPT CONTROL REGISTER
    MOVWF INTCON
    
    RETURN