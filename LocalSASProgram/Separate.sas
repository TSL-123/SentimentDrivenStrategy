
%macro separate1;
%do j=11 %to 17;
	%do i=1 %to 9;
		data sentpro.indexdata20&j.0&i.;
			set sentpro.indexdata;
			if year(DATE) = 20&j. and month(DATE) = 0&i.;
	%end;
%end;
run;
%mend;
*%separate1;


%macro separate2;
%do j=11 %to 17;
	%do i=10 %to 12;
		data sentpro.indexdata20&j.&i.;
			set sentpro.indexdata;
			if year(DATE) = 20&j. and month(DATE) = &i.;
	%end;
%end;
run;
%mend;
*%separate2;

