;******************************************************************************
; *
; Filename: DipSwitchDisplay.asm *
; Date: February 03, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: Display Number on LED Matrix using DIP Switches *
; *
;******************************************************************************
  
#include "p16f883.inc"

; CONFIG1
; __config 0xE0F1
 __CONFIG _CONFIG1, _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

    ORG H'000'
    GOTO SETUP
    
    ORG H'004'
    RETFIE
    
SETUP
    BANKSEL ANSELH  ;DISABLE ANALOG INPUTS ON PORT B
    MOVLW H'00'
    MOVWF ANSELH
    
    BANKSEL IOCB    ;DISABLE INTERRUPT ON CHANGE FOR PORT B
    MOVLW H'00'
    MOVWF IOCB
    
    BANKSEL PORTB   ;CLEAR PORT B, SET TRISTATE B TO INPUT
    CLRF PORTB	    
    BANKSEL TRISB
    MOVLW H'FF'
    MOVWF TRISB
    
    BANKSEL WPUB    ;ENABLE PORT B PULL-UPS
    MOVLW H'FF'
    MOVWF WPUB
    
    BANKSEL PORTC   ;CLEAR PORT C, SET AS OUTPUTS, SET DISPLAY BLANK
    CLRF PORTC
    BANKSEL TRISC
    MOVLW H'00'
    MOVWF TRISC
    BANKSEL PORTC
    MOVLW H'20'
    MOVWF PORTC
    
    GOTO MAIN
    
DISPLAYZERO	    ;DISPLAY A ZERO ON THE DOT MATRIX
    BANKSEL PORTC
    MOVLW H'30'
    MOVWF PORTC
    GOTO MAIN
    
DISPLAYONE	    ;DISPLAY A ONE
    BANKSEL PORTC
    MOVLW H'31'
    MOVWF PORTC
    GOTO MAIN
    
DISPLAYTWO	    ;DISPLAY A TWO
    BANKSEL PORTC
    MOVLW H'32'
    MOVWF PORTC
    GOTO MAIN
    
DISPLAYTHREE	    ;DISPLAY A THREE
    BANKSEL PORTC
    MOVLW H'33'
    MOVWF PORTC
    GOTO MAIN
    
DISPLAYFOUR	    ;DISPLAY A FOUR
    BANKSEL PORTC
    MOVLW H'34'
    MOVWF PORTC
    GOTO MAIN
    
DISPLAYFIVE	    ;DISPLAY A FIVE
    BANKSEL PORTC
    MOVLW H'35'
    MOVWF PORTC
    GOTO MAIN
    
DISPLAYSIX	    ;DISPLAY A SIX
    BANKSEL PORTC
    MOVLW H'36'
    MOVWF PORTC
    GOTO MAIN
    
DISPLAYSEVEN	    ;DISPLAY A SEVEN
    BANKSEL PORTC
    MOVLW H'37'
    MOVWF PORTC
    GOTO MAIN
    
DISPLAYEIGHT	    ;DISPLAY AN EIGHT
    BANKSEL PORTC
    MOVLW H'38'
    MOVWF PORTC
    GOTO MAIN
    
MAIN
    BTFSS PORTB, 7
    GOTO DISPLAYEIGHT
    BTFSS PORTB, 6
    GOTO DISPLAYSEVEN
    BTFSS PORTB, 5
    GOTO DISPLAYSIX
    BTFSS PORTB, 4
    GOTO DISPLAYFIVE
    BTFSS PORTB, 3
    GOTO DISPLAYFOUR
    BTFSS PORTB, 2
    GOTO DISPLAYTHREE
    BTFSS PORTB, 1
    GOTO DISPLAYTWO
    BTFSS PORTB, 0
    GOTO DISPLAYONE
    
    GOTO DISPLAYZERO
    
    GOTO MAIN
    END