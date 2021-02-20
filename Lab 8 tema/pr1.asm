bits 32

global start        

; declararea functiilor externe folosite de program
extern exit, printf, scanf ; adaugam printf si scanf ca functii externa            
import exit msvcrt.dll    
import printf msvcrt.dll    ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll     ; similar pentru scanf
                          
segment data use32 class=data
	a dd 0
    b dd 0
	messagea  db "a=", 0  
	messageb db "b=",0
    format  db "%d", 0
    formathexa db "%x", 0
    
segment code use32 class=code
    ;Sa se citeasca de la tastatura doua numere a si b (in baza 10) si sa se calculeze a+b. Sa se afiseze rezultatul adunarii in baza 16.
    start:
        push dword messagea 
        call [printf]      
        add esp, 4*1       
                                                   
        push dword a       
        push dword format
        call [scanf]       
        add esp, 4 * 2

        push dword messageb 
        call [printf]      
        add esp, 4*1       
                                                   
        push dword b       
        push dword format
        call [scanf]       
        add esp, 4 * 2        
        
        mov eax,[a]
        add eax, [b]
        
        push dword eax
        push dword formathexa
        call [printf]
        add esp, 4*2
        
        ; exit(0)
        push dword 0      ; punem pe stiva parametrul pentru exit
        call [exit]       ; apelam exit pentru a incheia programul