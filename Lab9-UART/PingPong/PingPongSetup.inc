;******************************************************************************
; *
; Filename: PingPongSetup.inc *
; Date: March 13, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Defines registers, bits, and constants. Configures SF registers *
; Github: https://github.com/andrew1593571/RCET3375.git *
; *
;******************************************************************************
  

;***********************************************
;DEFINE GENERAL FUNCTION REGISTERS
;***********************************************

;REGISTERNAME EQU H'0020;    ;COMMENT HERE


;***********************************************
;DEFINE CONSTANTS
;***********************************************

;CONSTANTNAME EQU H'00'    ;COMMENT HERE


;***********************************************
;DEFINE PIN/BIT LABELS
;******************se*****************************

;PINNAME EQU H'000X'	;COMMENT HERE
    ;USE THESE BIT NAMES BY USING "REGISTERNAME, PINNAME" IN OPERANDS


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
    MOVLW B'00000000'	;CONFIGURE PORTB INTERRUPT ON CHANGE FOR EACH PIN
    MOVWF IOCB
    
    BANKSEL TRISB
    MOVLW B'00000000'	;CONFIGURE PORTB TRISTATE BUFFER
    MOVWF TRISB
    
    BANKSEL WPUB
    MOVLW B'00000000'	;CONFIGURE PORTB WEAK PULL UPS
    MOVWF WPUB
    
    BANKSEL PORTB
    CLRF PORTB		;CLEAR PORTB TO A KNOWN STATE

;----------PORTC CONFIGURATION----------
    BANKSEL TRISC
    MOVLW B'00000001'	;CONFIGURE PORTC TRISTATE BUFFER
    MOVWF TRISC
    
    BANKSEL PORTC
    CLRF PORTC		;CLEAR PORTC TO A KNOWN STATE
    
;----------UART CONFIGURATION----------
    BANKSEL BAUDCTL
    CLRF BAUDCTL
    
    BANKSEL SPBRG
    MOVLW H'81'
    MOVWF SPBRG
    CLRF SPBRGH
    
    MOVLW H'24'
    MOVWF TXSTA
    BANKSEL RCSTA
    MOVLW H'90'
    MOVWF RCSTA
    
;----------INTERRUPTS CONFIGURATION----------
    MOVLW H'40'	    ;ENABLE PERIPHERAL INTERRUPTS
    MOVWF INTCON
    
    BANKSEL PIE1    ;ENABLE UART RECEIVE INTERRUPT
    MOVLW H'20'
    MOVWF PIE1
    
    CLRF PIE2	    ;DISABLE ALL OTHER PERIPHERAL INTERRUPTS
    
    BSF INTCON, GIE ;ENABLE GLOBAL INTERRUPTS
    
    RETURN