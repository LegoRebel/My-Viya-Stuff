filename inzip zip "/home/student/Data/Big Data/part1.zip";
filename ds "%sysfunc(getoption(work))/part1.sas7bdat" ;
data _null_;
   /* reference the member name WITH folder path */
   infile inzip(part1.sas7bdat) 
	  lrecl=256 recfm=F length=length eof=eof unbuf;
   file   ds lrecl=256 recfm=N;
   input;
   put _infile_ $varying256. length;
   return;
 eof:
   stop;
run;
 
filename inzip zip "/home/student/Data/Big Data/part2.zip";
filename ds "%sysfunc(getoption(work))/part2.sas7bdat" ;
data _null_;
   /* reference the member name WITH folder path */
   infile inzip(part2.sas7bdat) 
	  lrecl=256 recfm=F length=length eof=eof unbuf;
   file   ds lrecl=256 recfm=N;
   input;
   put _infile_ $varying256. length;
   return;
 eof:
   stop;
run;



libname orion "/home/student/Data/Big Data";
Data orion.Big_orders;
    set part1 part2;
run;

proc casutil;
	load data=orion.Big_orders outcaslib="casuser"
	casout="Big_orders" replace;
   save casdata="Big_orders" incaslib="casuser" outcaslib="casuser"
	casout="Big_orders";
run;