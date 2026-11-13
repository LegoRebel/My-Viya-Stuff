%let origin=Asia;

proc python;
submit;

selection=SAS.symget("origin")
org_sel = SAS.sd2df(f"sashelp.cars(where=(origin='{selection}'))")
org_sel.info()
SAS.show(org_sel.head(), title = "Cars from " + selection)
SAS.show(org_sel['Invoice'].mean(), title = "Average Invoice for " + selection)
SAS.df2sd(org_sel, "work.py_"+ selection)

endsubmit;
quit;


%let origin=USA;

proc r;
submit;
org <- symget("Origin")

library(tidyverse) #this is a library that contains most of what you need
carsdf <- sd2df('sashelp.cars')
carsAudi <- carsdf %>% filter(Origin == org)
show(mean(carsAudi$Invoice, na.rm = TRUE),title = paste("average invoice for", org))
show(head(carsAudi), title = paste("Vehicles from", org));
df2sd(carsAudi, paste0("work.R_",org));


endsubmit;
run;