      *****************************************************************
      *PURPOSE: This program gives examples:
      * 1. Structure of a COBOL program
      * 2. named memory locations
      * 3. Sequential control
      * 4. Some cobol reserved WORDS
      *****************************************************************

       ID DIVISION.
          PROGRAM-ID.      LAB3.
          AUTHOR.          Kelly.
          DATE-WRITTEN.    February 2016.
          DATE-COMPILED.   CURRENT-DATE.

      *****************************************************************
       ENVIRONMENT DIVISION.
      *   INPUT-OUTPUT SECTION. <to be used later>
      *   FILE-CONTROL.         <to be used later>
      *****************************************************************


       DATA DIVISION.
      *   FILE SECTION.       <to be used later>
      *****************************************************************
       WORKING-STORAGE SECTION.
      **** NAMED MEMORY LOCATIONS *************************************
       01  WS-NAMED-MEMORY-LOCATIONS.
           05 MAILBOX-1  PIC X(50) VALUE
              'This is an example of PIC X character string'.
           05 MAILBOX-2  PIC X(50).
      **** EXAMPLE OF REPURPOSING THE SAME MEMORY ADDRESSES ***********
           05 MAILBOX-3  PIC 9(5)  VALUE 15.
           05 MAILBOX-4  REDEFINES MAILBOX-3 PIC XX.
      *****************************************************************

      *****************************************************************
       PROCEDURE DIVISION.
      ***HERE IS WHERE YOUR EXECUTABLE INSTRUCTINS GO******************
       000-DISPLAY-MESSAGES.
           MOVE 'GET239 Enterprise technologies' TO MAILBOX-1.
           DISPLAY MAILBOX-1
           DISPLAY 'THIS IS GET239 LAB3'
           DISPLAY MAILBOX-3.
           ADD 45 TO MAILBOX-3.
           MOVE MAILBOX-3 TO MAILBOX-4.
           DISPLAY MAILBOX-4.
           display 'Notice the COBOL commands are case-insensitive'
           Display '...but the data is case-sensitve'.
       100-END-PROGRAM.
           STOP RUN.






