package project;
%%
%class Lexer
%type Token

L = [a-z]+
D = [0-9]+
white = [ \t\n\r]+
%{
	public String lexeme;
%}
%%


"//" {/*Ignore*/}

"C:\"",jpg"	{lexeme=yytext(); return image}

[a-z][a-z0-9"_""-""."]+["@"][a-zA-Z0-9_"-"]+("."[a-zA-Z0-9_"-""=""/"]+)+	{lexeme=yytext(); return email;}
("http://")?"www.youtube.com/"[a-zA-Z_="?"0-9"/""-"]+	{lexeme=yytext(); return youtube;}
([a-z]+"://")?[a-zA-Z0-9_"-"]+("."[a-zA-Z0-9_"-""=""/"]+)+("/"[a-zA-Z0-9_"-""=""?""%"]+)*"/"?	{lexeme=yytext(); return url;}

[A-Z][a-z]+((["_"][a-z]{1,3})*["_"][A-Z][a-z]+){1,5}	{lexeme=yytext(); return name;}
(\x28[0-9]{2}\x29["-"])?[0-9]{2}(["-"][0-9]{2}){3}	{lexeme=yytext(); return localT;}
("("[0-9]{3}")-")?[0-9]{2}("-"[0-9]{2}){4}	{lexeme=yytext(); return celT;}
"="	{return igual;}
"+"	{return suma;}
{L}	{lexeme =yytext(); return variable;}
{D} {lexeme=yytext(); return numero; }
[a-z]+ ([0-9]+ | [a-z]+)* {lexeme=yytext(); return ID;}
"*"	{return multiplicacion;}
"-" {return resta;}
"/"	{return division;}
. {lexeme=yytext(); return ERROR;}
