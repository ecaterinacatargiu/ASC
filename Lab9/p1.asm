bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen, fprintf, fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "ana.txt",0
    access_mode db "w",0
    fd dd 0
    format db "%d ",0
    a dd 1,2,-17,9
    len EQU ($-a)/4

; our code starts here
segment code use32 class=code
    start:
        ;1 - open the file : fopen(file_name, access_mode)
        push access_mode
        push file_name
        call [fopen]
        add esp, 4*2
        ;EAX=fd
        mov [fd], eax
        ;here we check if the fopen failed
        cmp eax,0
        je final
        
        ;2 - write into file: fprintf(fd, format, eax)
        mov ecx, len
        jecxz final
        mov esi, a
        cld
        do:
            lodsd
            pusha
            push eax
            push format
            push dword [fd]
            call [fprintf]
            add esp, 4*3
            popa ;restore all the registers
            loop do
        ;3 - close the file : fclose(fd)
         push dword [fd]
         call [fclose]
         add esp, 4*1
         
         final:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
