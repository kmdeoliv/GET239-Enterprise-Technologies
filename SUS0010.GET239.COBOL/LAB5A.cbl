      *****************************************************************
      *PURPOSE: This program gives examples:
      * 1. Structure of a COBOL program
      * 2. named memory locations
      * 3. Sequential control
      * 4. Some cobol reserved WORDS
      *****************************************************************

       ID DIVISION.
          PROGRAM-ID.      LAB5A.
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
       01 OUT-REC                           PIC X(80).
       01  REPORT-REC.
           05  RP-DATE-TIME                 PIC X(15).
           05                               PIC X.
           05  RP-ADDRESS                   PIC X(19).
           05                               PIC X.
           05  RP-PRIMARY-CRIME             PIC X(21).
           05                               PIC X.
           05  RP-CRIME-DESC                PIC X(20).
           05                               PIC X.
           05  RP-ARREST                    PIC X.
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
       01 CRIME-DATE               PIC X(10).
       01 CRIME-TIME               PIC X(5).

      *****HEADING*****************************************************
       01 HDG-LINE1.
           05 FILLER         PIC X(32)
                 VALUE 'CHICAGO 2009 MIDNIGHT-3AM REPORT'.

       01 HDG-LINE2.
           05 FILLER PIC X(16) VALUE 'DATE-TIME       '.
           05 FILLER PIC X(20) VALUE 'ADDRESS             '.
           05 FILLER PIC X(22) VALUE 'PRIMARY CRIME         '.
           05 FILLER PIC X(21) VALUE 'CRIME-DESC           '.
           05 FILLER PIC X     VALUE 'A'.



      *****************************************************************
       PROCEDURE DIVISION.
      *****************************************************************
       MAIN-PROGRAM.
      *************************************
           PERFORM 100-DISPLAY-SPLASH-PAGE.
           PERFORM 200-OPEN-FILES.
           PERFORM 300-HDG-ROUTINE.
           PERFORM 400-READ-CRIME-FILE UNTIL EOF.
           PERFORM 500-DISPLAY-SUMMARY-TOTALS.
           PERFORM 600-CLOSE-FILES.
           STOP RUN.
       END-MAIN-PROGRAM.

      *****************************************************************
       100-DISPLAY-SPLASH-PAGE.
           DISPLAY '******************************************'.
           DISPLAY '* GET239 Enterprise Technologies LAB5A   *'.
           DISPLAY '* Kelly Oliveira                         *'.
           DISPLAY '* March, 2016                            *'.
           DISPLAY '******************************************'.

      *****************************************************************
       200-OPEN-FILES.
           OPEN  INPUT CRIME-FILE-IN
                OUTPUT REPORT-OUT.
      *****************************************************************
       300-HDG-ROUTINE.
           MOVE HDG-LINE1 TO OUT-REC.
           WRITE OUT-REC.
           MOVE HDG-LINE2 TO OUT-REC.
           WRITE OUT-REC.


       400-READ-CRIME-FILE.
           READ CRIME-FILE-IN
               AT END MOVE 'Y' TO EOF-SWITCH.
           IF NOT EOF
             ADD 1 TO CRIME-REC-READ
             UNSTRING CC-DATE-TIME DELIMITED BY SPACE
                INTO CRIME-DATE, CRIME-TIME
             END-UNSTRING

             IF CRIME-DATE = '1/1/2009'
                IF CRIME-TIME>='0:00' AND CRIME-TIME <='3:00'
                 IF CRIME-TIME(2:1) = ':'
                   IF  CC-ARREST = 'F'
                     ADD 1 TO CRIME-REC-COUNT-IN
                     PERFORM 410-PROCESS-CRIME-RECORDS
                   END-IF
                 END-IF
                END-IF
             END-IF
            END-IF.
      ******************************************************
       410-PROCESS-CRIME-RECORDS.
           ADD 1 TO CRIME-REC-COUNT-OUT.
           MOVE CC-DATE-TIME TO RP-DATE-TIME.
           MOVE CC-ADDRESS TO RP-ADDRESS.
           MOVE CC-PRIMARY-CRIME TO  RP-PRIMARY-CRIME.
           MOVE CC-CRIME-DESC TO  RP-CRIME-DESC.
           MOVE CC-ARREST TO RP-ARREST.
           WRITE REPORT-REC.

      *****************************************************************

       500-DISPLAY-SUMMARY-TOTALS.
           MOVE CRIME-REC-READ  TO CRIME-REC-READZ.
           DISPLAY 'Total Recs Read  : ' CRIME-REC-READZ.
           MOVE CRIME-REC-COUNT-IN  TO CRIME-REC-COUNT-INZ.
           DISPLAY 'Total Recs In    : ' CRIME-REC-COUNT-INZ.
           MOVE CRIME-REC-COUNT-OUT TO CRIME-REC-COUNT-OUTZ.
           DISPLAY 'Total Recs Out   : ' CRIME-REC-COUNT-OUTZ.
           DISPLAY '******************************************'.
           DISPLAY '* End of Chicago Midnight to 3 am Report *'.
           DISPLAY '******************************************'.
      *****************************************************************
       600-CLOSE-FILES.
           CLOSE CRIME-FILE-IN
                 REPORT-OUT.
      *****************************************************************
      * END OF THE PROGRAM.
      *****************************************************************



