# ORIE 4741 Final Report
## Tiansheng Liu & Ziming Zeng

## 1. Abstract 
The most popular hypothesis about financial market is the efficient market hpythesis, which states that the current price of an asset has reflected all of the available information. Under this assumption, what drives the price? The answer is news. In other words, price of an asset reacts to new information. Therefore, analyzing news is essentially the core of modern finance. There are 2 approaches to analyze the news- monitoring news 24 hours a day, or design an algorithm to analysze the sentiment of news automatically. The problem with the first approach is that market nowadays react to news so rapidly that human cannot possibly catch up with its speed. For example, the VIX index skyrocketed in a few seconds after Trump's tweet about "Fire and fury". That leaves us with only the second choice and we believe this is feasible method.  
Here are questions we care about:
1. How does information contained in news titles contribute to the formation of stock prices? Is a particular word affect stock price positively or negatively?
2. How long does it take for news to affect stock price? We will do regression between abnormal return after news coming out and news' sentiment score to find the best time interval.
3. If news titles turn out to have prediction power over stock price, how could we generate a profitable strategy to utilize it? 

## 2. Data Sources
1. News data: Thompson Reuters historical real-time news
The reason we choose Thompson Reuters is that they are famous for the speed of reporting news and the industry is actually using Thompson Reuters’ service. Comparing to Thompson Reuters, other sources like Bloomberg, Wall Street Journal and Financial Times are too slow. For our project, we are interested in implementing trading strategies at a relatively high frequency. Therefore, speed means everything for us.

2. Intraday millisecond stock price data: WRDS TAQ Database
NYSE Trade and Quote (TAQ) is a database created by NYSE. It contains intraday transactions (trades and quotes) data for all securities listed on New York Stock Exchange and American Stock Exchange. As the transactions data are recorded under millisecond level, datasets in TAQ are extremely big (20 million observations for one day’s data). Therefore, to handle TAQ datasets efficiently, we used SAS and a particular algorithm called Dow Loops to access TAQ data remotely on WRDS server.

3. Daily index data & stock price data: WRDS CRSP Database
The Center for Research in Securities Price (CRSP) is a database contains end-of-day and month-end prices on primary listings for NYSE, NASDAQ, and Arca exchanges, along with basic market indices. We use CRSP mainly for estimation of the beta in CAPM model.
4. Fama French Database
Fama French Database contains risk free rate and market risk premium data. We use this database also mainly for the estimation of beta.


## 3. Answers to possible questions
1.	Is your data corrupted: No. This is the advantage of using high-quality commercial news data from Thompson Reuters, TAQ and CRSP.
2.	How many features do you use: We use a dictionary (we will explain in great details below) that has 2337 negative words and 353 positive words. Therefore, the total number of features we use is 2690. 
3.	How do you solve overfitting: The weights we design will handle overfitting. Most of trivial words will have weights close to 0 assigned to them. Actually, in our problem setting, we don’t care about overfitting. We care about whether this strategy makes money. We will discuss this further in subsequent sections.
4.	How will you test the effectiveness of your model: Cross validation. Specifically, we do not use R squares as our criterion, we use portfolio returns. Again, we only care about whether this strategy makes money.
5.	Why not include more sources of data: Including other sources may cause duplicities. For example: Thompson Reuters reported fire and fury in 12:00 am and WSJ reported it again at 12:05 am. In our model, we need to tag return for the news, and if we don’t have consistent time for the same news we will be in trouble.
6.	Why do you think market reacts to sentiment of news: First, market reacts to new information. This is a conclusion of efficient market hypothesis (EMH) and is also the foundation of finance. Second, it has been proven by enormous amount of papers. 
7.	How do you trade assets that are mentioned in the news: We designed an algorithm on our own to extract company names from news! And we only trade liquid stocks that are mentioned in the news to avoid market impact. 
8.	Techniques from classes that you use: We use linear regression, n-fold cross validation, Lasso regression and Ridge regression.


## 4. Our idea  
Our idea can be divided into the following 2 steps. Details about each step can be found in following sections.
1.	Given a news, analyze the sentiment of the news
2.	Trade the company that is mentioned in the news according to the sentiment of the news and hedge the trade using S&P 500 futures.


## 5.  Step 1: Analyze the sentiment of news

### 1) Web Scrapping
We designed a web scraper to scratch the Thompson Reuters historical real-time news headline from 2007 – 2017. By locating XPath of the html code, we used Python and Scrapy to download news headlines from Thompson Reuters and stored them in the JSON format. This gave us 1GB size data. However, we only used data from 2011 – 2014 in the end due to the lack of Index data in other periods.
![Sentiment1](https://github.com/TSL-123/SentimentDrivenStrategy/blob/master/pic/1.png)   

### 2) News Data Cleaning
The raw news data were too messy for Natural Language Processing. Therefore, we did the following steps to clean the data:
•	Deleted stop words from news. Stop words are some most common words in a language that does not convey any meaning. A few examples of stop words from Python NLTK packages are: ‘his’, ‘the’, ‘an’.  
•	Deleted numbers from news.  
•	Delete all punctuations.  
•	Converted all words into lower case.  
•	Deleted words that are not English. Some of the news in Thompson Reuters were in Japanese and Chinese. And we deleted them using utf-8 encode and ASCII decode.   

### 3) Build Features
To build our features, we used a famous financial dictionary created by Loughran and McDonald. The reason we use this dictionary is that the sentiments of words in financial news can be quite different from our usual language. For example, “liability” may have a negative sentiment in our normal conversation, but in finance it is just a concept in financial report with no particular sentiment. Loughran and McDonald created this list of positive and negative words using 10-K and 10-Q reports from SEC and it has been widely used by the industry. This gives us 2337 negative words and 353 positive words. Therefore, the total number of features we use is 2690.


### 4) Our Model
Given a sentence of news headlines, we tokenized the headlines into single word and matched each word in the sentence with the Loughran and McDonald dictionary. 

We use a method put forward by Jagadeesh and Wu(2013) to generate weights of words. The intuition behind this is we assign weights for each word according to the market reaction to each headline that contains those words. Mathematically, the idear can be expressed as follows:    
![Formula1](https://github.com/TSL-123/SentimentDrivenStrategy/blob/master/pic/Formula_1.png)     

where J is the total number of positive and negative words in our lexicon,wj is the weight of word j,Fi,j is the number of occurences of word i in headline i, and ai is the total number of words in headline i. The only unknown of the above equation is wj and we can estimate wj using the following regression model:  
![Formula2](https://github.com/TSL-123/SentimentDrivenStrategy/blob/master/pic/Formula_2.png)     

Since b is a constant, we combine b and wj together and write it as Bj gives us the regression model:  
![Formula3](https://github.com/TSL-123/SentimentDrivenStrategy/blob/master/pic/Formula_3.png) 

where ri is the abnormal return of stock market caused by headline i. After getting Bj, we can get wj using standardization.

Why do we choose regression instead of classification? We have 10 years news data. It is impossible for us to tag them manually as 'positive' or 'negative'. Therefore, we have to tag them with returns. But if we only tag them as positve or negative according to returns, we fail to capture the magnitude of returns. Therefore, we choose to use multivariate regression to capture this magnitude.

### 5) Identify company names in news
The importance of trading the correct companies mentioned in the news is evident. And we design an algorithm to identify company names in news.  
 
 1.Data Cleaning:
 For company names data, we downloaded a list of all tradable companies in NYSE, NASDAQ and AMEX. And we did the following data cleaning procedures:
•	Convert all words into lower case.  
•	Delete punctuations.  
•	Delete words like ‘inc’, ‘corporation’, ‘corp’. This is particularly important because companies usually will be mentioned in its full names. For example, Apple Inc. may be called Apple in the news.   
•	Delete some companies that uses common words as its name. Specifically, we delete companies with following tickers: INCR, BSTI, QTWO, TIME, NWS, LN, CA, DNOW, TGT, GPI, BOX, USCR. BSTI, for example, is the ticker for Best Inc. After deleting ‘inc’, we are only left with ‘best’, which appears everywhere in the news.  
•	Delete companies that have market capital below 2 billion dollars. This is also important for high frequency trading. For small companies, buying and selling at big amounts will affect the prices greatly. Therefore, we only trade liquid big companies in order to avoid market impact.  

2.Algorithm  
Our algorithm can be easily illustrated using an example. Suppose we want to identify the company in following news: “Morgan Stanley is doing a great job this year.” We test whether each word of the company names is in the news. If we are testing whether this news is talking about Goldman Sachs, we can see neither of “goldman” or “sachs” appears in the news. Therefore, the match score is 0/2 = 0, where 2 is the length of company names. If we are testing whether this news is talking about Morgan Freeman (Let’s just pretend Morgan Freeman can really start a company). Then we can see that “morgan” appears in news but “freeman” does not. So the match score is 0.5. Now let’s test Morgan Stanley, both “morgan” and “stanley” appears in the news so the match scores will be 1. 

Our algorithm only keeps observations with the match score greater than 0.8 in order to make sure that we are trading the right companies. By random sampling from our match result and checking manually, we found that this algorithm gave us an excellent result. The overall accuracy was above 90%. For technical details, please refer to the python program we have uploaded - “Get_company_names_from_news.py”.

### 5) Abnormal Return Computation

(1) Beta Estimation
The computation of abnormal return is based on the Capital Asset Pricing Model (CAPM), which is the foundation of asset pricing. CAPM states that:

![Formula4](https://github.com/TSL-123/SentimentDrivenStrategy/blob/master/pic/Formula1.png)

where Ri is the return of the stock i, Rf is the risk-free rate and Rm is the return of the overall market. In plain language, it states that if you buy 1 share of stock i and sell β shares of market index, your expected payoff will be 0. 

Please note that this is the core of our trading strategy. For example, we want to short 1 share of Apple but afraid of the risk of overall market goes up. We can hedge the trade by longing β shares of market index. Our net expected payoff should be zero according to CAPM model. Therefore, we only care about the relative performance of Apple comparing to the market. If a negative news comes out about Apple, which makes Apple perform worse than the overall market, we are in business.

This is also the reason why we don’t care about the accuracy of our sentiment analysis regression. We are doing a hedge trade here. Even if our prediction is wrong, we will not lose a lot because it is a hedged trade and the expected payoff is 0 (if we do not consider transaction costs). If we know nothing and trade based on the result of a flip of coin, we have a 50% probability of being right. This strategy works like a casino. As long as we have a slightly higher probability of winning, even if our sentiment scores only give us 51% probability of being right, we will win in the long run.

One problem we had was that the coefficients β could change over time. For example, the graph bellow shows the beta of Apple over time. We can see that the β of Apple was around -1.2 on August 2012 but it was around 0.6 on Sep 2014. 

![pic](https://github.com/TSL-123/SentimentDrivenStrategy/blob/master/pic/3.png)

Therefore, we used a 24-months rolling regression approach to estimate beta of stocks at different dates. The idea of rolling regression is simple. Suppose we are considering the beta of Apple on 2014.4.7. Then we use the return data from 2012.4.7 to 2014.4.7 to estimate beta on 2014.4.7 for Apple. Now suppose we are considering the beta of Microsoft on 2012.9.8, Then we use the return data from 2010.9.8 to 2012.9.8 to estimate beta on 2012.9.8 for Microsoft. 

Return data were from CRSP and the risk-free data were from Fama French Database. For technical details, please refer to our attached SAS program “Rolling_regression.sas”. 

(2) Stock Return and Abnormal Stock Returns
After getting beta from rolling regression, we used TAQ database in order to get intraday stock returns data. And we used a special algorithm called Dow Loop in SAS to remotely handle TAQ data efficiently. For intraday index return data, we use CRSP Intraday Total Market Index as our data.

We tested 2 frequencies here: 5-minute frequency and 1-minute frequency. And our abnormal returns are calculated using the following formulas:
![formula5](https://github.com/TSL-123/SentimentDrivenStrategy/blob/master/pic/Formula5.png)

Given the low interest rate after the financial crisis in US, we can ignore the risk-free rate. Therefore, according to CAPM, the abnormal returns should have an expected value of 0. From the data, we can see that this is roughly true. 

![pic4](https://github.com/TSL-123/SentimentDrivenStrategy/blob/master/pic/4.png)


## 6. Step 2: Simulate Trading
After getting abnormal returns from section 5.6, we can finally start to run regression to assign sentiment scores based on our model described in section 5.4. 
### 1) Sparse Matrix Construction
Our data are news titles from 2007 to 2017, consisting of over 4 million records. So data cleaning and text processing are extremely important. Ideal format of our data are split words, so we can directly match them with directionary or compare them with each other. To cusomize the data, we delete meaningless symbol like "/","(" and fixed match with such symbols like "'s". Aside from meaningless symbol, we have emotionless words in the sentence. Suppose we have too many words like "of", "and" in a sentence. The method described in earlier chapter will be tarnished. By importing nltk package, we  delete common stop words from our data and get a clean dataset ready for analysis.

We also tried to get an overlook on the news data. Our cleaned data shows clear pattern that most news have sentiment factor close to 0. Rest have significant positive or negative sentiment factor.

![Trend](https://github.com/TSL-123/SentimentDrivenStrategy/blob/master/pic/trend_plot.png)

### 2) Company Matching

### 3) Strategy Construction

## 7. Conclusion

