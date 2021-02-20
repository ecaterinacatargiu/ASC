bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 'ana are mere'
    len EQU ($-a)
    b db 'AnA arE MeRe'
    len2 EQU ($-b)
    format db 'Number of identical elements: %d',0
    

; our code starts here
segment code use32 class=code
    start:
        mov EBX, 0
        mov ESI, a
        mov EDI, b
        mov ECX, len
        CLD
        jecxz final
            do:
                CMPSB
                jne over_inc
                inc EBX
                over_inc: 
                    loop do
        final:
        push EBX
        push format
        call [printf]
        add esp, 4*2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
