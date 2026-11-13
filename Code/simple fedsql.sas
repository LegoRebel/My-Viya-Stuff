proc fedsql libs=(imdb);
    create table blah as
    select * from IMDB.BEST_FILM 
   ;
quit;