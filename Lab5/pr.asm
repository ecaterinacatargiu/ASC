bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

;Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the odd elements of A. 
;Example:
;A: 2, 1, 3, 3, 4, 2, 6
;B: 4, 5, 7, 6, 2, 1
;R: 1, 2, 6, 7, 5, 4, 1, 3, 3


segment data use32 class=data
    ; ...
    a db 2, 1, 3, 3, 4, 2, 6
    lena equ $-a
    b db 4, 5, 7, 6, 2, 1
    lenb equ $-b
    r times lena+lenb db 0 

; our code starts here
segment code use32 class=code
    start:
        mov esi, lenb - 1
        mov ecx, lenb
        mov ebx, 0
        jecxz skipB
        insertB:
            mov al, [b+esi]
            mov [r+ebx], al
            inc ebx
            dec esi
        loop insertB
        skipB
        mov esi, 0
        mov ecx, lena
        jecxz skipA
        insertA:
            mov al, [a+esi]
            test al, 1
            jz skipOdd
            mov [r+ebx], al
            inc ebx
            skipOdd
            inc esi
        loop insertA
        skipA
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
