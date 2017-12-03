%macro Merge1;
%do j=11 %to 17;
	%do i=1 %to 9;
		data sentpro.data20&j.&i.;
			set sentpro.data20&j.&i.;
			time_5min_after = Time + 300;
			time_1min_after = Time + 60;
			time_5min_earlier = Time - 300;
			time_1min_earlier = Time -60;
			sasdate = input(put(Date,8.),yymmdd8.);
		  	format Date;
		   	format sasdate yymmddn8.;
			format time TIME8. time_5min_after TIME8. time_1min_after TIME8. time_5min_earlier TIME8. time_1min_earlier TIME8.;
			drop Date;
		
		data sentpro.indexdata20&j.&i.;
			set sentpro.indexdata20&j.&i.(rename=(DATE=INDEXDATE TIME=INDEXTIME CRSPTM1=INDEXVAL));
			
		
		*Merge with time;
		proc sql;
		create table work.step1merged_data20&j.&i. as 
		select * from sentpro.data20&j.&i. as a left join sentpro.indexdata20&j.&i. as b 
		on a.sasdate = b.INDEXDATE and a.Time = b.INDEXTIME;
		
		data work.step1merged_data20&j.&i.;
			set work.step1merged_data20&j.&i.(rename=(INDEXDATE=INDEXDATE_ORI INDEXTIME=INDEXTIME_ORI INDEXVAL=INDEX_ORI));
		
		*Merge with 1 min later;
		proc sql;
		create table work.step2merged_data20&j.&i. as 
		select * from work.step1merged_data20&j.&i. as a left join sentpro.indexdata20&j.&i. as b 
		on a.sasdate = b.INDEXDATE and a.time_1min_after = b.INDEXTIME;
		
		data work.step2merged_data20&j.&i.;
			set work.step2merged_data20&j.&i.(rename=(INDEXDATE=INDEXDATE_1minLater INDEXTIME=INDEXTIME_1minLater INDEXVAL=INDEX_1minLater));
		
		*Merge with 5 min later;
		proc sql;
		create table work.step3merged_data20&j.&i. as 
		select * from work.step2merged_data20&j.&i. as a left join sentpro.indexdata20&j.&i. as b 
		on a.sasdate = b.INDEXDATE and a.time_5min_after = b.INDEXTIME;
		
		data work.step3merged_data20&j.&i.;
			set work.step3merged_data20&j.&i.(rename=(INDEXDATE=INDEXDATE_5minLater INDEXTIME=INDEXTIME_5minLater INDEXVAL=INDEX_5minLater));
		
		*Merge with 5 min earlier;
		proc sql;
		create table work.step4merged_data20&j.&i. as 
		select * from work.step3merged_data20&j.&i. as a left join sentpro.indexdata20&j.&i. as b 
		on a.sasdate = b.INDEXDATE and a.time_5min_earlier = b.INDEXTIME;
		
		data work.step4merged_data20&j.&i.;
			set work.step4merged_data20&j.&i.(rename=(INDEXDATE=INDEXDATE_5minEarlier INDEXTIME=INDEXTIME_5minEarlier INDEXVAL=INDEX_5minEarlier));
		
		*Merge with 1 min earlier;
		proc sql;
		create table work.step5merged_data20&j.&i. as 
		select * from work.step4merged_data20&j.&i. as a left join sentpro.indexdata20&j.&i. as b 
		on a.sasdate = b.INDEXDATE and a.time_1min_earlier = b.INDEXTIME;
		
		data sentpro.merged_data20&j.&i.;
			set work.step5merged_data20&j.&i.(rename=(INDEXDATE=INDEXDATE_1minEarlier INDEXTIME=INDEXTIME_1minEarlier INDEXVAL=INDEX_1minEarlier));
			
	%end;
%end;
run;
%mend;

%Merge1;

%macro Merge2;
%do j=11 %to 17;
	%do i=10 %to 12;
		data sentpro.data20&j.&i.;
			set sentpro.data20&j.&i.;
			time_5min_after = Time + 300;
			time_1min_after = Time + 60;
			time_5min_earlier = Time - 300;
			time_1min_earlier = Time -60;
			sasdate = input(put(Date,8.),yymmdd8.);
		  	format Date;
		   	format sasdate yymmddn8.;
			format time TIME8. time_5min_after TIME8. time_1min_after TIME8. time_5min_earlier TIME8. time_1min_earlier TIME8.;
			drop Date;
		
		data sentpro.indexdata20&j.&i.;
			set sentpro.indexdata20&j.&i.(rename=(DATE=INDEXDATE TIME=INDEXTIME CRSPTM1=INDEXVAL));
			
		
		*Merge with time;
		proc sql;
		create table work.step1merged_data20&j.&i. as 
		select * from sentpro.data20&j.&i. as a left join sentpro.indexdata20&j.&i. as b 
		on a.sasdate = b.INDEXDATE and a.Time = b.INDEXTIME;
		
		data work.step1merged_data20&j.&i.;
			set work.step1merged_data20&j.&i.(rename=(INDEXDATE=INDEXDATE_ORI INDEXTIME=INDEXTIME_ORI INDEXVAL=INDEX_ORI));
		
		*Merge with 1 min later;
		proc sql;
		create table work.step2merged_data20&j.&i. as 
		select * from work.step1merged_data20&j.&i. as a left join sentpro.indexdata20&j.&i. as b 
		on a.sasdate = b.INDEXDATE and a.time_1min_after = b.INDEXTIME;
		
		data work.step2merged_data20&j.&i.;
			set work.step2merged_data20&j.&i.(rename=(INDEXDATE=INDEXDATE_1minLater INDEXTIME=INDEXTIME_1minLater INDEXVAL=INDEX_1minLater));
		
		*Merge with 5 min later;
		proc sql;
		create table work.step3merged_data20&j.&i. as 
		select * from work.step2merged_data20&j.&i. as a left join sentpro.indexdata20&j.&i. as b 
		on a.sasdate = b.INDEXDATE and a.time_5min_after = b.INDEXTIME;
		
		data work.step3merged_data20&j.&i.;
			set work.step3merged_data20&j.&i.(rename=(INDEXDATE=INDEXDATE_5minLater INDEXTIME=INDEXTIME_5minLater INDEXVAL=INDEX_5minLater));
		
		*Merge with 5 min earlier;
		proc sql;
		create table work.step4merged_data20&j.&i. as 
		select * from work.step3merged_data20&j.&i. as a left join sentpro.indexdata20&j.&i. as b 
		on a.sasdate = b.INDEXDATE and a.time_5min_earlier = b.INDEXTIME;
		
		data work.step4merged_data20&j.&i.;
			set work.step4merged_data20&j.&i.(rename=(INDEXDATE=INDEXDATE_5minEarlier INDEXTIME=INDEXTIME_5minEarlier INDEXVAL=INDEX_5minEarlier));
		
		*Merge with 1 min earlier;
		proc sql;
		create table work.step5merged_data20&j.&i. as 
		select * from work.step4merged_data20&j.&i. as a left join sentpro.indexdata20&j.&i. as b 
		on a.sasdate = b.INDEXDATE and a.time_1min_earlier = b.INDEXTIME;
		
		data sentpro.merged_data20&j.&i.;
			set work.step5merged_data20&j.&i.(rename=(INDEXDATE=INDEXDATE_1minEarlier INDEXTIME=INDEXTIME_1minEarlier INDEXVAL=INDEX_1minEarlier));
			
	%end;
%end;
run;
%mend;

%Merge2;

