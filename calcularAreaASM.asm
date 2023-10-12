    global calcularAreaASM
    section .text
calcularAreaASM: 
    ;el retorno es por xmm0
    ;rdi arrx , rsi arry, rdx nVertices
    ;usare xmm4,xmm5,xmm6,xmm7
    ; ademas de r8
    xorpd xmm0, xmm0
    xorpd xmm5,xmm5  ;valor parcial
    xorpd xmm4, xmm4
    xorpd xmm6, xmm6
    xorpd xmm7, xmm7
    xorpd xmm1, xmm1
    xorpd xmm2, xmm2
    xor r8,r8
    xor r9,r9
    mov r15 , 2
    cvtsi2sd xmm3, r15
    ;movsd xmm3, 2
    mov r13, rdx
    dec r13 ;uno menos que el final
calcular:
    cmp r8, rdx
    je fin
    cmp r8, r13
    je calculoEspecial
    mov r9, r8
    inc r9
    movsd xmm4, [ rdi + 8*r8]
    movsd xmm5, [rsi + 8*r9]
    mulsd xmm4, xmm5
    movsd xmm6, [rdi +8*r9]
    movsd xmm7, [rsi + 8*r8]
    mulsd xmm6, xmm7
    subsd xmm4, xmm6
    movsd xmm2, xmm4
    addsd xmm1, xmm2
    inc r8
    jmp calcular 




calculoEspecial: 
    movsd xmm4, [ rdi + 8*r8]
    movsd xmm5, [rsi]
    mulsd xmm4, xmm5
    movsd xmm6, [rdi]
    movsd xmm7, [rsi + 8*r8]
    mulsd xmm6, xmm7
    subsd xmm4, xmm6
    movsd xmm2, xmm4
    addsd xmm1, xmm2
    jmp fin
fin:
    divsd xmm1, xmm3
    movsd xmm0, xmm1
    ret
    