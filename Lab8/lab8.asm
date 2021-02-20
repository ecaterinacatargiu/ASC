bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf        ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll               ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 1,2,10,12
    len EQU ($-a)/4
    format db "a[%d]=%d ",0

; our code starts here
segment code use32 class=code
    start:
        mov ESI, a
        mov ECX, len
        CLD
        JECXZ final
        mov EBX, 0
        do:
            LODSD
            ;printf(format, ebx, eax)
            pusha
            
            push EAX
            push EBX
            push format
            call [printf]
            add ESP, 4*3
            
            popa
            
            inc EBX
        loop do
        final:
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
