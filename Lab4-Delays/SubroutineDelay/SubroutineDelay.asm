;******************************************************************************
; *
; Filename: SubroutineDelay.asm *
; Date: February 07, 2025 *
; Author: Andrew Keller *
; Company: Idaho State University *
; Description: 500ms Delay using Subroutine *
; Github: https://github.com/andrew1593571/RCET3375.git *
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

