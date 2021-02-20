bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf, printf              ; tell nasm that exit exists even if we won't be defining it
import fopen msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    numefisier db "blablabla.txt",0
    text db "ab%c12*3Hjrk0(hf**", 0
    lenText equ $-text
    spc db "%#*()"
    lenspc equ $-spc
    acces db "w", 0
    fd dd -1
    

; our code starts here
segment code use32 class=code
    ;Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici, litere mari, cifre si caractere speciale. Sa se inlocuiasca toate caracterele speciale din textul dat cu caracterul 'X'. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.
    start:
        ; ...
    
        ; exit(0)
        push dword acces
        push dword numefisier
        call [fopen]
        add esp, 4*2
        
        mov [fd], eax
        cmp eax, 0
        je final
        cld
        ;prelucare text
        mov esi, text
        mov ecx, lenText-1
        repeta:
            lodsb;al=<ds:esi>
            mov edi, spc
            push ecx
            mov ecx, lenspc
            compara:
                scasb
                jne skip
                mov al, 'X'
                skip
            loop compara
            dec esi
            mov edi, esi
            stosb
            mov esi, edi
            pop ecx
        loop repeta
        
        push dword text
        push dword [fd]
        call [fprintf]
        add esp, 4*2
        
        push dword [fd]
        call [fclose]
        add esp, 4*1
        final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
