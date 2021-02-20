bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fread,fclose,printf       
import fopen msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll     ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sirFrecventa times 10 db 0
    
    file db 'txtul.txt', 0
    mod_acces db 'r', 0
    file_descriptor dd 0
    
    len equ 100
    sir times len db 0
    
    counter db 0
    maxNr db 0
    maxDig db 0
    
    afiseaza db 'Cifra: %d apare de %d ori', 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push mod_acces
        push file
        call [fopen]
        add esp, 4*2
        
        
        cmp eax,0
        je final
        mov [file_descriptor],eax
        
       citire:
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword sir
        call [fread]
        add esp, 4*4
        
        cmp eax, 0    
        je cleanup
        
        mov ecx,eax
        mov esi, sir
       frecventa:
        lodsb
        sub al, '0'
        cbw 
        cwde
        mov edx, sirFrecventa
        add edx, eax
        add [edx], byte 1
        loop frecventa
        
       cleanup:
        
        mov [maxNr], byte 0
        mov [maxDig], byte 0
        mov [counter], byte 0
        mov ecx, 10
        mov esi, sirFrecventa
       detMax:
        lodsb
        cmp al, [maxNr]
        jg max
        bucl:
        add [counter], byte 1
        
        loop detMax 
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        mov eax, 0
        mov al, [maxNr]
        mov ebx, 0
        mov bl, [maxDig]
        
        push eax
        push ebx
        push dword afiseaza
        call [printf]
        add esp, 4*3
        
       final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]  
        
       max:
        mov [maxNr], al
        mov bl, [counter]
        mov [maxDig], bl
        jmp bucl
        ; exit(0)
             ; call exit to terminate the program
