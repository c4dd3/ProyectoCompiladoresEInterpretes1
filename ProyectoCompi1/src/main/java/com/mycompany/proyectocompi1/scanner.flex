/* ================= Sección 1: User code (copia tal cual al .java) ================= */
package com.mycompany.proyectocompi1;

/* ===== Corte de sección ===== */
%%

/* ================= Sección 2: Opciones + Macros (AQUÍ van %class, %unicode, etc.) = */
%class Scanner
%unicode
%public
%line
%column
%ignorecase
%type int


/* --- Básicos --- */
DIGITO            = [0-9]                               // dígito
LETRA             = [A-Za-z]                            // letra (mayúscula o minúscula)
IDENTIFICADOR     = {LETRA}({LETRA}|{DIGITO}){0,126}    // identificador: letra seguida de letras/dígitos, hasta 127 caracteres
ESPACIOS          = [ \t\r\n]+                          // espacios en blanco (espacio, tab, retorno de carro, nueva línea)

/* --- Comentarios (no anidados) --- */
COM_LLAVES        = \{[^}]*\}                   /*  { ... }      */
COM_PAREST        = \(\*([^*]|\*+[^)])*\*+\)    /*  (* ... *)    */

/* --- Literales numéricos --- */
HEX               = 0[xX][0-9a-fA-F]+           // hexadecimal (0xFF, 0X1A, ...)
OCT               = 0[0-7]+                     // octal (0, 07, 077, ...)
ENTERO_DEC        = [1-9][0-9]*|0               // decimal (0, 1, 2, ..., sin ceros a la izquierda)
REAL_BASICO       = {DIGITO}+\.{DIGITO}+        // parte entera y decimal (1.0, 0.5, etc.)
EXP               = [eE][+-]?{DIGITO}+          // exprentación científica (E10, e-5, etc.)
REAL              = {REAL_BASICO}({EXP})?       // real con parte entera y decimal, opcionalmente con exponente (3.0, 0.5E10, 1.5e-4, etc.)

/* --- Literales de texto --- */
STRING            = \"([^\"\n])*\"              // string entre comillas dobles (1 sola línea)
CHAR              = \'([^\'\n])\'               // carácter entre comillas simples (ej: 'A', '9', etc.)

/* --- Palabras que funcionan como OPERADORES (reportarlas como OPERADOR) --- */
OPER_PALABRA      = AND|OR|NOT|DIV|MOD|IN|SHL|SHR

/* --- Otras reservadas (todas las del enunciado menos las de OPER_PALABRA) --- */
RESERVADAS = ABSOLUTE|ARRAY|ASM|BEGIN|CASE|CONST|CONSTRUCTOR|DESTRUCTOR|EXTERNAL|DO|DOWNTO|ELSE|END|FILE|FOR|FORWARD|FUNCTION|GOTO|IF|IMPLEMENTATION|INLINE|INTERFACE|INTERRUPT|LABEL|NIL|OBJECT|OF|PACKED|PRIVATE|PROCEDURE|RECORD|REPEAT|SET|STRING|THEN|TO|TYPE|UNIT|UNTIL|USES|VAR|VIRTUAL|WHILE|WITH|XOR

/* --- Operadores y separadores simbólicos (poner largos primero) --- */
OPER_SIMBOLO = \*\*|\+\+|\-\-|<=|>=|<>|=|<|>|\+|\-|\*|\/|,|;|\(|\)|\[|\]|:|\.|\^

/* (Opcional) Guardias de error numérico */
OCT_INVALIDO      = 0[0-7]*[89]             // octal inválido (ej: 09, 078, etc.)
HEX_INVALIDO      = 0[xX][^0-9a-fA-F]       // hexadecimal inválido (ej: 0xG, 0x1Z, etc.)

%%
/* ================= Sección 3: Reglas léxicas ================== */

/* ============================== ESPACIOS ============================== */
{ESPACIOS}                              { /* ignore */ }

/* ============================== COMENTARIOS ============================== */
{COM_LLAVES}                            { /* ignore */ }
{COM_PAREST}                            { /* ignore */ }

/* ============================== ERRORES NUMERICOS ============================== */
{OCT_INVALIDO}                          { TokenCollector.addError("ERROR_LEXICO", yytext(), yyline+1); }
{HEX_INVALIDO}                          { TokenCollector.addError("ERROR_LEXICO", yytext(), yyline+1); }

/* ============================== PALABRAS OPERADOR ============================== */
{OPER_PALABRA}                          { TokenCollector.add("OPERADOR", yytext(), yyline+1); }

/* ============================== PALABRAS RESERVADAS ============================== */
{RESERVADAS}                            { TokenCollector.add("PALABRA_RESERVADA", yytext(), yyline+1); }

/* ============================== OPERADORES SIMBOLOS ============================== */
{OPER_SIMBOLO}                          { TokenCollector.add("OPERADOR", yytext(), yyline+1); }

/* ============================== LITERALES NUMERICOS ============================== */
{HEX}                                   { TokenCollector.add("LITERAL_HEX",    yytext(), yyline+1); }
{OCT}                                   { TokenCollector.add("LITERAL_OCTAL",  yytext(), yyline+1); }
{REAL}                                  { TokenCollector.add("LITERAL_REAL",   yytext(), yyline+1); }
{ENTERO_DEC}                            { TokenCollector.add("LITERAL_ENTERO", yytext(), yyline+1); }

/* ============================== LITERALES DE TEXTO ============================== */
{STRING}                                { TokenCollector.add("LITERAL_STRING", yytext(), yyline+1); }
{CHAR}                                  { TokenCollector.add("LITERAL_CHAR",   yytext(), yyline+1); }

/* ============================== IDENTIFICADORES ============================== */
{IDENTIFICADOR}                         { TokenCollector.add("IDENTIFICADOR", yytext(), yyline+1); }

/* ============================== ERRORES ============================== */
.                                       { TokenCollector.addError("ERROR_LEXICO", yytext(), yyline+1); }
<<EOF>> { return YYEOF; }