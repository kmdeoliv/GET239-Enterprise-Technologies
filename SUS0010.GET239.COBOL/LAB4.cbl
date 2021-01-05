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

       DATA DIVISION.

       WORKING-STORAGE SECTION.
      **** NAMED MEMORY LOCATIONS *************************************
       01  WS-NAMED-MEMORY-LOCATIONS.
           05 STUDENT-NAME.
              10 STUDENT-FIRST-NAME     PIC X(10).
              10 STUDENT-MIDDLE-INIT    PIC X.
              10 STUDENT-LAST-NAME      PIC X(20).
           05 STUDENT-BIRTH-RATE.
              10 STUDENT-BIRTH-MM       PIC 99.
              10                        PIC X  VALUE  '/'.
              10 STUDENT-BIRTH-DD       PIC 99.
              10                        PIC X  VALUE  '/'.
              10 STUDENT-BIRTH-YY       PIC 9(4).
           05 STUDENT-GPA               PIC 9V999 VALUE 0.
           05 STUDENT-GPA2              PIC 9V999 VALUE 0.
           05 STUDENT-GPA-Z             PIC Z.999.

      *****************************************************************
       PROCEDURE DIVISION.
      ***HERE IS WHERE YOUR EXECUTABLE INSTRUCTINS GO******************
       000-DISPLAY-SPLASH-PAGE.
           DISPLAY '******************************************'.
           DISPLAY '* GET239 Enterprise Technologies LAB4    *'.
           DISPLAY '* Kelly Oliveira                         *'.
           DISPLAY '* February 11, 2016                      *'.
           DISPLAY '******************************************'.

       100-FORMAT-STUDENT-NAME.
           MOVE 'Kelly'     TO STUDENT-FIRST-NAME.
           MOVE 'M'         TO STUDENT-MIDDLE-INIT.
           MOVE 'Oliveira'  TO STUDENT-LAST-NAME.

       200-FORMAT-STUDENT-BIRTH.
           MOVE 05   TO STUDENT-BIRTH-MM.
           MOVE 10   TO STUDENT-BIRTH-DD.
           MOVE 1991 TO STUDENT-BIRTH-YY.

       300-CALCULATE-GPA.
           ADD 1 TO STUDENT-GPA.
           DIVIDE STUDENT-GPA BY 2 GIVING STUDENT-GPA.
           MULTIPLY STUDENT-GPA BY 7 GIVING STUDENT-GPA.
           SUBTRACT 3 FROM STUDENT-GPA.
           COMPUTE STUDENT-GPA2=((((STUDENT-GPA2 + 1) / 2) * 7) - 3 ).

       400-DISPLAY-RESULTS.
           MOVE STUDENT-GPA TO STUDENT-GPA-Z.
           DISPLAY 'Student Name: ' STUDENT-NAME.
           DISPLAY 'Birth Date  : ' STUDENT-BIRTH-RATE.
           DISPLAY 'GPA         : ' STUDENT-GPA-Z.
           MOVE STUDENT-GPA2 TO STUDENT-GPA-Z.
           DISPLAY 'GPA2        : ' STUDENT-GPA-Z.
           DISPLAY '******************************************'.

       999-END-PROGRAM.
           STOP RUN.





