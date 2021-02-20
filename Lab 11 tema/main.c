#include <stdio.h>
#include <string.h>

int transform(char *s);

int main()
{
    char nr[10],str[100];
    int i,j,a[100],k;
    printf("Sirul e: ");
    gets(str);
    k=0;
    for(i=0;i<strlen(str);i=i+10)
    {
        for(j=0;j<8;j++)
            nr[j]=str[i+j];
        nr[8]='\0';
        a[k]=transform(nr);
        k=k+1;
    }
    printf("Numerele sunt: ");
    for(i=0;i<k;i++)
    {
        printf("%d ",a[i]);
    }
    return 0;
}
