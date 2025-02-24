;******************************************************************************
; *
; Filename: PIC16F883Setup.inc *
; Date: February 21, 2025 *
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
    MOVLW B'11111111'	;CONFIGURE PORTA TRISTATE BUFFER
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
    MOVLW B'00000000'	;CONFIGURE PORTC TRISTATE BUFFER
    MOVWF TRISC
    
    BANKSEL PORTC
    CLRF PORTC		;CLEAR PORTC TO A KNOWN STATE
    
    
    RETURN