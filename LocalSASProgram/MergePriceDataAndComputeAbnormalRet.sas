/*
data sentpro.PriceDataAggregated;
	set
	sentpro.pricedata201104
	sentpro.pricedata201105
	sentpro.pricedata201106
	sentpro.pricedata201107
	sentpro.pricedata201108
	sentpro.pricedata201109
	sentpro.pricedata201110
	sentpro.pricedata201111
	sentpro.pricedata201112
	sentpro.pricedata201201
	sentpro.pricedata201202
	sentpro.pricedata201203
	sentpro.pricedata201204
	sentpro.pricedata201205
	sentpro.pricedata201206
	sentpro.pricedata201207
	sentpro.pricedata201208
	sentpro.pricedata201209
	sentpro.pricedata201210
	sentpro.pricedata201211
	sentpro.pricedata201212
	sentpro.pricedata201301
	sentpro.pricedata201302
	sentpro.pricedata201303
	sentpro.pricedata201304
	sentpro.pricedata201305
	sentpro.pricedata201306
	sentpro.pricedata201307
	sentpro.pricedata201308
	sentpro.pricedata201309
	sentpro.pricedata201310
	sentpro.pricedata201311
	sentpro.pricedata201312
	sentpro.pricedata201401
	sentpro.pricedata201402
	sentpro.pricedata201403
	sentpro.pricedata201404
	sentpro.pricedata201405
	sentpro.pricedata201406
	sentpro.pricedata201407
	sentpro.pricedata201408
	sentpro.pricedata201409
	sentpro.pricedata201410
	sentpro.pricedata201411
	sentpro.pricedata201412;
run;

*/
data sentpro.PriceDataAggregatedClean;
	set sentpro.Pricedataaggregated;
	if SYMBOL ~= '';
	*Define Stock Returns;
	price_normal_to_pos5_return = (price_5_min_after - price_now)/price_now;
	price_normal_to_pos1_return = (price_1_min_after - price_now)/price_now;
	price_minus1_to_pos1_return = (price_1_min_after - price_1_min_earlier)/price_1_min_earlier;
	price_minus1_to_pos5_return = (price_5_min_after - price_1_min_earlier)/price_1_min_earlier;
	price_minus5_to_pos5_return = (price_5_min_after - price_5_min_earlier)/price_5_min_earlier;
	price_minus5_to_pos1_return = (price_1_min_after - price_5_min_earlier)/price_5_min_earlier;
	*Define Abnormal Returns;
	abnormal_normal_to_pos5_return = price_normal_to_pos5_return-returns_normal_to_pos5;
	abnormal_normal_to_pos1_return = price_normal_to_pos1_return-returns_normal_to_pos1;
	abnormal_minus1_to_pos5_return = price_minus1_to_pos5_return-returns_minus1_to_pos5;
	abnormal_minus1_to_pos1_return = price_minus1_to_pos1_return-returns_minus1_to_pos1;
	abnormal_minus5_to_pos5_return = price_minus5_to_pos5_return-returns_minus5_to_pos5;
	abnormal_minus5_to_pos1_return = price_minus5_to_pos1_return-returns_minus5_to_pos1;

*	keep News Time sasdate ticker abnormal_normal_to_pos5_return abnormal_normal_to_pos1_return abnormal_minus1_to_pos5_return abnormal_minus1_to_pos1_return abnormal_minus5_to_pos5_return abnormal_minus5_to_pos1_return;
run;


	



	
	
	
	
	
	
	
	
	
	
	
	
	
	