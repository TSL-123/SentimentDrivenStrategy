###############################
#Merge Data with company names#
###############################

import pandas as pd
import os
import pickle
from nltk.tokenize import word_tokenize
import re
from time import time
os.chdir("/Users/ziming/Desktop/Project/DataCleaning")
df = pd.read_csv("Company_clean.csv")

#Only consider companies with market capital greater than 1 billion
df1 = df[df.MktCap>=1000000000]

company_names_list = []
#Want to get the corresponding ticker
k=0
corresponding_ticker_index = []
for i in df1.Name:
    temp = word_tokenize(i)
    if 'Fund' not in temp and 'ETF' not in temp:#Exclude ETF and Fund
        company_names_list.append(temp)
        corresponding_ticker_index.append(k)
    k+=1


clean_names = []
ticker_index_for_clean_names = []
temp_index= 0 
for names in company_names_list:
    temp1 = []
    for words in names:
        head, sep, tail = words.lower().partition('.com')
        if head not in ['inc','corporation','nasdaq',',','.','incorporated','lp','limited','holdings','ltd',
                        'corp','(',')','co','inc.','plc','corp.','limited.','ltd.','l.p','group','company']:
            temp1.append(head)
    if len(temp1) != 0:
        clean_names.append(temp1)
        ticker_index_for_clean_names.append(corresponding_ticker_index[temp_index])
    temp_index +=1

ticker = []
for i in ticker_index_for_clean_names:
    ticker.append(df1.Symbol[i:i+1].item())

         
contained_words = pickle.load(open("contained_words.p","rb"))
#df_sas = pd.read_sas("/Users/ziming/Desktop/SASUniversityEdition/myfolders/ProjectSASProgram/Data/aggregated_data.sas7bdat")
t0=time()
i=0
news_associated_company_high_confidence=[]
news_associated_company_ticker = []
for news in contained_words:
    i+=1
    if i == 1000:
        print("0.1% complete")
        print("Time cost: %fs"%(time()-t0))
    if i == 100000:
        print("10% complete")
    if i == 500000:
        print("50% complete")
    if i == 800000:
        print("80% complete")
    names_index = 0
    for names in clean_names:
        count=0
        for news_word in news:
            if news_word in names:
                count+=1
        score = (count+0.)/len(names)

        if score >= 0.8:
            news_associated_company_high_confidence.append(names)
            news_associated_company_ticker.append(ticker[names_index])
            
            break
        if names == clean_names[-1] and score<0.8:
            news_associated_company_high_confidence.append('N')
            news_associated_company_ticker.append('N')

        names_index+=1
        

import pickle

pickle.dump(news_associated_company_high_confidence,open("companyNames_high.p","wb"))
pickle.dump(news_associated_company_ticker,open("companyTicker_high.p","wb"))
print("Total Time cost: %fs"%(time()-t0))
print("Done.")



##for news in contained_words[:100]:
##    i+=1
##    if i == 1000:
##        print("0.1% complete")
##        print("Time cost: %fs"%(time()-t0))
##    if i == 100000:
##        print("10% complete")
##    if i == 500000:
##        print("50% complete")
##    if i == 800000:
##        print("80% complete")
##    count = 0
##    for news_word in news:
##        for names in clean_names:
##            if news_word in names:
##                count+=1
##            score = (count+0.)/len(names)
##            if score >= 0.8:
##                news_associated_company_high_confidence.append(names)
##                break;break
##
##                
##                #news_associated_company_low_confidence.append(names)
##
##            if score<0.8:
##                news_associated_company_high_confidence.append('N')
##                break
##                #news_associated_company_low_confidence.append(names)
##            else:
##                news_associated_company_high_confidence.append('N')
##                #news_associated_company_low_confidence.append('NoMatch')
##    
##
##print("All Complete! Time cost: %fs"%(time()-t0)) 
##
##
##news_associated_company_high_confidence = []
###news_associated_company_mid_confidence = []
##print("Start Matching")
##t0=time()
##count=0
##
##for news in contained_words[0]:
##    count+=1
##    for i in range(len(news)):
##        for names in clean_names:
##            if i == len(news)-1:
##                news_associated_company_high_confidence.append('N')
##                print("match N because of end of news words")
##                break;break
##            elif len(names)>=2:
##                if news[i] in names and news[i+1] in names:#If there are 2 consequtive matches then we good
##                    news_associated_company_high_confidence.append(names)
##                    break;break
##            elif len(names) ==1:
##                if news[i] in names:
##                    news_associated_company_high_confidence.append(names)
##                    break;break
##            if names==clean_names[-1]:
##                news_associated_company_high_confidence.append('N')
##                print("match because of unknow")
##                break;break
##print("time cost is %fs"%(time()-t0))
##    




 


           

##news_associated_company_high_confidence = []
##news_associated_company_low_confidence = []
##print("Start Matching")
##t0=time()
##for i in range(len(contained_words)):
##    if i == 1000:
##        print("0.1% complete")
##        print("Time cost: %fs"%(time()-t0))
##    if i == 10000:
##        print("1% complete")
##    if i == 100000:
##        print("10% complete")
##    if i == 500000:
##        print("50% complete")
##    count = 0.0
##    score = 0.0
##    for word in contained_words[i]:
##        for j in range(len(clean_names)):
##            if word in clean_names[j]:
##                count+=1.0
##            score = count/len(clean_names[j])
##            if score >= 0.8:
##                news_associated_company_high_confidence.append(df1.Symbol.values[j])
##                news_associated_company_low_confidence.append(df1.Symbol.values[j])
##            elif score >= 0.5:
##                news_associated_company_high_confidence.append('NoMatch')
##                news_associated_company_low_confidence.append(df1.Symbol.values[j])
##            else:
##                news_associated_company_high_confidence.append('NoMatch')
##                news_associated_company_low_confidence.append('NoMatch')
##    
##
##print("Time cost: %fs"%(time()-t0))            
##        




##company_names_list = []
##for i in df1.Name:
##    temp = word_tokenize(i)
##    for word in temp:
##        company_names_list.append(word.lower())
##
##company_names_set = set(company_names_list)
##
#Delete Inc, Corporation Stuff
##clean_names = []
##for names in company_names_set:
##    if names not in ['inc','corporation',',','.','incorporated','limited','ltd','corp','(',')','co','inc.','corp.','limited.','ltd.']:
##        clean_names.append(names)
##
##clean_names_set = set(clean_names)

##
###Construct a dictionary
###Key: word
###Values: symbol
##
##symbol_dic = {}
##for name in clean_names_set:
##    contained_symbol=[]
##    for i in range(len(df1.Name)):
##        temp = word_tokenize(df1.Name.values[i].lower())
##        if name in temp:
##            contained_symbol.append(df1.Symbol.values[i])
##    symbol_dic[name] = contained_symbol
##
##############################
###Merge News with symbol_dic#
##############################
##os.chdir("/Users/ziming/Desktop/Project/DataCleaning")
##
##contained_words = pickle.load(open("contained_words.p","rb"))
##df_sas = pd.read_sas("/Users/ziming/Desktop/SASUniversityEdition/myfolders/ProjectSASProgram/Data/aggregated_data.sas7bdat")
##
##
##news_associated_company = {}
##for i in range(len(contained_words)):
##    for word in contained_words[i]:
##        if word in symbol_dic:
##           news_associated_company[i] = symbol_dic[word]
##        else:
##            news_assciated_company[i] = '0'
    
        



    




