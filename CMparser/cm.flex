/*
  Created By: Fei Song
  File Name: cm.flex
  To Build: jflex cm.flex

  and then after the parser is created
    javac Lexer.java
*/
   
/* --------------------------Usercode Section------------------------ */
   
import java_cup.runtime.*;
      
%%
   
/* -----------------Options and Declarations Section----------------- */
   
/* 
   The name of the class JFlex will create will be Lexer.
   Will write the code to the file Lexer.java. 
*/
%class Lexer

%eofval{
  return null;
%eofval};

/*
  The current line number can be accessed with the variable yyline
  and the current column number with the variable yycolumn.
*/
%line
%column
    
/* 
   Will switch to a CUP compatibility mode to interface with a CUP
   generated parser.
*/
%cup
   
/*
  Declarations
   
  Code between %{ and %}, both of which must be at the beginning of a
  line, will be copied letter to letter into the lexer class source.
  Here you declare member variables and functions that are used inside
  scanner actions.  
*/
%{   
    /* To create a new java_cup.runtime.Symbol with information about
       the current token, the token will have no value in this
       case. */
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    /* Also creates a new java_cup.runtime.Symbol with information
       about the current token, but this object has a value. */
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
   

/*
  Macro Declarations
  
  These declarations are regular expressions that will be used latter
  in the Lexical Rules Section.  
*/
   
/* A line terminator is a \r (carriage return), \n (line feed), or
   \r\n. */
LineTerminator = \r|\n|\r\n
   
/* White space is a line terminator, space, tab, or form feed. */
WhiteSpace     = {LineTerminator} | [ \t\f]
   
/* A literal integer is is a number beginning with a number between
   one and nine followed by zero or more numbers between zero and nine
   or just a zero.  */
digit = [0-9]
number = {digit}+

identifier = [_a-zA-Z][_a-zA-Z0-9]*

truth = "false" | "true" //TRUTH = false | true


%%
/* ------------------------Lexical Rules Section---------------------- */
   
/*
   This section contains regular expressions and actions, i.e. Java
   code, that will be executed when the scanner matches the associated
   regular expression. */

"bool"            { return symbol(sym.BOOL); }
"if"               { return symbol(sym.IF); }
"else"             { return symbol(sym.ELSE); }
"while"             { return symbol(sym.WHILE); }
"return"            { return symbol(sym.RETURN); }
"void"            { return symbol(sym.VOID); }
"int"            { return symbol(sym.INT); }
"+"                { return symbol(sym.PLUS); }
"-"                { return symbol(sym.MINUS); }
"*"                { return symbol(sym.TIMES); }
"/"                { return symbol(sym.DIVIDE); }
"<"                { return symbol(sym.LT); }
"<="                { return symbol(sym.LTE); }
">"                { return symbol(sym.GT); }
">="                { return symbol(sym.GTE); }
"=="                { return symbol(sym.COMP); }
"!="                { return symbol(sym.NE); }
"~"                { return symbol(sym.TILDA); }
"||"                { return symbol(sym.OR); }
"&&"                { return symbol(sym.AND); }
"="                { return symbol(sym.EQ); }
";"                { return symbol(sym.SEMI); }
","                { return symbol(sym.COMMA); }
"("                { return symbol(sym.LPAREN); }
")"                { return symbol(sym.RPAREN); }
"["                { return symbol(sym.LBRACK); }
"]"                { return symbol(sym.RBRACK); }
"{"                { return symbol(sym.LCB); }
"}"                { return symbol(sym.RCB); }
{number}           { return symbol(sym.NUM, yytext()); }
{truth}           { return symbol(sym.TRUTH, yytext()); } 
{identifier}       { return symbol(sym.IDEN, yytext()); }
{WhiteSpace}+      { /* skip whitespace */ }  
"/*" ~ "*/"      { /* skip comments */ }
.                  { return symbol(sym.ERROR); }
