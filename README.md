# ⚙️ Analyseur Lexical et Syntaxique (Flex & Bison)

Ce projet implémente un compilateur / analyseur syntaxique et sémantique pour un sous-ensemble de langage de programmation. Il s'appuie sur le couple d'outils industriels **Flex** (générateur d'analyseur lexical) et **Bison** (générateur d'analyseur syntaxique LALR), couplé à une gestion de table des symboles en langage **C**.

---

## 📌 Fonctionnalités

- **Analyse lexicale (`lexical.l`) :** Détection et découpage des flux de caractères en unités lexicales (mots-clés, identificateurs, opérateurs, constantes numériques et chaînes).
- **Analyse syntaxique & sémantique (`syntax.y`) :** Vérification de la conformité grammaticale des instructions selon une grammaire formelle et exécution d'actions sémantiques associées.
- **Table des symboles (`ts.h`) :** Structure de données dédiée à l'enregistrement des identificateurs (variables, types, adresses) et à la vérification des déclarations et de la portée.
- **Automatisation du build (`command.bat`) :** Script de compilation séquentielle automatisant l'appel à Flex, Bison et GCC.

---

## 🗂️ Structure du Répertoire

- `lexical.l` : Règles d'analyse lexicale (Flex / Lex).
- `syntax.y` : Grammaire formelle et règles sémantiques (Bison / Yacc).
- `ts.h` : Définition des structures et primitives de la table des symboles.
- `exemple.txt` : Programme source d'exemple utilisé pour tester l'analyseur.
- `command.bat` : Script batch d'automatisation de la compilation sous Windows.
- `lex.yy.c` : Code source C généré par Flex.
- `syntax.tab.c` / `syntax.tab.h` : Code C et en-tête des tokens générés par Bison.
- `projet.exe` : Exécutable final issu de la compilation.

---

## 🛠️ Stack Technique

- **Langage hôte :** C (GCC / MinGW)
- **Générateur lexical :** Flex (Fast Lexical Analyzer)
- **Générateur syntaxique :** GNU Bison (LALR Parser Generator)

---

## 🚀 Compilation & Exécution

### 1. Cloner le projet

git clone https://github.com/<ton-pseudo>/c-compiler-flex-bison.git
cd c-compiler-flex-bison

### 2. Compilation

- **Sous Windows (via le script fourni) :**
  Double-cliquez sur `command.bat` ou lancez-le dans le terminal :
  command.bat

- **Manuellement en ligne de commande :**
  flex lexical.l
  bison -d syntax.y
  gcc lex.yy.c syntax.tab.c -o projet.exe

### 3. Exécution du test

projet.exe < exemple.txt
