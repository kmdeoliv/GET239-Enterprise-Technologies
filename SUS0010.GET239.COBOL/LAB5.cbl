      *****************************************************************
      *PURPOSE: This program gives examples:
      * 1. Structure of a COBOL program
      * 2. named memory locations
      * 3. Sequential control
      * 4. Some cobol reserved WORDS
      *****************************************************************

       ID DIVISION.
          PROGRAM-ID.      LAB5.
          AUTHOR.          Kelly.
          DATE-WRITTEN.    March 2016.
          DATE-COMPILED.   CURRENT-DATE.

      *****************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CRIME-FILE-IN ASSIGN TO CRIMEIN
           ORGANIZATION IS SEQUENTIAL.
           SELECT REPORT-OUT ASSIGN TO REPORTOT
           ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD CRIME-FILE-IN.
      *****************************************************************
      * READ ME: Do not change this record layout
      * Chicago City Crime record - Length 249
      *****************************************************************
       01  CC-CRIME-RECORD.
           05  CC-CASE-NUMBER               PIC X(8).
           05  CC-DATE-TIME                 PIC X(15).
           05  CC-ADDRESS                   PIC X(40).
           05  CC-IUCR                      PIC X(4).
           05  CC-PRIMARY-CRIME             PIC X(30).
           05  CC-CRIME-DESC                PIC X(50).
           05  CC-LOCATION                  PIC X(50).
           05  CC-ARREST                    PIC X.
           05  CC-DOMESTIC                  PIC X.
           05  CC-BEAT                      PIC X(4).
           05  CC-WARD                      PIC X(2).
           05  CC-FBI-CODE                  PIC X(3).
           05  CC-X-COORD                   PIC X(7).
           05  CC-Y-COORD                   PIC X(7).
           05  CC-YEAR                      PIC X(4).
           05  CC-LAT                       PIC X(11).
           05  CC-LONG                      PIC X(12).
      ******* End of Chicago City Crime Record ************************
       FD  REPORT-OUT.
       01  REPORT-REC.
           05  RP-CASE-NUMBER               PIC X(8).
           05                               PIC X.
           05  RP-DATE-TIME                 PIC X(15).
           05                               PIC X.
           05  RP-ADDRESS                   PIC X(40).
           05                               PIC X.
           05  RP-IUCR                      PIC X(4).
           05                               PIC X.
           05  RP-PRIMARY-CRIME             PIC X(30).
           05                               PIC X.
           05  RP-CRIME-DESC                PIC X(50).
           05                               PIC X.
           05  RP-LOCATION                  PIC X(50).
           05                               PIC X.
           05  RP-ARREST                    PIC X.
           05                               PIC X.
           05  RP-DOMESTIC                  PIC X.
           05                               PIC X.
           05  RP-BEAT                      PIC X(4).
           05                               PIC X.
           05  RP-WARD                      PIC X(2).
           05                               PIC X.
           05  RP-FBI-CODE                  PIC X(3).
           05                               PIC X.
           05  RP-X-COORD                   PIC X(7).
           05                               PIC X.
           05  RP-Y-COORD                   PIC X(7).
           05                               PIC X.
           05  RP-YEAR                      PIC X(4).
           05                               PIC X.
           05  RP-LAT                       PIC X(11).
           05                               PIC X.
           05  RP-LONG                      PIC X(12).

      *****************************************************************
       WORKING-STORAGE SECTION.
       01 WS-NAMED-MEMORY-LOCATIONS.
      **** SWITCHES ***************************************************
           05 EOF-SWITCH               PIC X        VALUE 'N'.
              88 EOF                                VALUE 'Y'.
           05 CRIME-REC-READ           PIC 9(7)     VALUE 0.
       01 CRIME-REC-READZ          PIC Z,ZZZ,ZZ9.
       01 CRIME-REC-COUNT-IN       PIC 9(7)     VALUE 0.
       01 CRIME-REC-COUNT-INZ      PIC Z,ZZZ,ZZ9.
       01 CRIME-REC-COUNT-OUT      PIC 9(7)     VALUE 0.
       01 CRIME-REC-COUNT-OUTZ     PIC Z,ZZZ,ZZ9.

      *****************************************************************
       PROCEDURE DIVISION.
      *****************************************************************
       MAIN-PROGRAM.
      *************************************
           PERFORM 100-DISPLAY-SPLASH-PAGE.
           PERFORM 200-OPEN-FILES.
           PERFORM 300-READ-CRIME-FILE UNTIL EOF.
           PERFORM 400-DISPLAY-SUMMARY-TOTALS.
           PERFORM 500-CLOSE-FILES.
           STOP RUN.
       END-MAIN-PROGRAM.

      *****************************************************************
       100-DISPLAY-SPLASH-PAGE.
           DISPLAY '******************************************'.
           DISPLAY '* GET239 Enterprise Technologies LAB5    *'.
           DISPLAY '* Kelly Oliveira                         *'.
           DISPLAY '* March, 2016                            *'.
           DISPLAY '******************************************'.

      *****************************************************************
       200-OPEN-FILES.
           OPEN  INPUT CRIME-FILE-IN
                OUTPUT REPORT-OUT.
      *****************************************************************
       300-READ-CRIME-FILE.
           READ CRIME-FILE-IN
               AT END MOVE 'Y' TO EOF-SWITCH.
           IF NOT EOF
             ADD 1 TO CRIME-REC-READ
             IF CRIME-REC-COUNT-IN < 10
                 ADD 1 TO CRIME-REC-COUNT-IN
                 PERFORM 310-PROCESS-CRIME-RECORDS
             END-IF
             END-IF.
      ******************************************************
       310-PROCESS-CRIME-RECORDS.
           ADD 1 TO CRIME-REC-COUNT-OUT.
           MOVE CC-CASE-NUMBER TO RP-CASE-NUMBER.
           MOVE CC-DATE-TIME TO RP-DATE-TIME.
           MOVE CC-ADDRESS TO RP-ADDRESS.
           MOVE CC-IUCR TO RP-IUCR.
           MOVE CC-PRIMARY-CRIME TO RP-PRIMARY-CRIME.
           MOVE CC-CRIME-DESC TO RP-CRIME-DESC.
           MOVE CC-LOCATION TO RP-LOCATION.
           MOVE CC-ARREST TO RP-ARREST.
           MOVE CC-DOMESTIC TO RP-DOMESTIC.
           MOVE CC-BEAT TO RP-BEAT.
           MOVE CC-WARD TO RP-WARD.
           MOVE CC-FBI-CODE TO RP-FBI-CODE.
           MOVE CC-X-COORD TO RP-X-COORD.
           MOVE CC-Y-COORD TO RP-Y-COORD.
           MOVE CC-YEAR TO RP-YEAR.
           MOVE CC-LAT TO RP-LAT.
           MOVE CC-LONG TO RP-LONG.

           WRITE REPORT-REC.

      *****************************************************************

       400-DISPLAY-SUMMARY-TOTALS.
           MOVE CRIME-REC-READ  TO CRIME-REC-READZ.
           DISPLAY 'Total Recs Read  : ' CRIME-REC-READZ.
           MOVE CRIME-REC-COUNT-IN  TO CRIME-REC-COUNT-INZ.
           DISPLAY 'Total Recs In    : ' CRIME-REC-COUNT-INZ.
           MOVE CRIME-REC-COUNT-OUT TO CRIME-REC-COUNT-OUTZ.
           DISPLAY 'Total Recs Out   : ' CRIME-REC-COUNT-OUTZ.
           DISPLAY '******************************************'.
           DISPLAY '* End of Crime Reformat Program          *'.
           DISPLAY '******************************************'.
      *****************************************************************
       500-CLOSE-FILES.
           CLOSE CRIME-FILE-IN
                 REPORT-OUT.
      *****************************************************************
      * END OF THE PROGRAM.
      *****************************************************************





