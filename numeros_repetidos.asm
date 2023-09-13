section .data
	;Mensaje
	mensaje db "La nota del alumno es: " 
	cntMensaje equ $ - mensaje
	; Caso de Prueba 1:
  ; arreglo dq 12,16,20,16,12
	; cntArreglo dq 5
	
	; Caso de Prueba 2:
	arreglo dq 1,1,2,2,3,3,4,5,5,6,6,7,7,8,8,9,9,10,10,12,12,15,15,17,17,18,18,19,19,20,20
  cntArreglo dq 31
	solucion dq 0


section .text
    global _start

_start:
    mov rax, 1
	mov rdi, 1
	mov rsi, mensaje
	mov rdx, cntMensaje
	syscall

    ;Limpiar los registros a utilizar
    xor rbx,rbx
	xor rcx,rcx
	xor rdx,rdx
	xor rax,rax

    ;Empezamos el analisis
    mov rbx, [arreglo]  ; se pasa el valor del 1er termino del arreglo
    mov [solucion], rbx  ; se pasa el valor del registro al de la solucion
    mov rbx, [cntArreglo]
    inc rcx

for:
    cmp rcx, rbx
    je impresion ; si se llego al valor nos vamos a la impresion
    ;sino seguimos procesando
    mov rdx, [arreglo+8*rcx]
    xor [solucion] , rdx  
    inc rcx
    jmp for

impresion:
    xor rcx, rcx  ;limpio registro
    mov r8,10  ; le doy el valor de 10 para luego hacer la division
    mov rcx, [solucion]
    mov rbx, 0
    xor rdx, rdx

division:
    mov rax, rcx
    cmp rax, r8 ;comparamos
    jl auxiliar ; si rax<r8
    xor rdx, rdx
    div r8   ;  rax = rax/r8
    inc rbx
    push rdx
    mov rcx, rax
    jmp division

auxiliar:
    push rax
    inc rbx

loopPrint:
    cmp rbx, 0
    je final
    dec rbx
    pop rcx

    add rcx, '0'
    mov [solucion] , rcx
    mov rax, 1
	mov rdi, 1
	mov rsi, solucion
	mov rdx, 1
	syscall
	jmp loopPrint
	
final:
	mov rax,60
	mov rdi, 0
	syscall

