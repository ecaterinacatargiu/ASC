bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a TIMES 100 db 0
    len dd 0
    format db "%d",0
    mesg_len db "len = ",0
    mesg_elem db "elem = ",0
    mesg_suma db "suma = ",0

; our code starts here
segment code use32 class=code
    start:
        mov esi, a
        ;printf(mesg_len)
        push mesg_len
        call [printf]
        add esp, 4*1
        
        ;scanf(format, len)
        push len
        push format
        call [scanf]
        add esp, 4*2
        
        mov ecx, [len]
        jecxz final
        do: 
            pusha
            ;printf(mesg_elem)
            push mesg_elem
            call [printf]
            add esp, 4*1
            ;scanf(format, esi)
            push esi
            push format
            call [scanf]
            add esp, 4*2
            popa
            add esi, 4*1
            loop do
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
