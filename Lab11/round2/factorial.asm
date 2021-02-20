%ifndef _FACTORIAL_ASM_
%define _FACTORIAL_ASM_

;factorial(n) -> n!
factorial:
    push ebp
    mov ebp, esp 
    mov eax, 1
    mov ecx, [ebp+8]
    repeat: 
        mul ecx
        loop repeat
    pop ebp
    ret 4; stdcall convention
    
%endif