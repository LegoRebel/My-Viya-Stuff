/* data casuser.inv_total; */
/*     set casuser.cars end=eof; */
/*     if Make="BMW" then Eur_cars_thread+1; */
/*     if eof then output; */
/*     keep Eur_cars_thread; */
/* run; */



data work.city_sum;
    set orion.big_orders end=eof ;
    if city="Salford" then  city_thread+1;
     if eof then output;
    keep  city_thread;
run;


data casuser.city_total;
    set CASUSER.BIG_ORDERS end=eof;
    if city="Salford" then city_thread+1;
    *put _THREADID_ _NTHREADS_ ; 
    if eof then output;
    keep city_thread;
run;