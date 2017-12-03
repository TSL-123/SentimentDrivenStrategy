%MACRO AddTime1;
%do j=2011 %to 2017;
	%do i=1 %to 9;
		data work.TickerData&j.0&i.;
			set sentpro.TickerData&j.0&i.;
			time_5min_after = Time + 300;
			time_1min_after = Time + 60;
			time_5min_earlier = Time - 300;
			time_1min_earlier = Time -60;
			format time_5min_after TIME8. time_1min_after TIME8. time_5min_earlier TIME8. time_1min_earlier TIME8.;
	%end;
%end;
run;
%MEND;
*%AddTime1;
%MACRO AddTime2;
%do j=2011 %to 2017;
	%do i=10 %to 12;
		data work.TickerData&j.&i.;
			set sentpro.TickerData&j.&i.;
			time_5min_after = Time + 300;
			time_1min_after = Time + 60;
			time_5min_earlier = Time - 300;
			time_1min_earlier = Time -60;
			format time_5min_after TIME8. time_1min_after TIME8. time_5min_earlier TIME8. time_1min_earlier TIME8.;
	%end;
%end;
run;
%MEND;
*%AddTime2;

%macro seperateandMerge1;
%do j=2014 %to 2014;
	%do i=1 %to 9;
		%do k= 1 %to 9;
			data work.temp&k.;
				set work.TickerData&j.0&i.;
				if day(sasdate)=&k.;
				
			data work.ct_&j.0&i.0&k.;
				set taq.ct_&j.0&i.0&k.;
				hour = hour(TIME);
				minute = minute(TIME);
				second = 0;
				new_time = HMS(hour, minute, second);
				drop DATE SIZE G127 CORR COND EX hour minute second;
				
			proc sort data = work.ct_&j.0&i.0&k. nodupkey;
			by symbol new_time;

			
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.0&i.0&k. as b on a.ticker = b.symbol and a.time=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_now new_time = time_now));

				
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.0&i.0&k. as b on a.ticker = b.symbol and a.time_5min_after=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_5_min_after new_time = time_5_min_after));	


				
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.0&i.0&k. as b on a.ticker = b.symbol and a.time_1min_after=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_1_min_after new_time = time_1_min_after));

			
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.0&i.0&k. as b on a.ticker = b.symbol and a.time_5min_earlier=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_5_min_earlier new_time = time_5_min_earlier));

			
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.0&i.0&k. as b on a.ticker = b.symbol and a.time_1min_earlier=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_1_min_earlier new_time = time_1_min_earlier));

				
		%end;
		%do k= 10 %to 31;
			data work.temp&k.;
				set work.TickerData&j.0&i.;
				if day(sasdate)=&k.;
				
			data work.ct_&j.0&i.&k.;
				set taq.ct_&j.0&i.&k.;
				hour = hour(TIME);
				minute = minute(TIME);
				second = 0;
				new_time = HMS(hour, minute, second);
				drop DATE SIZE G127 CORR COND EX hour minute second;
				
			proc sort data = work.ct_&j.0&i.&k. nodupkey;
			by symbol new_time;
			
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.0&i.&k. as b on a.ticker = b.symbol and a.time=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_now new_time = time_now));

				
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.0&i.&k. as b on a.ticker = b.symbol and a.time_5min_after=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_5_min_after new_time = time_5_min_after));	

			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.0&i.&k. as b on a.ticker = b.symbol and a.time_1min_after=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_1_min_after new_time = time_1_min_after));	

			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.0&i.&k. as b on a.ticker = b.symbol and a.time_5min_earlier=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_5_min_earlier new_time = time_5_min_earlier));

			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.0&i.&k. as b on a.ticker = b.symbol and a.time_1min_earlier=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_1_min_earlier new_time = time_1_min_earlier));

		%end;
		data sentpro.PriceData&j.0&i.;
			set 
			temp1
			temp2
			temp3
			temp4
			temp5
			temp6
			temp7
			temp8
			temp9
			temp10
			temp11
			temp12
			temp13
			temp14
			temp15
			temp16
			temp17
			temp18
			temp19
			temp20
			temp21
			temp22
			temp23
			temp24
			temp25
			temp26
			temp27
			temp28
			temp29
			temp30
			temp31;
	%end;
%end;
run;							
%mend;
%seperateandMerge1;

%macro seperateandMerge2;
%do j=2015 %to 2015;
	%do i=10 %to 12;
		%do k= 1 %to 9;
			data work.temp&k.;
				set work.TickerData&j.&i.;
				if day(sasdate)=&k.;
			
			data work.ct_&j.&i.0&k.;
				set taq.ct_&j.&i.0&k.;
				hour = hour(TIME);
				minute = minute(TIME);
				second = 0;
				new_time = HMS(hour, minute, second);
				drop DATE SIZE G127 CORR COND EX hour minute second;
			
			proc sort data = work.ct_&j.&i.0&k. nodupkey;
			by symbol new_time;
			
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.&i.0&k. as b on a.ticker = b.symbol and a.time=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_now new_time = time_now));

			
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.&i.0&k. as b on a.ticker = b.symbol and a.time_5min_after=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_5_min_after new_time = time_5_min_after));	


				
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.&i.0&k. as b on a.ticker = b.symbol and a.time_1min_after=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_1_min_after new_time = time_1_min_after));
			
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.&i.0&k. as b on a.ticker = b.symbol and a.time_5min_earlier=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_5_min_earlier new_time = time_5_min_earlier));
			
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.&i.0&k. as b on a.ticker = b.symbol and a.time_1min_earlier=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_1_min_earlier new_time = time_1_min_earlier));
				
		%end;

		%do k= 10 %to 31;
			data work.temp&k.;
				set work.TickerData&j.&i.;
				if day(sasdate)=&k.;
				
			data work.ct_&j.&i.&k.;
				set taq.ct_&j.&i.&k.;
				hour = hour(TIME);
				minute = minute(TIME);
				second = 0;
				new_time = HMS(hour, minute, second);
				drop DATE SIZE G127 CORR COND EX hour minute second;
				
			proc sort data = work.ct_&j.&i.&k. nodupkey;
			by symbol new_time;
			
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.&i.&k. as b on a.ticker = b.symbol and a.time=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_now new_time = time_now));

				
			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.&i.&k. as b on a.ticker = b.symbol and a.time_5min_after=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_5_min_after new_time = time_5_min_after));	

			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.&i.&k. as b on a.ticker = b.symbol and a.time_1min_after=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_1_min_after new_time = time_1_min_after));	

			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.&i.&k. as b on a.ticker = b.symbol and a.time_5min_earlier=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_5_min_earlier new_time = time_5_min_earlier));

			proc sql;
				create table temp&k. as select * from work.temp&k. as a left join work.ct_&j.&i.&k. as b on a.ticker = b.symbol and a.time_1min_earlier=b.new_time;
			data temp&k.;
				set temp&k.(rename=(PRICE=price_1_min_earlier new_time = time_1_min_earlier));

		%end;

		data sentpro.PriceData&j.&i.;
			set 
			temp1
			temp2
			temp3
			temp4
			temp5
			temp6
			temp7
			temp8
			temp9
			temp10
			temp11
			temp12
			temp13
			temp14
			temp15
			temp16
			temp17
			temp18
			temp19
			temp20
			temp21
			temp22
			temp23
			temp24
			temp25
			temp26
			temp27
			temp28
			temp29
			temp30
			temp31;
	%end;
%end;
run;							
%mend;
*%seperateandMerge2;
					