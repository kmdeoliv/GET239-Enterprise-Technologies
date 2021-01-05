//SUS0010T JOB (000000),'kelly',
//           NOTIFY=&SYSUID,
//           TIME=(,5),
//           LINES=500,
//           CLASS=A
//********************************************************************
//*STEP TO EXECUTE COBOL PROGRAM
//********************************************************************
//STEP01   EXEC PGM=FINAL
//STEPLIB  DD   DSN=&SYSUID..GET239.LOADLIB,
//             DISP=SHR
//CRIMEIN  DD   DSN=SHARE.CHICAGO.CRIME09,DISP=SHR
//         DD   DSN=SHARE.CHICAGO.CRIME10,DISP=SHR
//         DD   DSN=SHARE.CHICAGO.CRIME11,DISP=SHR
//         DD   DSN=SHARE.CHICAGO.CRIME12,DISP=SHR
//         DD   DSN=SHARE.CHICAGO.CRIME13,DISP=SHR
//CRIMECSV DD   DSN=&SYSUID..GET233.CSV,
//            DISP=(NEW,CATLG,DELETE),
//            DCB=(DSORG=PS,RECFM=FB,LRECL=135),
//            UNIT=SYSDA,
//            SPACE=(TRK,200)
//SYSOUT   DD   SYSOUT=*
//SYSPRINT DD   SYSOUT=*
//********************************************************************
//