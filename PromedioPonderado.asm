section .data
    ;Mensajes
    firstMsg db "Peso de las practicas: "
    lenf equ $ - firstMsg
    secondMsg db "Peso de los laboratorios: "
    lens equ $ - secondMsg
    thirdMsg db "Peso del examen parcial: "
    lent equ $ - thirdMsg
    fourthMsg db "Peso del examen final: "
    lenfo equ $ - fourthMsg
    fifthMsg db "Nota final calculada: "
    lenfi equ $ - fifthMsg

    ;arreglos
    arreglosPesos times 4 dq 0
    arreglosNotas dq 15, 12, 18, 15

    ;auxiliares
    solution dq 0
    char dq 0 

    ;pesos 
    pesoPractica dq 0
    pesoLaboratorio dq 0
    pesoExamenParcial dq 0
    pesoExamenFinal dq 0

section .text
    global _start

_start:
    ;escritura
    mov rax, 1
    mov rdi, 1
    mov rsi, firstMsg
    mov rdx, lenf
    syscall

    ;lectura
    mov rax, 0
    mov rdi, 0
    mov rsi, pesoPractica
    mov rdx, 1
    syscall

    mov rax,0
    mov rdi, 0
    mov rsi, char
    mov rdx, 1
    syscall

    ;escritura
    mov rax, 1
    mov rdi, 1
    mov rsi, secondMsg
    mov rdx, lens
    syscall

    ;lectura
    mov rax, 0
    mov rdi, 0
    mov rsi, pesoLaboratorio
    mov rdx, 1
    syscall

    ;escritura
    mov rax, 1
    mov rdi, 1
    mov rsi, thirdMsg
    mov rdx, lent
    syscall

    ;lectura
    mov rax, 0
    mov rdi, 0
    mov rsi, pesoExamenParcial
    mov rdx, 1
    syscall

    mov rax,0
    mov rdi, 0
    mov rsi, char
    mov rdx, 1
    syscall

    ;escritura
    mov rax, 1
    mov rdi, 1
    mov rsi, fourthMsg
    mov rdx, lenfo
    syscall

    ;lectura
    mov rax, 0
    mov rdi, 0
    mov rsi, pesoExamenFinal
    mov rdx, 1
    syscall

    mov rax,0
    mov rdi, 0
    mov rsi, char
    mov rdx, 1
    syscall

    ;resultadofinal
    mov rax, 1
    mov rdi, 1
    mov rsi, fifthMsg
    mov rdx, lenfi
    syscall

    ;limpiamos registro
    xor rax,rax
    xor rbx,rbx
    xor rcx,rcx
    xor rdx,rdx

inicio:
    ;recordemos que por haberlos declarado dq son 8 bytes
    mov rcx, [pesoPractica]
    sub rcx, 30H  ; para conservar el valor numerico
    mov  [arreglosPesos], rcx
    mov rcx, [pesoLaboratorio]
    sub rcx, 30H  ; para conservar el valor numerico
    mov  [arreglosPesos+8], rcx
    mov rcx, [pesoExamenParcial]
    sub rcx, 30H  ; para conservar el valor numerico
    mov  [arreglosPesos+16], rcx
    mov rcx, [pesoExamenFinal+24]
    sub rcx, 30H  ; para conservar el valor numerico
    mov  [arreglosPesos], rcx

    ;se inicializan las variables
    mov r8,0   ;int sumaProm =0
    mov r9,0    ;int sumaPesos = 0
    mov rcx,0    ;int contEvaluaciones =0

bucle:
    cmp rcx, 4
    jge division
    mov rax, [arreglosPesos +8*rcx]
    add r9,rax
    mov rbx, [arreglosNotas +8*rcx]
    add r8, rbx
    mul rbx   ;rax = rax*rbx
    add r8, rax
    inc rcx
    jmp bucle

division:
    mov rax ,r8
    div r9  ;rax = rax/r9
    xor rdx, rdx

impresion:
    cmp rax, 10
    jl final
    mov rcx,10
    div rcx  ;rax = rax /rcx
    mov r10 , rdx  ;r10 = rdx  1er iter r10 = 0 esta bien porque solo habra 2 iteraciones como maximo
    add rax, 30H
    mov [solution],rax
    mov rax, 1
    mov rdi, 1
    mov rsi, solution
    mov rdx, 1
    syscall
    mov rax, r10

final:
    add rax, 30H
    mov [solution],rax
    mov rax, 1
    mov rdi, 1
    mov rsi, solution
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, char
    mov rdx, 0
    syscall

    mov rax, 60
    mov rdi, 0
    syscall



