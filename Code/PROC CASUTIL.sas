proc casutil;
    droptable casdata="cars" incaslib="casuser" quiet;
	load data=sashelp.cars outcaslib="casuser"
	casout="cars" promote;
    save casdata="cars" incaslib="casuser" outcaslib="casuser"
	casout="cars_cas" replace;
list files incaslib="casuser";
quit;




%macro up_cas(data,caslib=casuser) ;
%let dsn=%scan(&data,-1, .);

proc casutil;
    droptable casdata="&dsn" incaslib="&caslib" quiet;
	load data=&data outcaslib="&caslib"
	casout="&dsn" promote;
    save casdata="&dsn" incaslib="&caslib" outcaslib="&caslib"
	casout="&dsn" replace;
list files incaslib="&caslib";
quit;
%mend;

%up_cas(sashelp.baseball)




%macro up_cas_server(file,caslib=casuser) ;
%let dsn=%scan(&file,1, .);

proc casutil;
    droptable casdata="&dsn" incaslib="&caslib" quiet;
	load casdata="&file" incaslib="&caslib" 
            outcaslib="&caslib" casout="&dsn" promote;
    
quit;
%mend;

%up_cas_server(myfilms.sashdat)