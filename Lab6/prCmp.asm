bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s dd 12345607h, 1A2B3C15h
    lens equ ($-s)/4
    lend equ lens*4
    d times lend db 0

; our code starts here
;Given an array S of doublewords, build the array of bytes D formed from bytes of doublewords sorted as unsigned numbers in descending order.
;Example:
 ;s DD 12345607h, 1A2B3C15h
 ;d DB 56h, 3Ch, 34h, 2Bh, 1Ah, 15h, 12h, 07h
segment code use32 class=code
    start:
        ; ...
    
        ; exit(0)
        mov ecx, lend
        jecxz sfarsit
        mov esi, s
        cld
        copystring:
            lodsb
            mov dl, al
            push esi
            push ecx
            mov ecx, lend-1
            mov edi, d
            compare:
                lodsb
                cmp al,dl
                jb skip
                inc edi
                skip
            loop compare
            pop ecx
            pop esi
            dec esi
            lodsb
            stosb
        loop copystring
        sfarsit
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
