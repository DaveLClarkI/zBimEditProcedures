/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* REXX: SLEEP      Proc Created 05/30/2016   By Dave Clark        */
/*                  Last Revised 05/30/2016                        */
/*                                                                 */
/*      This procedure expects  to  be  called by another BIM-EDIT */
/* (non-REXX)  procedure  and  will  optionally  accept  a  single */
/* argument string -- which should  contain a number of seconds to */
/* sleep.   If omitted or argument  value  is  not a whole number, */
/* then the default sleep time is 1 second.                        */
/*                                                                 */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* No warranty is expressed or implied.    Written by Dave L Clark */
/* Neither the author nor the company is   Winsupply Group Svcs.   */
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
/* EVALUATE BIPSLEEP                                               */
/*                                                                 */
/* The purpose of the ruler line is to show column positioning.    */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

Signal On Error;
Signal On Failure;
Signal On NoValue;
Signal On Syntax;

  q_sec = Arg(1);            /* get optional argument value */
  If \Datatype(q_sec,'W') Then Do
    q_sec = 1;               /* if invalid, use default value */
  End

  rc = Sleep(q_sec);         /* delay processing */
  If rc <> 0 Then Signal Error;

  Return 'OK'||'(SLEEP) Sleep period expired.'

/* --------------------------------------------------------------- */
/* ERROR HANDLERS FOLLOW                                           */
/* --------------------------------------------------------------- */
Error:
  If rc > 0 & rc < 100 Then
    Return 'ER'||ErrorText(rc)
  Else
    Return 'ER'||'(SLEEP) General error occurred - rc = 'rc

Failure:
  If rc > 0 & rc < 100 Then
    Return 'FA'||ErrorText(rc)
  Else
    Return 'FA'||'(SLEEP) General failure occurred - rc = 'rc

NoValue:
  If rc > 0 & rc < 100 Then
    Return 'NV'||ErrorText(rc)
  Else
    Return 'NV'||'(SLEEP) Uninitialized variable encountered.'

Syntax:
  If rc > 0 & rc < 100 Then
    Return 'SY'||ErrorText(rc)
  Else
    Return 'SY'||'(SLEEP) Syntax error occurred - rc = 'rc

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
