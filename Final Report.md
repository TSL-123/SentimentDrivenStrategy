# ORIE 4741 Final Report
## Tiansheng Liu & Ziming Zeng

## 1. Abstract 
The most popular hypothesis about financial market is the efficient market hpythesis, which states that the current price of an asset has reflected all of the available information. Under this assumption, what drives the price? The answer is news. In other words, price of an asset reacts to new information. Therefore, analyzing news is essentially the core of modern finance. There are 2 approaches to analyze the news- monitoring news 24 hours a day, or design an algorithm to analysze the sentiment of news automatically. The problem with the first approach is that market nowadays react to news so rapidly that human cannot possibly catch up with its speed. For example, the VIX index skyrocketed in a few seconds after Trump's tweet about "Fire and fury". That leaves us with only the second choice and we believe this is feasible method.  
Here are questions we care about:
1. How does information contained in news titles contribute to the formation of stock prices? Is a particular word affect stock price positively or negatively?
2. How long does it take for news to affect stock price? We will do regression between abnormal return after news coming out and news' sentiment score to find the best time interval.
3. If news titles turn out to have prediction power over stock price, how could we generate a profitable strategy to utilize it? 

## 2. Data we use
For news data, we use Thompson Reuters historical real-time news headlines data from 2007 to 2017. This gives us 1GB size data, which we believe is enough for training our 1-gram model. But if you want to train like a 15-gram model, the news data alone will not be enough. The reason why we chose Thompson Reuters is that they are famous for the speed of reporting news and the industry is actually using Thompson Reuters' service. Comparing to Thompson Reuters, other sources like Bloomberg, Wall Street Journal and Financial Times are too slow. For our project, we are interested in implementing trading strategies at a relatively high frequency. Therefore, speed means everything for us.  

For stock price data, we use NYSE Trade and Quote(TAQ) database. It contains intraday transaction data(trades and quotes) for all securities listed on the NYSE and American Stock Exchange(AMEX), as well as Nasdaq National Market System(NMS) and SmallCap issues. In comparison with other database we considered, NYSE TAQ database provides more accessible intraday data. Since we want to find best time interval that reflects news' effect on stock price, intraday data is the best choice for us. 

## 3. Answers to possible questions
1. Techniques in class we use?

2. blabla


## 4. Our idea} 
Our idea can be basically divided into 2 steps. Details about each step can be found in following sections.  
1. Analyze sentiment of the news and generate a sentiment factor for a given news.
2. Target the company that is mentioned in the news
3. Construct a strategy to trade the company that is mentioned in the news and hedge the trade with S&P 500 futures, so only the comparative performance matters.

## 5. Methods and Models
### 1) Step 1 Sentiment Analysis
The problem with the first model is that it assumes that every positive or negative word has the same weight. This is obviously not true. For example, "crash" has a stronger sentiment comparing to "drop". Therefore, in this model, we will assign weights to different words.

We use a method put forward by Jagadeesh and Wu(2013) to generate weights of words. The intuition behind this is we assign weights for each word according to the market reaction to each headline that contains those words. Mathematically, the idear can be expressed as follows:  
Sentiment_i= \Sigma_{j=1}^J(w_jF_{i,j}\frac{1}{a_i})  
where J is the total number of positive and negative words in our lexicon,$w_j$ is the weight of word j,$F_{i,j}$ is the number of occurences of word i in headline i, and $a_i$ is the total number of words in headline i. The only unknown of the above equation is $w_j$ and we can estimate $w_j$ using the following regression model:
$$r_i=a+b \Sigma_{j=1}^J(w_jF_{i,j})\frac{1}{a_i}+\epsilon_i$$  

Since b is a constant, we combine b and $w_j$ together and write it as $B_j$ gives us the regression model:
$$r_i=a+\Sigma_{j=1}^J(B_jF_{i,j})\frac{1}{a_i}+\epsilon_i$$

where $r_i$ is the abnormal return of stock market caused by headline i. After getting $B_j$, we can get $w_j$ using standardization.

Why do we choose regression instead of classification? We have 10 years news data. It is impossible for us to tag them manually as 'positive' or 'negative'. Therefore, we have to tag them with returns. But if we only tag them as positve or negative according to returns, we fail to capture the magnitude of returns. Therefore, we choose to use multivariate regression to capture this magnitude.

### 2) Step 2 Ticker Matching
 So how do we trade the particular stocks that are mentioned in the news? The answer is a fuzzy match algorithm. We have collected all the company names from NYSE, NASDAQ, AMEX from NASDAQ and we make a Python dictionary with kays equal to the company names and values equal to its symbol. The problem here is that companies may not be mentioned in its full names in the news. For example, Apple Inc. may be called Apple in the news. That is why we need a fuzzy match algorithm here. (to be continued,,,)

### 3) Step 3 Strategy Construction
One of our problems in this project is that we cannot simulate it in real-time because we cannot affort Thompson Reuters' real-time news service and getting real-time bid and ask quote from our brokers. If we cannot get this real-time data, simulating trading using laged news data has no meaning. Therefore, in this step, we seperate our data into training and testing data and back test our strategy.  (to be continued,,,)

## 6. Project Achievements
### 1) Data Cleaning and Text Processing
Our data are news titles from 2007 to 2017, consisting of over 4 million records. So data cleaning and text processing are extremely important. Ideal format of our data are split words, so we can directly match them with directionary or compare them with each other. To cusomize the data, we delete meaningless symbol like "/","(" and fixed match with such symbols like "'s". Aside from meaningless symbol, we have emotionless words in the sentence. Suppose we have too many words like "of", "and" in a sentence. The method described in earlier chapter will be tarnished. By importing nltk package, we  delete common stop words from our data and get a clean dataset ready for analysis.

We also tried to get an overlook on the news data. Our cleaned data shows clear pattern that most news have sentiment factor close to 0. Rest have significant positive or negative sentiment factor.

![Trend](https://github.com/TSL-123/SentimentDrivenStrategy/blob/master/pic/trend_plot.png)

### 2) Company Matching

### 3) Strategy Construction

## 7. Conclusion

