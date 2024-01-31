global  _start

section .data
    SYS_EXIT equ 60
    num1 db 5
    num2 db 10
    gcf db 0
    i db 0

section .text
_start:
    mov bl, 0
    mov cl, 0
    mov dl, 0
    mov dl, byte[num2] ;move num2 sa dl
    mov cl, byte[num1] ; move num1 sa cl
    cmp cl, byte[num2]
    jb small1 ;if num1<num2 jump sa small

    mov byte[i], dl ;else, move value of dl to i
    jmp checker2 ;then jump to checker2

checker2:
    mov al, byte[num1] ;mov num1 to al then al/i tapos kapag yung ah which is remainder ay equal sa 0 then 
    ;jump sa checker 22 para icheck naman if kaya madivide yung i sa isang number
    div byte[i]
    
    cmp ah, 0
    je checker22

    dec byte[i] ;else decrement si i then check if 0 na kapag hindi pa balik lang sa checker2
    cmp byte[i], 0
    jne checker2 

    jmp exit_here

checker22:
;check if yung isang number ay divisible sa i if oo then store na sa gcf if not balik sa checker 2
    mov al, 0
    mov ah, 0

    mov al, byte[num2]
    div byte[i]
    
    cmp ah, 0
    je store

    dec byte[i]
    jmp checker2

small1:
    
    mov byte[i], cl

checker1:
    
    mov al, byte[num2]
    div byte[i]
    cmp ah, 0
    je checker11

    dec byte[i]
    cmp byte[i], 0
    jne checker1

    jmp exit_here

checker11:
    mov al, 0
    mov ah, 0
    mov al, byte[num1]
    div byte[i]
    cmp ah, 0
    je store

    dec byte[i]
    jmp checker1

store: ;store the value of i to bl then mov sa gcf
    mov bl, byte[i]
    mov byte[gcf], bl

exit_here:
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall
    

