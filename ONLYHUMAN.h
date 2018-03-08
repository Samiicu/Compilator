#include<string.h>


struct variabila{
	int valoare;
	char nume[100];
	int initializat;
	int constant;
	int tip;
};

struct variabila variabile[100];
int contor=0;

struct functie{
	char nume[100];
	int nr_parametrii;
	int tip[100];
	int def;
};
int fcontor=0;
struct functie functii[100];
int nrparam=0;
int vecparam[100];


struct tablou{
	char nume[100];
	int dim;
	int constant;
};

struct tablou tablouri[100];
int tcontor=0;

int dimensiune=0;
int nrexpresii=0;

char buffer[3000]="";



int maxim(int a,int b)
{
	if(a>b)
		return a;
	else
		return b;
}

int minim(int a,int b)
{
	if(a<b)
		return a;
	else
		return b;
}

int modul(int a)
{
	if(a<0)
		return (-a);
	else
		return a;
}

int cmmdc(int a,int b)
{
	while(a!=b)
	if(a>b) a=a-b;
		else b=b-a;
	return b;
}

int cmmmc(int a, int b)
{
	int rez;
	rez = a*b / cmmdc(a,b);
	return rez;
}

void decl_cu_init(char x[],int v,int constant,char y[])
{	
	strcpy(variabile[contor].nume,x);
	variabile[contor].initializat=1;
	variabile[contor].valoare=v;
	variabile[contor].constant=constant;
	if(strcmp("int",y)==0)
	variabile[contor].tip=1;
	if(strcmp("float",y)==0)
		variabile[contor].tip=2;
	if(strcmp("char",y)==0)
		variabile[contor].tip=3;
	if(strcmp("string",y)==0)
		variabile[contor].tip=4;
	contor++;
}
void decl_fara_init(char x[],char y[])
{
	strcpy(variabile[contor].nume,x);
	variabile[contor].initializat=0;
	variabile[contor].constant=0;
	if(strcmp("int",y)==0)
	variabile[contor].tip=1;
	if(strcmp("float",y)==0)
		variabile[contor].tip=2;
	if(strcmp("char",y)==0)
		variabile[contor].tip=3;
	if(strcmp("string",y)==0)
		variabile[contor].tip=4;
	contor++;
}
int get_tip(int z)
{
return variabile[z].tip;
}
int declarat(char x[])
{
    int i;
    for(i=0;i<=contor;i++)
        if(strcmp(x,variabile[i].nume)==0) return i;
    for(int j=0;j<fcontor;j++)
    	if(strcmp(x,functii[j].nume)==0) return -2;
    for(int j=0;j<tcontor;j++)
    	if(strcmp(x,tablouri[j].nume)==0) return -2;
    return -1;
}

int fdeclarat(char x[],int nr,int vect[100])
{
    int i;
    for(i=0;i<=contor;i++)
        if(strcmp(x,variabile[i].nume)==0) return i;
    for(int j=0;j<tcontor;j++)
    	if(strcmp(x,tablouri[j].nume)==0) return j;
    for(int j=0;j<fcontor;j++)
    	if(strcmp(x,functii[j].nume)==0) 
    		if(nr==functii[j].nr_parametrii)
    			{	for(int s=0;s<nrparam;s++)
    					if(functii[j].tip[s]!=vect[s])
    						return -1;
    					if(functii[j].def)
    						return -2;
    					return j;
               }
    return -1;
}

int fdeclarat2(char x[],int number)
{
    int i;
    for(i=0;i<=fcontor;i++)
        if(strcmp(x,functii[i].nume)==0)
         if(functii[i].nr_parametrii==number)
         	return i;
    return -1;
}

void ad_param(char x[],int nr)
{
	if(strcmp("int",x)==0)
		vecparam[nrparam]=1;
	if(strcmp("float",x)==0)
		vecparam[nrparam]=2;
	if(strcmp("char",x)==0)
		vecparam[nrparam]=3;
	if(strcmp("string",x)==0)
		vecparam[nrparam]=4;
}

void decl_functie(char nume[],int nr,int vec[100],int def)
{
strcpy(functii[fcontor].nume,nume);
functii[fcontor].nr_parametrii=nr;
for(int i=0;i<nrparam;i++)
	functii[fcontor].tip[i]=vec[i];
functii[fcontor].def=def;
fcontor++;
}

void decl_tablou(char nume[],int nr,int constant)
{
	strcpy(tablouri[tcontor].nume,nume);
	tablouri[tcontor].dim=nr;
	tablouri[tcontor].constant=constant;
	tcontor++;
}

void atribuire(char x[],int v)
{
    int p=declarat(x);
    variabile[p].valoare=v;
    variabile[p].initializat=1;
}


int get_val(char x[])
{
    int p=declarat(x);
    return variabile[p].valoare;
}


void incr(char x[])
{
    int p=declarat(x);
    variabile[p].valoare++;
}

void decr(char x[])
{
    int p=declarat(x);
    variabile[p].valoare--;
}

int initializat(char x[])
{
    int i;
    for(i=0;i<=contor;i++)
        if(strcmp(x,variabile[i].nume)==0) 
        	if(variabile[i].initializat==0)
        		 return 0;
        	else return 1;
    return 0;
}

void scrie_buffer_int(int intreg)
{
	char buffer1[30];
	sprintf(buffer1,"%d",intreg);
	strcat(buffer,buffer1);
	strcat(buffer,"\n");
}

void scrie_buffer(char afisare[])
{
	strcat(buffer,afisare);
}

void printspecial(char x[])
{
    int p=declarat(x);
    scrie_buffer("\n id ");
    scrie_buffer(variabile[p].nume);
    scrie_buffer(" = ");
    scrie_buffer_int(variabile[p].valoare);
    scrie_buffer("\n");
}