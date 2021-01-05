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
           05 EMPLOYEE-NAME.
              10 EMP-FIRST-NAME         PIC X(20).
              10 EMP-LAST-NAME          PIC X(30).

           05 HIRED-DATE.
              10 HIRED-MM               PIC 9(2).
              10 HIRED-DD               PIC 9(2).
              10 HIRED-YY               PIC 9(4).

           05 SERVICES-YEARS            PIC 9(2).
           05 ANNUAL-SALARY             PIC 9999999V99  VALUE 79000.13 .
           05 BI-WEEKLY-GROSS-PAY       PIC 9999999V99.
           05 SUPPRESS-ZERO             PIC ZZZ9,999.99.

       01  WS-TODAY.
             05  WS-CURRENT-DATE.
                 10  WS-CURRENT-YEAR    PIC  9(4).


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
           MOVE 'Kelly'     TO EMP-FIRST-NAME.
           MOVE 'Oliveira'  TO EMP-LAST-NAME.

       200-FORMAT-STUDENT-BIRTH.
           MOVE 01   TO HIRED-MM.
           MOVE 01   TO HIRED-DD.
           MOVE 1996 TO HIRED-YY.

       300-CALCULATE-SERVICE.
           MOVE FUNCTION CURRENT-DATE (1:8) TO WS-TODAY.
           SUBTRACT HIRED-YY FROM WS-CURRENT-YEAR GIVING SERVICES-YEARS.

       400-CALCULATE-PAYMENT.
           COMPUTE BI-WEEKLY-GROSS-PAY ROUNDED = (ANNUAL-SALARY / 26) .


       500-DISPLAY-RESULTS.
           DISPLAY 'Employee First Name: ' EMP-FIRST-NAME.
           DISPLAY 'Employee Last Name : ' EMP-LAST-NAME.
           DISPLAY 'Curret Year        : ' WS-CURRENT-YEAR.
           DISPLAY 'Year Hired         : ' HIRED-YY.
           DISPLAY 'Years of Service   :   ' SERVICES-YEARS.
           MOVE ANNUAL-SALARY TO SUPPRESS-ZERO.
           DISPLAY 'Annual Salary      :  ' SUPPRESS-ZERO.
           MOVE BI-WEEKLY-GROSS-PAY TO SUPPRESS-ZERO.
           DISPLAY 'Bi-weekly Amount   :  ' SUPPRESS-ZERO.
           DISPLAY '******************************************'.
           DISPLAY '* End Of LAB4.                           *'.
           DISPLAY '******************************************'.

       999-END-PROGRAM.
           STOP RUN.




