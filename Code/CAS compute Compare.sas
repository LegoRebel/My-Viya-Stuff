/*Using CAS*/
/*No need for a sort step*/
/*Next step only needs to be run if the data is not already loaded into memory*/
proc casutil;
    droptable incaslib ="CASUSER" casdata="big_orders" quiet;
    	load casdata="Big_orders.sashdat" incaslib="casuser"
	outcaslib="casuser" casout="big_orders" promote;
run;

options msglevel=i;
data casuser.cust_sum;
    set casuser.big_orders (keep=customer_id RetailPrice);
    by customer_ID;
    if first.customer_id then tot=0;
    tot+RetailPrice;
    if last.customer_ID;
run;


/*Using Compute server*/
libname orion "/home/student/Data/Big Data";

proc sort data=ORION.BIG_ORDERS out=big_orders_sorted;
    by customer_id;
run;

data work.cust_sum;
    set big_orders_sorted (keep=customer_id RetailPrice);
    by customer_ID;
    if first.customer_id then tot=0;
    tot+RetailPrice;
    if last.customer_ID;
run;