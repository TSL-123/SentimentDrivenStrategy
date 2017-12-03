data work.IndexData;
	set sentpro.indexdata;
run;

%macro import1;
%do j=7 %to 9;
	%do i=1 %to 9;
		PROC IMPORT DATAFILE="/folders/myfolders/ProjectSASProgram/Data/month_data/data200&j.0&i..csv"
		DBMS=CSV
		replace
		out = sentpro.data200&j.0&i.;
		GETNAMES=YES;
		DATAROW=2;
	%end;
%end;
run;
%mend;

%import1;

%macro import2;
%do j=7 %to 9;
	%do i=10 %to 12;
		proc import datafile = "/folders/myfolders/ProjectSASProgram/Data/month_data/data200&j.&i..csv"
		dbms=csv
		replace
		out = sentpro.data200&j.&i.;
		GETNAMES=YES;
		DATAROW=2;
	%end;
%end;
run;
%mend;
%import2;

%macro import3;
%do j=10 %to 17;
	%do i= 1 %to 9;
		proc import datafile = "/folders/myfolders/ProjectSASProgram/Data/month_data/data20&j.0&i..csv"
		dbms=csv
		replace
		out = sentpro.data20&j.0&i.;
		GETNAMES=YES;
		DATAROW=2;
		%end;
%end;
run;
%mend;
%import3

%macro import4;
%do j=10 %to 17;
	%do i= 10 %to 12;
		proc import datafile = "/folders/myfolders/ProjectSASProgram/Data/month_data/data20&j.&i..csv"
		dbms=csv
		replace
		out = sentpro.data20&j.&i.;
		GETNAMES=YES;
		DATAROW=2;
	%end;
%end;
run;
%mend;
%import4;
