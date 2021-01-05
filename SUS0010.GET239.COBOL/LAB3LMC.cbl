      *****************************************************************
       ID DIVISION.
          PROGRAM-ID.      GET239.
          AUTHOR.          KELLY DE OLIVEIRA.
          DATE-WRITTEN.    February 2016.
          DATE-COMPILED.   CURRENT-DATE.
      *****************************************************************
       ENVIRONMENT DIVISION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       01  WS-NAMED-MEMORY-LOCATIONS.
           05 MAILBOX-1   PIC 9(3) VALUE 15.
           05 MAILBOX-2   PIC 9(3) VALUE 45.
           05 MAILBOX-3   PIC 9(3) VALUE 40.
           05 MAILBOX-4   PIC 9(3) VALUE 100.
           05 MAILBOX-95  PIC 9(3).
           05 MAILBOX-96  PIC 9(3).
           05 MAILBOX-97  PIC 9(3).
           05 MAILBOX-98  PIC 9(3).
           05 MAILBOX-99  PIC 9(3).
           05 SUPPRESS-ZERO PIC Z99.

       PROCEDURE DIVISION.

       000-DISPLAY-MESSAGES.

           DISPLAY '  ***********************************************'.
           DISPLAY '  * GET239 ENTERPRISE TECHNOLOGIES LAB3LMC3     *'.
           DISPLAY '  * Kelly De Oliveira                           *'.
           DISPLAY '  * February 10, 2016                           *'.
           DISPLAY '  ***********************************************'.

           MOVE MAILBOX-1 TO MAILBOX-95.
           MOVE MAILBOX-2 TO MAILBOX-96.
           MOVE MAILBOX-3 TO MAILBOX-97.
           MOVE MAILBOX-4 TO MAILBOX-98.

           ADD MAILBOX-95 TO MAILBOX-99.
           ADD MAILBOX-96 TO MAILBOX-99.
           ADD MAILBOX-97 TO MAILBOX-99.
           ADD MAILBOX-98 TO MAILBOX-99.

           MOVE MAILBOX-95 TO SUPPRESS-ZERO.
           DISPLAY '       ' SUPPRESS-ZERO.
           MOVE MAILBOX-96 TO SUPPRESS-ZERO.
           DISPLAY '       ' SUPPRESS-ZERO.
           MOVE MAILBOX-97 TO SUPPRESS-ZERO.
           DISPLAY '       ' SUPPRESS-ZERO.
           DISPLAY '       ' MAILBOX-98.
           DISPLAY '       ---'.
           DISPLAY '   SUM ' MAILBOX-99.
           DISPLAY '  ***********************************************'.
           DISPLAY '  * End Of LAB3LMC.                             *'.
           DISPLAY '  ***********************************************'.

       100-END-PROGRAM.
           STOP RUN.




