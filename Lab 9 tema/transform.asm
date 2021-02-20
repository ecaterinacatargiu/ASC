bits 32
global transform

segment code use32 class=code public
transform:  
	mov esi, [esp+4]
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
	ret 
