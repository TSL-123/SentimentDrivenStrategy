
data sentpro.aggregated_data;
	set
	sentpro.merged_data201104
	sentpro.merged_data201105
	sentpro.merged_data201106
	sentpro.merged_data201107
	sentpro.merged_data201108
	sentpro.merged_data201109
	sentpro.merged_data201110
	sentpro.merged_data201111
	sentpro.merged_data201112
	sentpro.merged_data201201
	sentpro.merged_data201202
	sentpro.merged_data201203
	sentpro.merged_data201204
	sentpro.merged_data201205
	sentpro.merged_data201206
	sentpro.merged_data201207
	sentpro.merged_data201208
	sentpro.merged_data201209
	sentpro.merged_data201210
	sentpro.merged_data201211
	sentpro.merged_data201212
	sentpro.merged_data201301
	sentpro.merged_data201302
	sentpro.merged_data201303
	sentpro.merged_data201304
	sentpro.merged_data201305
	sentpro.merged_data201306
	sentpro.merged_data201307
	sentpro.merged_data201308
	sentpro.merged_data201309
	sentpro.merged_data201310
	sentpro.merged_data201311
	sentpro.merged_data201312
	sentpro.merged_data201401
	sentpro.merged_data201402
	sentpro.merged_data201403
	sentpro.merged_data201404
	sentpro.merged_data201405
	sentpro.merged_data201406
	sentpro.merged_data201407
	sentpro.merged_data201408
	sentpro.merged_data201409
	sentpro.merged_data201410
	sentpro.merged_data201411
	sentpro.merged_data201412
	sentpro.merged_data201501
	sentpro.merged_data201502
	sentpro.merged_data201503
	sentpro.merged_data201504
	sentpro.merged_data201505
	sentpro.merged_data201506
	sentpro.merged_data201507
	sentpro.merged_data201508
	sentpro.merged_data201509
	sentpro.merged_data201510
	sentpro.merged_data201511
	sentpro.merged_data201512
	sentpro.merged_data201601
	sentpro.merged_data201602
	sentpro.merged_data201603
	sentpro.merged_data201604
	sentpro.merged_data201605
	sentpro.merged_data201606
	sentpro.merged_data201607
	sentpro.merged_data201608
	sentpro.merged_data201609
	sentpro.merged_data201610
	sentpro.merged_data201611
	sentpro.merged_data201612
	sentpro.merged_data201701
	sentpro.merged_data201702
	sentpro.merged_data201703
	sentpro.merged_data201704
	sentpro.merged_data201705
	sentpro.merged_data201706
	sentpro.merged_data201707
	sentpro.merged_data201708
	sentpro.merged_data201709;
	drop 
	time_5min_after 
	time_1min_after 
	time_1min_earlier 
	time_5min_earlier 
	INDEXDATE_ORI 
	INDEXTIME_ORI
	INDEXDATE_1minLater
	INDEXTIME_1minLater 
	INDEXDATE_5minLater
	INDEXTIME_5minLater 
	INDEXDATE_1minEarlier
	INDEXTIME_1minEarlier 
	INDEXDATE_5minEarlier
	INDEXTIME_5minEarlier;
run;
quit;
	
data sentpro.aggregated_data;
	set sentpro.aggregated_data;
	returns_minus5_to_pos5 = (100*(INDEX_5minLater - INDEX_5minEarlier))/INDEX_5minEarlier;
	returns_minus1_to_pos5 = (100*(INDEX_5minLater - INDEX_1minEarlier))/INDEX_1minEarlier;
	returns_normal_to_pos5 = (100*(INDEX_5minLater - INDEX_ori))/INDEX_ori;
	returns_minus5_to_pos1 = (100*(INDEX_1minLater - INDEX_5minEarlier))/INDEX_5minEarlier;
	returns_minus1_to_pos1 = (100*(INDEX_1minLater - INDEX_1minEarlier))/INDEX_1minEarlier;
	returns_normal_to_pos1 = (100*(INDEX_1minLater - INDEX_ori))/INDEX_ori;
run;
quit;

	
	
	
	