bits 32
global _perm
segment code PUBLIC code use32 class = code

-perm:
	push EBP;
	mov EBP, ESP;
	mov EAX, [EBP+8]
	ROL EAX,4
	RET