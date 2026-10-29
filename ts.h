#ifndef TEST_H_INCLUDED
#define TEST_H_INCLUDED





#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
int yyparse();
int yylex();

//Liste Chaine de SEP
typedef struct sep
{
	char *nom;
	char *type;
} sep;
typedef struct celluleSEP *tsSEP;
typedef struct celluleSEP
{
	sep info;
	tsSEP svt;
}celluleSEP;

//Liste Chainee de MC
typedef struct celluleMC *tsMC;
typedef struct celluleMC
{
	sep info;
	tsMC svt;
}celluleMC;	



//Liste Chainee De IDF 
typedef struct stat
{
    char *type;
    char *nom;
    char *code;
    char *constant;
    float valeur;
} stat;

typedef struct celluleIDF *tsIDF;
typedef struct celluleIDF
{
    stat info;
    tsIDF svt;
} celluleIDF;




tsIDF teteIDF = NULL, pIDF, prdIDF, parIDF;
tsSEP teteSEP = NULL, pSEP, prdSEP, parSEP;
tsMC teteMC = NULL, pMC, prdMC, parMC;

// FONCTION INIT 
/*void init()
{
    teteIDF = (tsIDF)malloc(sizeof(celluleIDF));
        if (teteIDF == NULL)
        {
            printf("erreur d'allocation \n");
            exit(-1);
        }
    pIDF = teteIDF;
    
    teteSEP = (tsSEP)malloc(sizeof(celluleSEP));
        if (teteSEP == NULL)
        {
            printf("erreur d'allocation \n");
            exit(-1);
        }
    pSEP = teteSEP;
    teteMC = (tsMC)malloc(sizeof(celluleMC));
        if (teteMC == NULL)
        {
            printf("erreur d'allocation \n");
            exit(-1);
        }
    pMC = teteMC;

}
*/


int rechercher(char *str, int i)
{
    switch(i)
    {
    case 0:
            parIDF = teteIDF;
            while (parIDF != NULL)
            {
                if (strcmp(parIDF->info.nom, str) == 0)
                return 0;
                parIDF = parIDF->svt;
            }
            return 1;
    case 1: 
            parSEP = teteSEP;
            while (parSEP != NULL)
            {
                if (strcmp(parSEP->info.nom, str) == 0)
                return 0;
                parSEP = parSEP->svt;
            }
            return 1;
    case 2: 
            parMC = teteMC;
            while (parMC != NULL)
            {
                if (strcmp(parMC->info.nom, str) == 0)
                return 0;
                parMC = parMC->svt;
            }
            return 1;

    }
}



//INSERER




void inserer(char *str, int i)
{
    switch(i)
    {
        case 0: 
		 if (teteIDF == NULL)
		    {
			teteIDF = (tsIDF)malloc(sizeof(celluleIDF));
			if (teteIDF == NULL)
			{
			    printf("erreur d'allocation \n");
			    exit(-1);
			}
			teteIDF->info.nom = strdup(str);
			teteIDF->info.code = "IDF";
			teteIDF->svt = NULL;
			prdIDF = teteIDF;
		    }
		 else
		    {
			if (rechercher(str, 0) == 1)
			{
			    pIDF = (tsIDF)malloc(sizeof(celluleIDF));
			    pIDF->info.nom = strdup(str);
			    pIDF->info.code = "IDF";
			    prdIDF->svt = pIDF;
			    pIDF->svt = NULL;
			    prdIDF = pIDF;
			}
			}
		break;
	   case 1: 
		 if (teteSEP == NULL)
		    {
			teteSEP = (tsSEP)malloc(sizeof(celluleSEP));
			if (teteSEP == NULL)
			{
			    printf("erreur d'allocation \n");
			    exit(-1);
			}
			teteSEP->info.nom = strdup(str);
			teteSEP->info.type = "SEP";
			teteSEP->svt = NULL;
			prdSEP = teteSEP;
		    }
		 else
		    {
			if (rechercher(str, 1) == 1)
			{
			    pSEP = (tsSEP)malloc(sizeof(celluleSEP));
			    pSEP->info.nom = strdup(str);
			    pSEP->info.type = "SEP";
			    prdSEP->svt = pSEP;
			    pSEP->svt = NULL;
			    prdSEP = pSEP;
			}
			}
		break;
	   case 2: 
		 if (teteMC== NULL)
		    {
			teteMC = (tsMC)malloc(sizeof(celluleMC));
			if (teteMC == NULL)
			{
			    printf("erreur d'allocation \n");
			    exit(-1);
			}
			teteMC->info.nom = strdup(str);
			teteMC->info.type = "Mot Cle";
			teteMC->svt = NULL;
			prdMC = teteMC;
		    }
		 else
		    {
			if (rechercher(str, 2) == 1)
			{
			    pMC = (tsMC)malloc(sizeof(celluleMC));
			    pMC->info.nom = strdup(str);
			    pMC->info.type = "Mot Cle";
			    prdMC->svt = pMC;
			    pMC->svt = NULL;
			    prdMC = pMC;
			}
			}
		break;
    }
}



//INSERER TYPE




int insererType(char* str, char* type)
{
    if(rechercher(str, 0) == 0){
    char string[20];
    parIDF->info.type = strdup(type);
    return 0;}
    else {printf("l'idf n'existe pas\n'");return 1;}
}



//doubleDeclaration

int doubleDec(char *str)
{
	rechercher(str, 0);
	if(parIDF->info.type == NULL) return 1;
	else return 0;
}

//non declaration
int nonDec (char *str)
{
	if(doubleDec(str) == 1)return 1;
	else return 0;
}
//AFFICHAGE


void affichage()
{
    tsIDF par0 = teteIDF;
    tsSEP par1 = teteSEP;
    tsMC par2 = teteMC;
    printf("\n/******************* Table des symboles IDF *******************/\n");
    printf("______________________________________________________________\n");
    printf("\t | Type   | NomEntite | CodeEntite | Constant | Valeur \n");
    printf("______________________________________________________________\n");
    while (par0 != NULL)
    {
        printf("\t |%7s |%9s | %9s  |%9s | %4f \n",par0->info.type, par0->info.nom, par0->info.code, par0->info.constant, par0->info.valeur);
        par0 = par0->svt;
    }
printf("\n\n");







//--------------------------------------------------------------------------------

printf("\n/******************* Table des symboles SEP*******************/\n");
    printf("______________________________________________________________\n");
    printf("\t | NomEntite | CodeEntite \n");
    printf("______________________________________________________________\n");
    while (par1 != NULL)
    {
        printf("\t |%10s | %9s \n", par1->info.nom, par1->info.type);
        par1 = par1->svt;
    }
    
printf("\n\n");





//-------------------------------------------------------------------------------

    printf("\n/******************* Table des symboles MC*******************/\n");
    printf("______________________________________________________________\n");
    printf("\t | NomEntite | CodeEntite \n");
    printf("______________________________________________________________\n");
    while (par2 != NULL)
    {
        printf("\t |%10s | %9s \n", par2->info.nom, par2->info.type);
        par2 = par2->svt;
    }

}


#endif
