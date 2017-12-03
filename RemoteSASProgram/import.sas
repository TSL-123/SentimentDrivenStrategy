/*
%macro import;
%do j=4 %to 9;
	%do i=1 %to 4;
		data number5.q&i.Y200&j.;
		infile "F:\data\REQ2613_200&j.Q&i..txt" delimiter=',' firstobs=1 dsd missover lrecl=32000 pad;
		length var1 $150. var2 $150.;
	run;
%mend;
*/

%macro import1;
%do j=7 %to 9;
	%do i=1 %to 9;
		proc import datafile = "/Users/ziming/Downloads/month_data/data200&j.0&i..csv"
		dbms=csv
		replace
		out = WORK.data200&j.0&i.;
		GETNAMES=NO;
		DATAROW=1;
	%end;
%end;
run;
%mend;


%macro import2;
%do j=7 %to 9;
	%do i=10 %to 12;
		proc import datafile = "/Users/ziming/Downloads/month_data/data200&j.&i..csv"
		dbms=csv
		replace
		out = WORK.data200&j.&i.;
		GETNAMES=NO;
		DATAROW=1;
	%end;
%end;
run;
%mend;

%macro import3;
%do j=10 %to 17;
	%do i= 1 %to 9;
		proc import datafile = "/Users/ziming/Downloads/month_data/data20&j.0&i..csv"
		dbms=csv
		replace
		out = WORK.data20&j.0&i.;
		GETNAMES=NO;
		DATAROW=1;
		%end;
%end;
run;
%mend;

%macro import4;
%do j=10 %to 17;
	%do i= 10 %to 12;
		proc import datafile = "/Users/ziming/Downloads/month_data/data20&j.&i..csv"
		dbms=csv
		replace
		out = WORK.data20&j.&i.;
		GETNAMES=NO;
		DATAROW=1;
	%end;
%end;
run;
%mend;


/*What to tag news data with returns*/
*Use CRSP US Total Market Index;
data work.Index;
	set crspq.indexhist_sbs;
run;






/*
proc import datafile = "/home/harvard/kevinwzx/Project/FinalData.csv"
		dbms=csv
		replace
		out = WORK.Company_names;
		GETNAMES=YES;
		DATAROW=2;
run;
quit;

proc univariate data=Company_names freq;
var MktCap;
run;
quit;


data Company_names_cleaned;
	set Company_names(where= (MktCap>=2000000000));
run;
quit;

proc sort data=work.company_names_cleaned nodupkey;
by name;
run;
quit;

proc sort data=work.company_names_cleaned nodupkey;
by Symbol;
run;
quit;
*/




/*
data work.taq_ct200428;
	set taq.ct_20040428(where=(SYMBOL='A' AND time >= '9:30:00'T  AND  time <= '16:00:00'T));
run;
*/





*%import2;
*%import3;
*%import4;


/*
data work.merged_data200701;
	set work.data200701(where = (time>='9:30:00'T  AND  time <= '16:00:00'T));
	do until(exact_match = 1 OR lagged_match = 1 OR end_of_quotes_file = 1);
		if 
*/

