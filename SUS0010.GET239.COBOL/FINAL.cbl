      *****************************************************************
      *PURPOSE: Record the occurrences of vehicle theft in a csv file
      *in order to obtain an further analysis and help the Chicago
      *Police Department
      *****************************************************************

       ID DIVISION.
          PROGRAM-ID.      FINAL-PROJECT.
          AUTHOR.          Kelly.
          DATE-WRITTEN.    April 2016.
          DATE-COMPILED.   CURRENT-DATE.

      *****************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CRIME-FILE-IN ASSIGN TO CRIMEIN
           ORGANIZATION IS SEQUENTIAL.
           SELECT REPORT-OUT ASSIGN TO CRIMECSV
           ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD CRIME-FILE-IN.
      *****************************************************************
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
      ******* End of Chicago City Crime Record *************************

      ***OUTPUT SUMMARY************************************************
       FD  REPORT-OUT
       01  OUT-REC                           PIC X(135).
      *****************************************************************

       WORKING-STORAGE SECTION.
       01 WS-NAMED-MEMORY-LOCATIONS.
      **** SWITCHES ***************************************************
           05 EOF-SWITCH               PIC X        VALUE 'N'.
              88 EOF                                VALUE 'Y'.
      *****************************************************************

      *****CONVERTED DATE *********************************************
           05  WS-DATE-CONV.
               10  WS-MONTH              PIC XX.
               10  WS-DAY                PIC XX.
               10  WS-YEAR               PIC X(4).
           05  WS-DATE-CONVR REDEFINES WS-DATE-CONV.
               10  WS-MONTH9             PIC 99.
               10  WS-DAY9               PIC 99.
               10  WS-YEAR9              PIC 9(4).

      **** CONVERTED TIME *********************************************
           05  WS-TIME-CONV.
               10  WS-HOUR               PIC XX.
               10  WS-MIN                PIC XX.
           05  WS-TIME-CONVR REDEFINES WS-TIME-CONV.
               10  WS-HOUR9              PIC 99.
               10  WS-MIN9               PIC 99.

      **** CALLED PROGRAM *********************************************
       01  CONVERT-DATE                  PIC X(8) VALUE 'CONVDATE'.

      **** THIS IS THE CSV RECORD FORMAT - A HEADING AND A DETAIL LINE
       01  CRIME-HEADING.
           05                 PIC X(4)  VALUE 'Year'.
           05                 PIC X     VALUE ','.
           05                 PIC X(5)  VALUE 'Month'.
           05                 PIC X     VALUE ','.
           05                 PIC X(3)  VALUE 'Day'.
           05                 PIC X     VALUE ','.
           05                 PIC X(4)  VALUE 'Hour'.
           05                 PIC X     VALUE ','.
           05                 PIC X(4)  VALUE 'IUCR'.
           05                 PIC X     VALUE ','.
           05                 PIC X(13) VALUE 'Primary Crime'.
           05                 PIC X     VALUE ','.
           05                 PIC X(10) VALUE 'Crime-Desc'.
           05                 PIC X     VALUE ','.
           05                 PIC X(4)  VALUE 'Ward'.
           05                 PIC X     VALUE ','.
           05                 PIC X(8)  VALUE 'Latitude'.
           05                 PIC X     VALUE ','.
           05                 PIC X(9)  VALUE 'Longitude'.
           05                 PIC X     VALUE ','.
           05                 PIC X(7)  VALUE 'Address'.
           05                 PIC X     VALUE ','.
           05                 PIC X(6)  VALUE 'Arrest'.
           05                 PIC X     VALUE ','.
           05                 PIC X(46).
      *--- THIS IS THE DETAIL LINE AND WILL BE WRITTEN OUT MANY TIMES -
       01  CRIME-DETAIL.
           05 CD-YYYY         PIC X(4).
           05                 PIC X     VALUE ','.
           05 CD-MM           PIC X(2).
           05                 PIC X     VALUE ','.
           05 CD-DD           PIC X(2).
           05                 PIC X     VALUE ','.
           05 CD-HH           PIC X(2).
           05                 PIC X     VALUE ','.
           05 CD-IUCR         PIC X(4).
           05                 PIC X     VALUE ','.
           05 CD-PRIM-CRIME   PIC X(20).
           05                 PIC X     VALUE ','.
           05 CD-CRIME-DESC   PIC X(40).
           05                 PIC X     VALUE ','.
           05 CD-WARD         PIC X(4).
           05                 PIC X     VALUE ','.
           05 CD-LAT          PIC X(11).
           05                 PIC X     VALUE ','.
           05 CD-LONG         PIC X(12).
           05                 PIC X     VALUE ','.
           05 CD-ADDRESS      PIC X(20).
           05                 PIC X     VALUE ','.
           05 CD-ARREST       PIC X.
           05                 PIC X     VALUE ','.
           05                 PIC X     VALUE ' '.

      *VAIABLES TO STORE THE NUMBER OF CRIMES READED AND
      *MOTOR VEHICLE THEFT
       01 CRIME-REC-READ                 PIC 9(7)     VALUE 0.
       01 CRIME-REC-READZ                PIC Z,ZZZ,ZZ9.
       01 MOTOR-VEHICLE-THEFT            PIC 9(7)     VALUE 0.
       01 MOTOR-VEHICLE-THEFTZ           PIC Z,ZZZ,ZZ9.

      *****************************************************************
       PROCEDURE DIVISION.
      *****************************************************************
       MAIN-PROGRAM.
           PERFORM 200-OPEN-FILES.
           PERFORM 300-WRITE-HEADER
           PERFORM 400-READ-CRIME-FILE UNTIL EOF.
           PERFORM 500-DISPLAY-SUMMARY-TOTALS.
           PERFORM 600-CLOSE-FILES.
           STOP RUN.
       END-MAIN-PROGRAM.

      *****************************************************************


      *OPEN FILES ROUTINE**********************************************
       200-OPEN-FILES.
           OPEN  INPUT CRIME-FILE-IN
                 OUTPUT REPORT-OUT.

      *WRITE HEADER ROUTINE********************************************
       300-WRITE-HEADER.
           MOVE CRIME-HEADING TO OUT-REC.
           WRITE OUT-REC.


      *READ CRIME ROUTINE**********************************************
       400-READ-CRIME-FILE.
           READ CRIME-FILE-IN
               AT END MOVE 'Y' TO EOF-SWITCH.

           IF NOT EOF
                ADD 1 TO CRIME-REC-READ
      *SELECT ALL THE MOTOR VEHICLE THEFTS*****************************
                IF CC-PRIMARY-CRIME = 'MOTOR VEHICLE THEFT'
                    EVALUATE CC-ARREST
                        WHEN 'T'
                            MOVE 'Y' TO CC-ARREST
                        WHEN 'F'
                            MOVE 'N' TO CC-ARREST
                    END-EVALUATE

      **** CALL THE CONVERT DATE-TIME PROGRAM *************
                    CALL CONVERT-DATE USING CC-DATE-TIME
                                    WS-DATE-CONVR
                                    WS-TIME-CONVR

      **WRITE THE MOTOR THEFT IN THE OUTPUT FILE***********************
                    PERFORM 410-PROCESS-CRIME-RECORDS
                END-IF
           END-IF.


      **WRITE OUTPUT ROUTINE*******************************************
       410-PROCESS-CRIME-RECORDS.
           ADD 1 TO MOTOR-VEHICLE-THEFT.
           MOVE WS-YEAR TO CD-YYYY.
           MOVE WS-MONTH TO CD-MM.
           MOVE WS-DAY TO CD-DD.
           MOVE WS-HOUR TO CD-HH.
           MOVE CC-IUCR TO CD-IUCR.
           MOVE CC-PRIMARY-CRIME TO  CD-PRIM-CRIME.
           MOVE CC-CRIME-DESC TO  CD-CRIME-DESC.
           MOVE CC-WARD TO CD-WARD.
           MOVE CC-LAT TO CD-LAT.
           MOVE CC-LONG TO CD-LONG.
           MOVE CC-ADDRESS TO CD-ADDRESS.
           MOVE CC-ARREST TO CD-ARREST.
           MOVE CRIME-DETAIL TO OUT-REC.
           WRITE OUT-REC.

      *DISPLAY THE TOTALS OF CRIMES AND MOTOR VEHICLE THEFT READED*****
       500-DISPLAY-SUMMARY-TOTALS.
           DISPLAY 'SUMMARY TOTALS************************************'.
           MOVE CRIME-REC-READ   TO CRIME-REC-READZ.
           DISPLAY 'Crime Records In          : ' CRIME-REC-READZ.
           MOVE MOTOR-VEHICLE-THEFT   TO MOTOR-VEHICLE-THEFTZ.
           DISPLAY 'Crime CSV Records Out     : ' MOTOR-VEHICLE-THEFTZ.

           DISPLAY '**************************************************'.
      **CLOSE FILES ROUTINE********************************************
       600-CLOSE-FILES.
           CLOSE CRIME-FILE-IN
                 REPORT-OUT.
      *****************************************************************
      * END OF THE PROGRAM.
      *****************************************************************