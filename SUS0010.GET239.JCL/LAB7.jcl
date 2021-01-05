//********************************************************************
//* CREATE A CRIME REPORT USING 2009 CHICAGO DATA
//********************************************************************
//SUS0010T JOB (000000),'Kelly',
//           NOTIFY=&SYSUID,
//           TIME=(,5),
//           LINES=1500,
//           CLASS=A
//*********************************************************************
//STEP01  EXEC PGM=SORT
//*********************************************************************
//SYSIN    DD   *
    SORT FIELDS=(64,4,CH,A,32,32,CH,A)
/*
//SYSOUT   DD   SYSOUT=*
//SORTIN   DD   DSN=SHARE.CHICAGO.CRIME10,DISP=SHR
//         DD   DSN=SHARE.CHICAGO.CRIME11,DISP=SHR
//SORTOUT  DD   DSN=&&CRIME,
//             DISP=(NEW,PASS),
//             SPACE=(TRK,(3400,10))
//*********************************************************************
//STEP02   EXEC PGM=LAB7
//STEPLIB  DD   DSN=&SYSUID..GET239.LOADLIB,
//             DISP=SHR
//CRIMEIN  DD   DSN=&&CRIME,DISP=(OLD,DELETE,DELETE)
//REPORTOT DD   SYSOUT=*
//SYSPRINT DD   SYSOUT=*
//SYSOUT   DD   SYSOUT=*
//********************************************************************