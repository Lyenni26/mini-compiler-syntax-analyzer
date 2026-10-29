flex lexical.l
bison -d syntax.y
gcc lex.yy.c syntax.tab.c -o projet.exe -lfl -ly
projet.exe<exemple.txt
