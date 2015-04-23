
/* --------------------------Codigo de Usuario----------------------- */
package project;

import java_cup.runtime.*;
import java.io.Reader;
      
%% //inicio de opciones
   
/* ------ Seccion de opciones y declaraciones de JFlex -------------- */  
   
/* 
    Cambiamos el nombre de la clase del analizador a Lexer
*/
%class AnalizadorLexico

/*
    Activar el contador de lineas, variable yyline
    Activar el contador de columna, variable yycolumn
*/
%line
%column
    
/* 
   Activamos la compatibilidad con Java CUP para analizadores
   sintacticos(parser)
*/
%cup
   
/*
    Declaraciones

    El codigo entre %{  y %} sera copiado integramente en el 
    analizador generado.
*/
%{
    /*  Generamos un java_cup.Symbol para guardar el tipo de token 
        encontrado */
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    /* Generamos un Symbol para el tipo de token encontrado 
       junto con su valor */
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
   

/*
    Macro declaraciones
  
    Declaramos expresiones regulares que despues usaremos en las
    reglas lexicas.
*/
   
/*  Un salto de linea es un \n, \r o \r\n dependiendo del SO   */
Salto = \r|\n|\r\n
   
/* Espacio es un espacio en blanco, tabulador \t, salto de linea 
    o avance de pagina \f, normalmente son ignorados */
Espacio     = {Salto} | [ \t\f]

/*Identificador para las variables*/
Id = [a-z][a-zA-Z0-9]+

/*Como escribir una direccion.. creo que no deberia ser asi pero bueno...*/
Direccion = "C:\\"([a-z0-9]"\\")+".jpg"

/* Una literal entera es un numero 0 oSystem.out.println("\n*** Generado " + archNombre + "***\n"); un digito del 1 al 9 
    seguido de 0 o mas digitos del 0 al 9 */
Entero = 0 | [1-9][0-9]*

Player = "Player"
Enemy = "Enemy"
Object = "Object"
Bkg = "bkg"
Img = "img"
Atk = "atk"
Hpt = "hpt"
Pos = "pos"
ParOr = {Entero}","{Entero}
Del ="del"


%% //fin de opciones
/* -------------------- Seccion de reglas lexicas ------------------ */
   
/*
   Esta seccion contiene expresiones regulares y acciones. 
   Las acciones son código en Java que se ejecutara cuando se
   encuentre una entrada valida para la expresion regular correspondiente */
   
   /* YYINITIAL es el estado inicial del analizador lexico al escanear.
      Las expresiones regulares solo serán comparadas si se encuentra
      en ese estado inicial. Es decir, cada vez que se encuentra una 
      coincidencia el scanner vuelve al estado inicial. Por lo cual se ignoran
      estados intermedios.*/
   
<YYINITIAL> {
   
    /* Regresa que el token SEMI declarado en la clase sym fue encontrado. */
    ";"					{ return symbol(sym.SEMI); }
    /* Regresa el token ASSIGN declarado en la clase sym fue encontrado */
    "="					{ return symbol(sym.ASSIGN); }
    {Player}		{ return symbol(sym.PLAYER);}
    {Enemy}			{ return symbol(sym.ENEMY);}
    {Object}	  { return symbol(sym.OBJECT);}
    {Bkg}				{ return symbol(sym.BKG);}
    {Img}				{ return symbol(sym.IMG);}
    {Atk}				{ return symbol(sym.ATK);}
    {Hpt}	  		{ return symbol(sym.HP);}
    {Pos}				{ return symbol(sym.POS);}
    {Del}				{ return symbol(sym.DEL);}
    "."         { return symbol(sym.DOT);}
    /* Si se encuentra un entero, se imprime, se regresa un token numero
        que representa un entero y el valor que se obtuvo de la cadena yytext
        al convertirla a entero. yytext es el token encontrado. */
    {Entero}      {   System.out.print(yytext()); 
                      return symbol(sym.ENTERO, new Integer(yytext())); }
    {Id}          { return symbol(sym.ID, new String(yytext()); }
    {Direccion}   { return symbol(sym.DIR, new String(yytext());}
    {ParOr}       { return symbol(sym.PAR, new Vector2(yytext()));}
    /* No hace nada si encuentra el espacio en blanco */
    {Espacio}     { /* ignora el espacio */ } 
}


/* Si el token contenido en la entrada no coincide con ninguna regla
    entonces se marca un token ilegal */
[^]                    { throw new Error("Caracter ilegal <"+yytext()+">"); }
