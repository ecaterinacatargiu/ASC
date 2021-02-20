bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf,gets               ; tell nasm that exit exists even if we won't be defining it
extern transform
import exit msvcrt.dll
import gets msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll    




; our data is declared here (the variables needed by our program)
segment data use32 class=data public
    ; ...A string containing n binary representations on 8 bits is given as a character string.
    ;Obtain the string containing the numbers corresponding to the given binary representations.
    ;Example:
    ;Given: '10100111b', '01100011b', '110b', '101011b'
    ;Obtain: 167, 99, 6, 43
    
	no db '10100111b','01100011b','00000110b','00101011b'
	len equ $-no
	s times 100 db 0
    formatn db 'nr = %d ,',0
	counter dd 0
	number db 0
	string dd 0
    ind dd 0
	
	
; our code starts here
segment code use32 class=code public
    start:
        ; ...
    
        ; exit(0)
		
        	
		mov ecx, 4
		mov esi, 0
		mov edi, 0
		mov eax, 0
		mov edx, no
		loopn:
			
				mov [counter],ecx
				add edx, esi
				push dword edx
				call transform
				;pop ebx
				mov [s+edi],bl
				mov ebx,0
				add esp, 4*1
			
				inc edi
				inc esi
				mov edx,0
				mov ecx,[counter]
			
			
			;mov ecx, 7
			;mov ebx,0
			
			;transformNo:
			;	lodsb
			;	cmp al,0x31
			;	jne skip
			;	mov dword[ind], ecx
			;	push ecx
			;	mov ecx, [ind]
			;	mov al, 1
			;	mov dl, 2
			;	ridicareLaPutere:
			;		mul dl
			;	loop ridicareLaPutere
			;	add bl,al
			;	pop ecx
			;	skip:
			;loop transformNo
			;lodsb
			;cmp al,0x31
			;jne skip1
			;add bl,1
			;skip1:
			
			
		loop loopn
		
		mov ecx, edi
		mov edi, 0
		printNo:
			push ecx
			mov eax, 0
			mov al,[s+edi]
			push dword eax
			push dword formatn
			call [printf]
			add esp,4*2
			inc edi
			pop ecx
		loop printNo
		
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

		
		
