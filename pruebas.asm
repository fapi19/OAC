section .data
    ;datos con valores iniciales
    message1 db "Ingrese un numero mayor a 0 y de un solo digito",10
    len1 equ $ - message1
    message2 db "La solucion es:"
    len2 equ $ -message2
    number dq 0
    solution dq  0
section .text
    global _start

    _start:
        mov rax,1
        mov rax,1
        mov rsi,message1
        mov rdx, len1
        syscall

        ;SYS_CALL
        ;para darle a un dato a la variable(leer)
        mov rax,0
        mov rdi, 0
        mov rsi,number
        mov rdi,1  
        ;solo 1 digito que se ingresa
        syscall

        ;lo pasamos a ASCII
        mov rcx, [number]
        sub rcx, 30H

        countLoop:
        mov rax,rcx
        mul rcx  
        ; rax =*rcx
        add [solution], rax
        dec rcx
        cmp rcx, 0
        jne countLoop

        ;SYS_WRITE
        mov rax,1
        mov rdi, 1
        mov rsi, message2
        mov rdx, len2
        syscall

        test: ;pushea en pila el resultado
            xor rcx, rcx  ;limpio el registro
            mov r8,10
            mov rcx,[solution]
            mov rbx, 0
            xor rdx, rdx

        division:
        mov rax, rcx
        cmp rax,r8  ;//si el numero e smenor a 1 digito
        jl aux
        div r8
        inc rbx
        push rdx

        mov rcx, rax
        jmp division

        aux:
            push rax
            inc rbx
        loopprint: ;popea e imprime cada diigto
            cmp rbx,0 
            je final
            dec rbx
            pop rcx

            add rcx, 30H
            mov [solution],rcx

            mov rax,1
            mov rdi, 1
            mov rsi, solution
            mov rdx, 1
            syscall
            jmp loopprint
        
        final:
            mov rax,60
            mov rdi,0
            syscall