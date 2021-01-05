//SUS0010C JOB (000000),'KELLY',
//           NOTIFY=&SYSUID,
//           CLASS=A
//********************************************************************/
//* COMPILE PROGRAM
//********************************************************************/
//COBRUN  EXEC IGYWCL,PARM.COBOL='RENT,LIST'
//COBOL.SYSIN  DD DISP=SHR,DSN=&SYSUID..GET239.COBOL(FINAL)
//LKED.SYSLMOD DD DISP=SHR,DSN=&SYSUID..GET239.LOADLIB(FINAL)
//********************************************************************/
//* END COMPILE PROGRAM
//********************************************************************/