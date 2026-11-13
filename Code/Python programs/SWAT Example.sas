


proc python;
submit;
import swat
# Establish a CAS connection
conn = swat.CAS('server.demo.sas.com', 30570, 'student', 'Metadata0')
# Reference an existing CAS table
cars = conn.CASTable("cars", caslib="CASUSER")
print(cars.head())
endsubmit;
quit;