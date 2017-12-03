
%macro sort1;
%do j=7 %to 9;
	%do i=1 %to 9;
		proc sort data = sentpro.data200&j.0&i.;
		by Date Time;
		
		data sentpro.data200&j.0&i.;
			set sentpro.data200&j.0&i.(where=(Date^=. and Time ^=. and Time >'9:30:00'T and Time < '16:00:00'T));
			
	%end;
%end;
run;
%mend;
%sort1;

%macro sort2;
%do j=7 %to 9;
	%do i=10 %to 12;
		proc sort data = sentpro.data200&j.&i.;
		by Date Time;
		
		data sentpro.data200&j.&i.;
			set sentpro.data200&j.&i.(where=(Date^=. and Time ^=. and Time >'9:30:00't and Time < '16:00:00't));
	%end;
%end;
run;
%mend;
%sort2;

%macro sort3;
%do j=10 %to 17;
	%do i= 1 %to 9;
		proc sort data = sentpro.data20&j.0&i.;
		by Date Time;
		
		data sentpro.data20&j.0&i.;
			set sentpro.data20&j.0&i.(where=(Date^=. and Time ^=. and Time >'9:30:00't and Time < '16:00:00't));
	%end;
%end;
run;
%mend;
%sort3;

%macro sort4;
%do j=10 %to 17;
	%do i= 10 %to 12;
		proc sort data = sentpro.data20&j.&i.;
		by Date Time;
		
		data sentpro.data20&j.&i.;
			set sentpro.data20&j.&i.(where=(Date^=. and Time ^=. and Time >'9:30:00't and Time < '16:00:00't));
	%end;
%end;
run;
%mend;
%sort4;