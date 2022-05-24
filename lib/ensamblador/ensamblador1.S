/**
 * Referencias importantes:
 * https://developer.arm.com/documentation/dui0552/a
 * https://github.com/ARM-software/abi-aa/tree/main/aapcs32
 */
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.macro defun nombre
    .section .text.\nombre
    .global \nombre
    .type \nombre, %function
\nombre:
.endm

.macro endfun nombre
    .size \nombre, . - \nombre
.endm

defun copiaMemoria
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitud
0:
    cmp     R2,#0
    beq     1f
    ldrb    R3,[R0],#1
    strb    R3,[R1],#1
    subs    R2,#1
    b       0b
1:
    bx lr
endfun copiaMemoria

defun copiaCadena
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitudMaxima
0:
    cmp     R2,#0
    beq     1f
    ldrb    R3,[R0],#1
    cmp     R3,0x00
    beq     2f
    strb    R3,[R1],#1
    subs    R2,#1
    b       0b

1:  
    subs    R1,#1
2:
    mov     R3,0x00
    strb    R3,[R1]
    bx lr
endfun copiaCadena

defun mayusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
0:
    cmp     R2,#0
    beq     2f

    ldrb    R2,[R0],#1
    mov     R3,R2
    bics    R3,0x0F
    cmp     R3,0x60
    beq     1f
    subs    R2,#1
    b       0b
1:
    bics    R2,0xF0
    orr     R2,0x40
    subs    R0,#1
    strb    R2,[R0]
    b       0b
2:
    bx      lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
0:
    cmp     R2,#0
    beq     2f

    ldrb    R2,[R0],#1
    mov     R3,R2
    bics    R3,0x0F
    cmp     R3,0x40
    beq     1f
    subs    R2,#1
    b       0b
1:
    bics    R2,0xF0
    orr     R2,0x60
    subs    R0,#1
    strb    R2,[R0]
    b       0b
2:
    bx      lr
endfun minusculaEnLugar
