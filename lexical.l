%{
#include"syntax.tab.h"
//#include "ts.h"
void inserer(char *str, int i);
extern int nb_ligne;
extern int Col;
extern YYSTYPE yylval;
%}
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre})*
INTEGER {chiffre}+
FLOAT {chiffre}+\.{chiffre}+
opt [*/]
sopt[+\-]
optc "=="|"!="|"<="|">="|"<"|">"
%%
"PROGRAMME" {Col = Col + strlen(yytext);inserer(yytext, 2); return pgm;}
"'".*"'" {Col = Col + strlen(yytext); return chaine; }
"BEGIN" {Col = Col + strlen(yytext) ;inserer(yytext, 2); return begin; }
"END." {Col = Col + strlen(yytext) ;inserer(yytext, 2);  return end;}
"VAR" { Col = Col + strlen(yytext);inserer(yytext, 2); return var;} 
"INTEGER" {Col = Col + strlen(yytext);inserer(yytext, 2); yylval.str=strdup(yytext); return dec; }
"FLOAT" {Col = Col + strlen(yytext);inserer(yytext, 2); yylval.str=strdup(yytext); return dec;}
"IF" {Col = Col + strlen(yytext);inserer(yytext, 2); return mc_if;}
"ELSE" { Col = Col + strlen(yytext);inserer(yytext, 2); return mc_else;}
"WHILE" {Col = Col + strlen(yytext);inserer(yytext, 2); return mc_while;}
"FOR" { Col = Col + strlen(yytext);inserer(yytext, 2); return mc_for;}
"readIn" {Col = Col + strlen(yytext);inserer(yytext, 2); return tread;}
"writeIn" {Col = Col + strlen(yytext);inserer(yytext, 2); return twrite;}
"CONST" {Col = Col + strlen(yytext) ;inserer(yytext, 2); yylval.str=strdup(yytext); return decc; }
{INTEGER} {
            int x = atoi(yytext);
            yylval.entier = x;
            if(x < -32500 || x > 32500){ printf("Erreur Lexicale \n");
            Col = Col + strlen(yytext) ;}
            else {return entier;}
            }
{FLOAT} {Col = Col + strlen(yytext);
        yylval.reel = atof(yytext);
	    return reel;}


{IDF} {if(yyleng > 7) {printf("Errer lexical: IDF trop long\t");Col = Col + strlen(yytext);} else {inserer(yytext, 0); yylval.str=strdup(yytext); return idf;}}
"//"[^\n].* 
"/*"(.|\n)*"*/"
"&&" {Col = Col + strlen(yytext);return and; }
"||" {Col = Col + strlen(yytext); return or; }
"!" {Col = Col + strlen(yytext); return not; }
{opt} {Col = Col + strlen(yytext);yylval.str=strdup(yytext); return opt;}
{sopt} {Col = Col + strlen(yytext);yylval.str=strdup(yytext); return sopt;}
{optc} {Col = Col + strlen(yytext); return optc;}
":" {Col = Col + strlen(yytext); return dpoint;}
"=" {Col = Col + strlen(yytext);inserer(yytext, 1); return aff;}
"," {Col = Col + strlen(yytext);inserer(yytext, 1); return vir;}
"{" {Col = Col + strlen(yytext);inserer(yytext, 1); return accO;}
"}" {Col = Col + strlen(yytext);inserer(yytext, 1); return accF;}
"(" {Col = Col + strlen(yytext);inserer(yytext, 1); return parO;}
")" {Col = Col + strlen(yytext);inserer(yytext, 1); return parF;}
"[" {Col = Col + strlen(yytext);inserer(yytext, 1); return croO;}
"]" {Col = Col + strlen(yytext);inserer(yytext, 1); return croF;}
";" {Col = Col + strlen(yytext);inserer(yytext, 1); return pvg;}
[ \t] {Col = Col + strlen(yytext);}
\n {printf("\n"); nb_ligne++; Col = 1;}
. {printf("erreur lexicale à la ligne %d et la colonne %d\n",nb_ligne, Col);}

