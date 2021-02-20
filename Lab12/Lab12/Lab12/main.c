#include <stdio.h>
int perm(int a);

int main()
{
	int a = 0x12345678;
	printf("%x", a);
	for (int i = 0; i < 8; i++)
	{
		a = perm(a);
		printf("%x", a);
	}
	return 0;
}