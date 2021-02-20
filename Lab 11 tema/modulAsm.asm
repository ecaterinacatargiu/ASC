bits 32
global _transform
segment data public data use32
segment code public code use32

_transform:
	push ebp
	mov ebp, esp
	
	mov esi, [ebp+8]
	mov ecx, 7
	mov ebx, 0
	transformNo:
		lodsb
		cmp al,0x31
		jne skip
			mov edx, ecx
			push ecx
			mov ecx, edx
			mov edx,0
			mov al, 1
			mov dl, 2
			ridicareLaPutere:
				mul dl
			loop ridicareLaPutere
			add bl,al
			pop ecx
		skip:
	loop transformNo
	lodsb
	cmp al,0x31
	jne skip1
	add bl,1
	skip1:
	mov eax, ebx
	
	mov esp, ebp
	pop ebp
	
	ret
	