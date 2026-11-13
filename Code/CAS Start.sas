
cas; /*start a session*/

LIBNAME CASUSER CAS CASLIB='CASUSER'; /*assign one library*/

CASLIB _ALL_ ASSIGN; /* Assign all */

CASLIB MYLIB PATH="/home/student/Data/Big Data"  LIBREF= MYLIB; /*create your own*/

Cas casauto terminate; /* end the session*/