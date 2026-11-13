

data casuser.cars_part (partition=(origin) orderby=( invoice)); 
   set casuser.cars; 
   keep origin make model invoice;
run; 
proc print data= casuser.cars_part; 
run;


data casuser.big_orders_sort (partition=(country) orderby=( retailprice)); 
   set casuser.big_orders; 
  
run; 
