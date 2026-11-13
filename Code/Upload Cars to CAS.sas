
proc casutil;
    droptable casdata="cars" incaslib="casuser" quiet;
	load data=sashelp.cars outcaslib="casuser"
	casout="cars" promote;
    save casdata="cars" incaslib="casuser" outcaslib="casuser"
	casout="cars" replace;
run;
