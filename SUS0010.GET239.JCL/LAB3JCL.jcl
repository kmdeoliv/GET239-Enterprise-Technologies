//SUS0010T JOB (000000),'kelly',
//           NOTIFY=&SYSUID,
//           TIME=(,5),
//           LINES=500,
//           CLASS=A
//********************************************************************
//*STEP TO EXECUTE COBOL PROGRAM
//********************************************************************
//STEP01   EXEC PGM=LAB7
//STEPLIB  DD   DSN=&SYSUID..GET239.LOADLIB,
//             DISP=SHR
//CRIMEIN  DD   DSN=SHARE.CHICAGO.CRIME10,DISP=SHR
//         DD   DSN=SHARE.CHICAGO.CRIME11,DISP=SHR
//REPORTOT DD   SYSOUT=*
//SYSOUT   DD   SYSOUT=*
//SYSPRINT DD   SYSOUT=*
//********************************************************************
//