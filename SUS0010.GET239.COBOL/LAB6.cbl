      *****************************************************************
      *PURPOSE: This program gives examples:
      * 1. Structure of a COBOL program
      * 2. named memory locations
      * 3. Sequential control
      * 4. Some cobol reserved WORDS
      *****************************************************************

       ID DIVISION.
          PROGRAM-ID.      LAB6.
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
      *****************************************************************
       01 CRIME-REC-READ           PIC 9(7)     VALUE 0.
       01 CRIME-REC-READZ          PIC Z,ZZZ,ZZ9.
       01 CRIME-REC-COUNT-2009     PIC 9(7)     VALUE 0.
       01 CRIME-REC-COUNT-2009Z    PIC Z,ZZZ,ZZ9.
       01 CRIME-REC-COUNT-2010     PIC 9(7)     VALUE 0.
       01 CRIME-REC-COUNT-2010Z    PIC Z,ZZZ,ZZ9.
       01 CRIME-REC-NO-ARREST      PIC 9(7)     VALUE 0.
       01 CRIME-REC-NO-ARRESTZ     PIC Z,ZZZ,ZZ9.
       01 CRIME-REC-SIMPLE         PIC 9(7)     VALUE 0.
       01 CRIME-REC-SIMPLEZ        PIC Z,ZZZ,ZZ9.
       01 CRIME-REC-AGGRAVATED     PIC 9(7)     VALUE 0.
       01 CRIME-REC-AGGRAVATEDZ    PIC Z,ZZZ,ZZ9.
       01 CRIME-REC-CYBER          PIC 9(7)     VALUE 0.
       01 CRIME-REC-CYBERZ         PIC Z,ZZZ,ZZ9.
       01 CRIME-REC-VIOLATIONS     PIC 9(7)     VALUE 0.
       01 CRIME-REC-VIOLATIONSZ    PIC Z,ZZZ,ZZ9.
       01 ALL-STALKING             PIC 9(7)     VALUE 0.
       01 ALL-STALKINGZ            PIC Z,ZZZ,ZZ9.
       01 NO-ARRESTS-PER           PIC 9V99.
       01 NO-ARRESTS-PERZ          PIC Z.99.

      *****HEADING*****************************************************
       01 HDG-LINE1.
           05 FILLER         PIC X(32)
                 VALUE 'CHICAGO 2009 STALKING REPORT'.

       01 HDG-LINE2.
           05 FILLER PIC X(16) VALUE 'DATE-TIME       '.
           05 FILLER PIC X(20) VALUE 'ADDRESS             '.
           05 FILLER PIC X(22) VALUE 'PRIMARY CRIME         '.
           05 FILLER PIC X(21) VALUE 'CRIME-DESC           '.
           05 FILLER PIC X     VALUE 'A'.

       01 HDG-LINE3.
           05 FILLER PIC X(16) VALUE '---------       '.
           05 FILLER PIC X(20) VALUE '-------             '.
           05 FILLER PIC X(22) VALUE '-------------         '.
           05 FILLER PIC X(21) VALUE '----------           '.
           05 FILLER PIC X     VALUE '-'.


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
           DISPLAY '* GET239 Enterprise Technologies LAB6    *'.
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
           MOVE HDG-LINE3 TO OUT-REC.
           WRITE OUT-REC.


       400-READ-CRIME-FILE.
           READ CRIME-FILE-IN
               AT END MOVE 'Y' TO EOF-SWITCH.

           IF NOT EOF
             IF CC-DATE-TIME(5:4) = '2009' OR
                    CC-DATE-TIME(6:4) = '2009' OR
                    CC-DATE-TIME(7:4) = '2009'
                    ADD 1 TO CRIME-REC-COUNT-2009
             END-IF

             IF CC-DATE-TIME(5:4) = '2010' OR
                    CC-DATE-TIME(6:4) = '2010' OR
                    CC-DATE-TIME(7:4) = '2010'
                    ADD 1 TO CRIME-REC-COUNT-2010
             END-IF

             ADD 1 TO CRIME-REC-READ

             EVALUATE CC-IUCR
               WHEN  '580 '
                   ADD 1 TO CRIME-REC-SIMPLE
                   IF  CC-ARREST = 'F'
                       PERFORM 410-PROCESS-CRIME-RECORDS
                   END-IF
               WHEN  '581 '
                   ADD 1 TO CRIME-REC-AGGRAVATED
                   IF  CC-ARREST = 'F'
                       PERFORM 410-PROCESS-CRIME-RECORDS
                   END-IF
               WHEN  '583 '
                   ADD 1 TO CRIME-REC-CYBER
                   IF  CC-ARREST = 'F'
                       PERFORM 410-PROCESS-CRIME-RECORDS
                   END-IF
               WHEN  '584 '
                   ADD 1 TO CRIME-REC-VIOLATIONS
                   IF  CC-ARREST = 'F'
                       PERFORM 410-PROCESS-CRIME-RECORDS
                   END-IF
             END-EVALUATE
           END-IF.

      ******************************************************
       410-PROCESS-CRIME-RECORDS.
           ADD 1 TO CRIME-REC-NO-ARREST
           MOVE CC-DATE-TIME TO RP-DATE-TIME.
           MOVE CC-ADDRESS TO RP-ADDRESS.
           MOVE CC-PRIMARY-CRIME TO  RP-PRIMARY-CRIME.
           MOVE CC-CRIME-DESC TO  RP-CRIME-DESC.
           MOVE CC-ARREST TO RP-ARREST.
           WRITE REPORT-REC.

      *****************************************************************

       500-DISPLAY-SUMMARY-TOTALS.
           MOVE CRIME-REC-COUNT-2009 TO CRIME-REC-COUNT-2009Z.
           DISPLAY '2009 Recs Read      : ' CRIME-REC-COUNT-2009Z.

           MOVE CRIME-REC-COUNT-2010 TO CRIME-REC-COUNT-2010Z.
           DISPLAY '2010 Recs Read      : ' CRIME-REC-COUNT-2010Z.

           MOVE CRIME-REC-READ       TO CRIME-REC-READZ.
           DISPLAY 'Total Recs In       : ' CRIME-REC-READZ
           DISPLAY '                        -------'.

           MOVE CRIME-REC-SIMPLE     TO CRIME-REC-SIMPLEZ.
           DISPLAY 'Stalking-simple     : ' CRIME-REC-SIMPLEZ.

           MOVE CRIME-REC-AGGRAVATED TO CRIME-REC-AGGRAVATEDZ.
           DISPLAY 'Stalking-Aggravated : ' CRIME-REC-AGGRAVATEDZ.

           MOVE CRIME-REC-CYBER      TO CRIME-REC-CYBERZ.
           DISPLAY 'Stalking-Cyber      : ' CRIME-REC-CYBERZ.

           MOVE CRIME-REC-VIOLATIONS TO CRIME-REC-VIOLATIONSZ.
           DISPLAY 'Stalking-Violations : 'CRIME-REC-VIOLATIONSZ.

           COMPUTE ALL-STALKING = (CRIME-REC-VIOLATIONS +
                    CRIME-REC-CYBER +   CRIME-REC-AGGRAVATED +
                    CRIME-REC-SIMPLE).
       .   MOVE ALL-STALKING            TO ALL-STALKINGZ.
           DISPLAY 'All Stalking        : ' ALL-STALKINGZ.
           DISPLAY '                        -------'.

           MOVE CRIME-REC-NO-ARREST     TO CRIME-REC-NO-ARRESTZ.
           DISPLAY 'No Stalking Arrests : ' CRIME-REC-NO-ARRESTZ.

           COMPUTE NO-ARRESTS-PER ROUNDED =
                        (CRIME-REC-NO-ARREST / ALL-STALKING).
           MOVE NO-ARRESTS-PER          TO NO-ARRESTS-PERZ.
           DISPLAY 'No Arrest Percent   :      ' NO-ARRESTS-PERZ.


           DISPLAY '******************************************'.
           DISPLAY '* End of Chicago Stalking Report         *'.
           DISPLAY '******************************************'.
      *****************************************************************
       600-CLOSE-FILES.
           CLOSE CRIME-FILE-IN
                 REPORT-OUT.
      *****************************************************************
      * END OF THE PROGRAM.
      *****************************************************************
