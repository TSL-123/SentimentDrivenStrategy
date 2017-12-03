proc sort data = sentpro.crspdata out = work.crspdata;
by ticker date;

data firstandlastdates;
	set work.crspdata;
    by ticker; /*MSF is always sorted by permno date*/
    retain firstdate;
    date=intnx('month', date, 1)-1;
    if first.ticker then firstdate=date;
    if last.ticker then do;
    	lastdate=date;
	output;
    end;
run;

data permnosrankdates(rename=(date=rankdate));
	set firstandlastdates;
	date=firstdate;
    do while(date<=lastdate);
    	output;
	date=intnx('month', date+1, 1)-1;
   	end;
run;


data permnosrankdates;
	set permnosrankdates;
    date=rankdate;
    i=1;
    do while(i<=24);
        output;
        date=intnx('month', date, 0)-1;
	i=i+1;
    end;
run;

data work.famafrench(rename=(new_date = date));
	set sentpro.famafrench;
	new_date = input(put(date,6.), yymmn6.);
	new_date=intnx('month', new_date, 1)-1; 
	format new_date yymmddn8.;
	drop date;
*	year=floor(date/100);
*	month = date-year*100;
run;

proc sort data=permnosrankdates;
by date ticker;


data permnosrankdates;
    merge permnosrankdates(in=a) famafrench(in=b);
    by date;
    if a and b;
run;

data msf;
	set sentpro.crspdataWithReturns;
    where retx is not missing;
    date=intnx('month', date, 1)-1;
run;

proc sort data=msf;
by date ticker;
run;

data permnosrankdates;
	merge permnosrankdates(in=a) msf(in=b);
    by date ticker;
    if a and b;
run;

data permnosrankdates;
    set permnosrankdates;
    exret=retx*100-rf;
run;

proc sort data=permnosrankdates;
by ticker rankdate;
run;

data permnosrankdates;
	set permnosrankdates;
	keep permno rankdate ticker date mkt_rf exret;
run;
quit;
	

proc reg data=permnosrankdates outest=est edf noprint;
    by ticker rankdate;
    model exret=mkt_rf;
run;

data sentpro.est(rename=(Mkt_rf=beta));
	set work.est;
	year = year(rankdate);
	month = month(rankdate);
	keep ticker rankdate Mkt_rf year month;
run;

data work.pricedataaggregatedclean;
	set sentpro.pricedataaggregatedclean;
	year = year(sasdate);
	month = month(sasdate);
run;

	

proc sql;
	create table sentpro.A_PriceAndBeta
	as select * from work.pricedataaggregatedclean as a left join sentpro.est as b 
	on a.symbol = b.ticker and a.year = b.year and a.month = b.month;
run;
quit;

data sentpro.A_OutPutData;
	set sentpro.A_PRICEANDBETA;
	abnormal_normal_to_pos5_return = price_normal_to_pos5_return-beta*returns_normal_to_pos5;
	abnormal_normal_to_pos1_return = price_normal_to_pos1_return-beta*returns_normal_to_pos1;
	abnormal_minus1_to_pos5_return = price_minus1_to_pos5_return-beta*returns_minus1_to_pos5;
	abnormal_minus1_to_pos1_return = price_minus1_to_pos1_return-beta*returns_minus1_to_pos1;
	abnormal_minus5_to_pos5_return = price_minus5_to_pos5_return-beta*returns_minus5_to_pos5;
	abnormal_minus5_to_pos1_return = price_minus5_to_pos1_return-beta*returns_minus5_to_pos1;
	keep news Time sasdate ticker abnormal_normal_to_pos5_return abnormal_normal_to_pos1_return abnormal_minus1_to_pos5_return abnormal_minus1_to_pos1_return abnormal_minus5_to_pos5_return abnormal_minus5_to_pos1_return;
run;

/*
proc univariate data=A_PriceAndBeta noprint;
histogram abnormal_minus_to_pos1_return;
run;

proc sgplot data=A_PriceAndBeta;
  histogram abnormal_normal_to_pos1_return / binwidth=0.1 transparency=0.5
               name="0_1" legendlabel="0-1 Abnormal Returns";

  histogram abnormal_minus1_to_pos1_return / binwidth=0.1 transparency=0.5
               name="-1_1" legendlabel="-1-1 Abnormal Returns";
  
  density abnormal_normal_to_pos1_return / type=kernel lineattrs=GraphData1;  /* optional */
  density abnormal_minus1_to_pos1_return / type=kernel lineattrs=GraphData2;  /* optional */
  xaxis label="Abnormal Returns" min=-1 max=1;
  keylegend "petal" "sepal" / across=1 position=TopRight location=Inside;
run;
*/











