       IDENTIFICATION DIVISION.
       PROGRAM-ID.    @MEMBER.
       AUTHOR.        @OPERNAME.
       INSTALLATION.  DAPSCO.
       DATE-WRITTEN.  @DATE.
       DATE-COMPILED.
       REMARKS.       @TITLE.
      * CHANGE HISTORY ------------------------------------------------
      * END OF HISTORY ------------------------------------------------
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT
       DATA DIVISION.
       FILE SECTION.
       FD
       WORKING-STORAGE SECTION.
       01                              PIC  X(20)
                                       VALUE '--WS FOR @MEMBER--'.
       PROCEDURE DIVISION.
           MOVE ZEROES                 TO RETURN-CODE.
           GOBACK.
