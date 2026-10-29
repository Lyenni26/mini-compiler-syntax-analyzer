%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdbool.h>
#include"ts.h"	

int nb_ligne = 1, Col = 1;
char savetype[20];
int b = 0;
int yyerror(){printf("Erreur syntaxique a la ligne %d la colonne %d \n",nb_ligne,Col);return 1;}
%}

%union {
         int     entier;
         char*   str;
         float reel;
}

%token pgm begin end var <str>dec <str>decc mc_if mc_else mc_for mc_while tread twrite <entier>entier <reel>reel sopt <str>idf and or not <str>opt <str>optc aff vir accO accF parO parF croO croF pvg chaine dpoint 
%%
S:pgm idf var accO DEC accF begin PGM end {printf("syntaxe correcte \n\n"); YYACCEPT;}
;

PGM: EXPRESSION PGM | ;
EXPRESSION: IF|WHILE|FOR|ES|AFF;
//DECLARATION
DEC : | DEC1 DEC;
DEC1 : TYPE LIST | TYPE1 block_const;
TYPE : dec {strcpy(savetype,$1); };
TYPE1 : decc {strcpy(savetype, $1);};
LIST : ListT | ListV ;
ListV : idf pvg {if(doubleDec($1) == 1)insererType($1, savetype);
		else printf("erreur semantique a la ligne %i , colonne %i: double declaration , l'IDF %s est deja declaree\n", nb_ligne, Col, $1);}
	| idf vir ListV {if(doubleDec($1) == 1)insererType($1, savetype);
		else printf("erreur semantique a la ligne %i , colonne %i: double declaration , l'IDF %s est deja declaree\n", nb_ligne, Col, $1);};
ListT : idf croO CHF croF pvg {if(doubleDec($1) == 1)insererType($1, savetype);
		else printf("erreur semantique a la ligne %i , colonne %i: double declaration , l'IDF %s est deja declaree\n", nb_ligne, Col, $1);} 
	| idf croO CHF croF vir ListT {if(doubleDec($1) == 1)insererType($1, savetype);
		else printf("erreur semantique a la ligne %i , colonne %i: double declaration , l'IDF %s est deja declaree\n", nb_ligne, Col, $1);};
block_const : block_S | block_C;
block_S : idf aff CST pvg {if(doubleDec($1) == 1)insererType($1, savetype);
		else printf("erreur semantique a la ligne %i , colonne %i: double declaration , l'IDF %s est deja declaree\n", nb_ligne, Col, $1);}
	| idf aff CST vir block_S {if(doubleDec($1) == 1)insererType($1, savetype);
		else printf("erreur semantique a la ligne %i , colonne %i: double declaration , l'IDF %s est deja declaree\n", nb_ligne, Col, $1);};
block_C : idf pvg {if(doubleDec($1) == 1)insererType($1, savetype);
		else printf("erreur semantique a la ligne %i , colonne %i: double declaration , l'IDF %s est deja declaree\n", nb_ligne, Col, $1);}
	| idf vir block_C{if(doubleDec($1) == 1)insererType($1, savetype);
		else printf("erreur semantique a la ligne %i , colonne %i: double declaration , l'IDF %s est deja declaree\n", nb_ligne, Col, $1);};


//AUTRE
CHF : reel | entier {if((b == 1) && ($1==0))printf("erreur semantique a la ligne %i, colonne %i, la division sure 0 est non autorisee\n", nb_ligne, Col);};
CST : CHF | parO sopt CHF parF;
Type: idf {if (nonDec ($1)== 1)printf("erreur semanique a la ligne %i colonne %i, l'IDF %s undeclared\n",nb_ligne, Col, $1);};
	| CHF;
OPT : sopt | opt { b == 0; 
		   if(strcmp($1, "/")==0) b = 1;};


//affectation
AFF: idf aff EXP pvg {if (nonDec ($1)== 1)printf("erreur semantique a la ligne %i colonne %i, l'IDF %s undeclared\n",nb_ligne, Col, $1);};
EXP: Type | Type OPT EXP1 | parO Type OPT EXP1 parF EXP2;
EXP1: EXP | OPT EXP;
EXP2: | OPT EXP;




//if
IF: mc_if parO Type optc Type parF accO PGM accF ELSE;
ELSE: | mc_else accO PGM accF;

//WHILE

WHILE: mc_while parO Type optc Type parF accO PGM accF;

//ES
ES : MOT ;
MOT : WRITE | READ ;
WRITE : twrite parO chaine parF pvg ;
READ : tread parO idf parF pvg {if (nonDec ($3)== 1)printf("erreur semanique a la ligne %i colonne %i, l'IDF %s undeclared\n",nb_ligne, Col, $3);}; ;

//FOR

FOR: mc_for parO idf dpoint CHF dpoint CHF dpoint idf parF accO PGM accF {if (nonDec ($3)== 1)printf("erreur semanique a la ligne %i colonne %i, l'IDF %s undeclared\n",nb_ligne, Col, $3);};

%%

int main() 
{
yyparse();
affichage();

}
int yywrap()
{}




