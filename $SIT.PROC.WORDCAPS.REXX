/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* REXX: WORDCAPS   Proc Created 05/17/2002   by Dave Clark        */
/*                  Last Revised 05/20/2002                        */
/*                                                                 */
/* This REXX procedure expects to be called from within a standard */
/* BIM-EDIT procedure.   It accepts a single argument and performs */
/* word capitalization upon that argument.  The results are passed */
/* back in  the  &SIBMSG  variable  with  the  first two character */
/* positions,  of the &SIBMSG variable, containing the return code */
/* reflecting the result of the capitalization.                    */
/*                                                                 */
/* Alternatively,  if no arguement  is found,  this REXX procedure */
/* presumes that it is being  executed  from the command line of a */
/* BIM-EDIT updatable session.   Thus,  the content of the current */
/* session line is  extracted  and  used  as the missing arguement */
/* value.   The results, in this case, are applied directly to the */
/* current session line.                                           */
/*                                                                 */
/* No warranty is expressed or implied.    Written by Dave L Clark */
/* Neither the author nor the company is   DAPSCO Information Sys. */
/* responsible for any loss or damage      3110 Kettering Blvd.    */
/* resulting from the use of this code.    Dayton, OH  45439       */
/* Source is provided on an as-is basis.   Phone (937)294-5331     */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
Arg str

  If str == '' Then Do
    'SET   PPDVBL 1                    '
    'EXPVBL &SSDTYPE                   '
    If Left(Result,1) <> 'E' Then Do
      Exit '(WORDCAPS) ** NOT AN EDIT SESSION **'
    End
    'SETD  PARMLIST XTRSLINE           '
    'VEXAM PARMLIST "\@ %?"            '
    If SIBRC <> 'OK' Then Do
      Exit '(WORDCAPS) ** NOTHING TO WORK ON **'
    End
    'EXPVBL &PPDCOL                    '
    pos = Result * 1
    'SETD  PARMLIST PARMLIST{'||pos||',50}'
    'VTRUN PARMLIST                    '
    'SESS  M                           '
    'EXPVBL &PARMLIST                  '
    str = myProcess(Result)
    'OVERLAY '||pos||' "'||str||'"'
    Return
  End

  str = myProcess(str)

Return 'OK'||str

/* ----------------------------------------------------------------- */
myProcess: Procedure
  Arg str

  uc = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  lc = 'abcdefghijklmnopqrstuvwxyz'
  str = Translate(str,lc,uc)

  Do i = 1 to Words(str)
    j = WordIndex(str,i)
    str = Overlay(Translate(Substr(str,j,1)),str,j,1)
  End

Return str

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
