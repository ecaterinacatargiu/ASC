bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, printf,fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "ana5.txt",0
    access_mode db "r", 0
    buffer TIMES 10 db 0
           db 0
    size EQU 10
    fd dd 0

; our code starts here
segment code use32 class=code
    start:
        ;1 - open the file: fopen(file_name, access_mode)
        push access_mode
        push file_name
        call [fopen]
        add esp, 4*2
        mov [fd], eax
        cmp eax,0
        je final
        do:
            ;fread(buffer, 1, size, fd)
            push dword [fd]
            push dword size
            push dword 1
            push buffer
            call [fread]
            add esp, 4*4
            cmp eax, 0 ;have we reach the end?
            je after_read
            ;printf(buffer)
            push buffer
            call [printf]
            add esp, 4*1
            jmp do
            after_read:
            mov [buffer+eax], byte 0
            
        ;3 - close the file : fclose(fd)
         push dword [fd]
         call [fclose]
         add esp, 4*1
         
         final:
            
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
