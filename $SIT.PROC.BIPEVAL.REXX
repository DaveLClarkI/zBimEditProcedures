/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* REXX: EVALUATE   Proc Created 05/08/2002   By Dave Clark        */
/*                  Last Revised 11/24/2003                        */
/*                                                                 */
/*      This procedure expects  to  be  called by another BIM-EDIT */
/* (non-REXX) procedure and will  attempt  to Interpret the passed */
/* argument string(s) -- which  should  contain  a REXX formula of */
/* some type.  The results are passed back in the &SIBMSG variable */
/* with the first two character positions, of the SIBMSG variable, */
/* containing  the  return  code  reflecting  the  result  of  the */
/* evaluation.                                                     */
/*                                                                 */
/*      BIM-EDIT currently supports  the  passing  of  up to eight */
/* argument  strings  from  a  BIM-EDIT  non-REXX  procedure  to a */
/* BIM-EDIT REXX procedure.   Each argument string can be up to 50 */
/* characters in length.   For this implementation,  the following */
/* rules also apply:                                               */
/*                                                                 */
/*   o  All arguments (except the  last)  must contain one or      */
/*      more complete and stand-alone REXX statements.             */
/*                                                                 */
/*         Use the semi-colon to delimit multiple statements.      */
/*                                                                 */
/*   o  REXX  "Do"  and   other   block  constructs  are  not      */
/*      supported.                                                 */
/*                                                                 */
/*   o  REXX "If" statements  must  be  contained in a single      */
/*      argument.                                                  */
/*                                                                 */
/*   o  REXX  statements   may   not   be  continued  between      */
/*      arguments.                                                 */
/*                                                                 */
/*   o  The last argument must  return  a value -- e.g.,  the      */
/*      last argument cannot be an assignment statement.           */
/*                                                                 */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* No warranty is expressed or implied.    Written by Dave L Clark */
/* Neither the author nor the company is   DAPSCO Information Sys. */
/* responsible for any loss or damage      3110 Kettering Blvd.    */
/* resulting from the use of this code.    Dayton, OH  45439       */
/* Source is provided on an as-is basis.   Phone (937)294-5331     */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* This proc must  be  loaded,  as  a  member,  into the $SIT.PROC */
/* library.   The following line (without  the ruler line) must be */
/* added to $SIT.CTRL.COMMANDS and  the "NEWCOPY COMMANDS" command */
/* issued:                                                         */
/*                                                                 */
/* |---+----1----+----2----|                                       */
/* EVALUATE BIPEVAL                                                */
/*                                                                 */
/* The purpose of the ruler line is to show column positioning.    */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

  q_n = Arg();
  If q_n == 0 Then Do
    Return 'SV'||'(EVALUATE) An argument string is required.'
  End

Signal On Error;
Signal On Failure;
Signal On NoValue;
Signal On Syntax;

  Do q_i = 1 To (q_n-1) By 1
    If Arg(q_i,'Exists') Then Do
      Interpret Arg(q_i)
    End
  End

  Interpret "Return 'OK'||"Arg(q_n)
  Return 'SV'||'(EVALUATE) Internal argument processing error.'

/* --------------------------------------------------------------- */
/* ERROR HANDLERS FOLLOW                                           */
/* --------------------------------------------------------------- */
Error:
  If rc > 0 & rc < 100 Then
    Return 'ER'||ErrorText(rc)
  Else
    Return 'ER'||'(EVALUATE) General error occurred - rc = 'rc

Failure:
  If rc > 0 & rc < 100 Then
    Return 'FA'||ErrorText(rc)
  Else
    Return 'FA'||'(EVALUATE) General failure occurred - rc = 'rc

NoValue:
  If rc > 0 & rc < 100 Then
    Return 'NV'||ErrorText(rc)
  Else
    Return 'NV'||'(EVALUATE) Uninitialized variable encountered.'

Syntax:
  If rc > 0 & rc < 100 Then
    Return 'SY'||ErrorText(rc)
  Else
    Return 'SY'||'(EVALUATE) Syntax error occurred - rc = 'rc

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
