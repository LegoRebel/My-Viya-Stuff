

data casuser.cars_varChar ;    
   set casuser.cars;  
   length test_model varchar(*);                      
  test_model=catx(" ", make, model, origin, type);
run;

data casuser.cars_normal_Char ;    
   set casuser.cars;  
   length test_model $ 57;                      
  test_model=catx(" ", make, model, origin, type);
run;

proc cas;
   table.tableDetails /
      caslib="CASUSER"
      name="cars_varChar"
      showMem=true;
      table.tableDetails /
      caslib="CASUSER"
      name="cars_normal_Char"
      showMem=true;
quit;