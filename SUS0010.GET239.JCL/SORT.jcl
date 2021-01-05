//SUS0010S JOB (000000),'kelly',
//           NOTIFY=&SYSUID,
//           TIME=(,5),
//           LINES=500,
//           CLASS=A
//*********************************************************************
//STEP01  EXEC PGM=SORT
//*********************************************************************
//SYSIN   DD   *
    SORT FIELDS=(1,8,CH,A)  Sorts Planets in ascending sequence
/*
//SYSOUT  DD   SYSOUT=*
//SORTOUT DD   SYSOUT=*
//SORTIN  DD   *
Neptune
Mars
Earth
Venus
Pluto
Uranus
Mercury
Saturn
Jupiter
//*********************************************************************
//STEP02  EXEC PGM=SORT
//*********************************************************************
//SYSIN   DD   *
    SORT FIELDS=(1,29,CH,D)
/*
//SYSOUT  DD  SYSOUT=*
//SORTOUT DD  SYSOUT=*
//SORTIN  DD  DSN=SHARE.GET239.CNTL(LAB2DATA),DISP=SHR
//