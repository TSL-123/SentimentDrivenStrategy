data work.test1;
	set sentpro.data200701;
run;

proc sql;
	create table work.test1 as select * from work.test1 as a left join sentpro.data200702 as b on a.Time=b.Time;
run;
