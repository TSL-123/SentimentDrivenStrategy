from sklearn import linear_model
import numpy as np
import pandas as pd
import scipy.sparse as sps
import numpy as np
import pickle
import os
from nltk.tokenize import word_tokenize
import re
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_validate
from nltk.corpus import stopwords
from sklearn.linear_model import Lasso
from time import time
from scipy.sparse.linalg import lsqr
from sklearn.metrics import mean_squared_error, r2_score
import matplotlib.pyplot as plt
##from sklearn.datasets import load_boston
##boston = load_boston()
##
##df_x = pd.DataFrame(boston.data,columns = boston.feature_names)
##df_y = pd.DataFrame(boston.target)
##
##df_x.describe()
##
##reg = linear_model.LinearRegression()
##
##x_train,x_test,y_train,y_test = train_test_split(df_x,df_y,test_size=0.2,random_state=False)
##
##reg.fit(x_train,y_train)
##
##print(reg.coef_)
##
##a=reg.predict(x_test)
##print(a)
##
##print(np.mean((a-y_test)**2))


os.chdir("/Users/ziming/Desktop/Project/CoreProgram")

feature_list = pickle.load(open("features.p","rb"))
contained_words = pickle.load(open("contained_words.p","rb"))


#X's paramters:
data,indptr,indices=pickle.load(open("SparseMatrixParameters.p","rb"))
X = sps.csr_matrix((data,indices,indptr))


#Y:
df = pd.read_sas("/Users/ziming/Desktop/SASUniversityEdition/myfolders/ProjectSASProgram/Data/a_outputdata.sas7bdat")
df_sort = df.sort_values(by=['sasdate','Time'])

Y = np.array(df_sort.abnormal_minus1_to_pos5_return)


#Need to do data cleaning wrt Y
Y_clean = np.nan_to_num(Y)

#80% of data used for training and 20% left for testing

X_train,X_test,Y_train,Y_test = train_test_split(X,Y_clean,test_size=0.2,random_state=False,shuffle=False)

print('StartSolving')
reg = linear_model.LinearRegression()

t0 = time()
reg.fit(X_train, Y_train)



print("OLS Reg done in %fs" % (time() - t0))
coefficients = reg.coef_
intercept = reg.intercept_

#From traning set, we want to get the empirical distribution of sentiment scores
X_train_dense = X_train.todense()
w_matrix = np.asmatrix(coefficients)
w = w_matrix.transpose()

news_length=[]
for news in contained_words:
    news_length.append(len(news))

train_set_news_length = news_length[:len(Y_train)]


train_raw_scores = X_train_dense*w
train_temp = train_raw_scores.tolist()

train_temp_scores = [] 
for i in train_temp:
    for j in i:
        train_temp_scores.append(j)

train_document_scores = np.divide(np.array(train_temp_scores),np.array(train_set_news_length))

plt.hist(train_document_scores,bins=100)
plt.show()

train_scores_small = []
train_scores_big = []
for i in train_document_scores:
    if i >0:
        train_scores_big.append(i)
    elif i<0:
        train_scores_small.append(i)

buy_limit = np.percentile(train_scores_big,80)
sell_limit = np.percentile(train_scores_small,80)




#Then we want to generate document scores
#Convert test set X matrix to dense matrix
X_test_dense = X_test.todense()

test_set_news_length = news_length[-len(Y_test):]


test_raw_scores = X_test_dense*w
test_temp = test_raw_scores.tolist()

test_temp_scores = [] 
for i in test_temp:
    for j in i:
        test_temp_scores.append(j)

document_scores = np.divide(np.array(test_temp_scores),np.array(test_set_news_length))


long_or_short = []
for score in document_scores:
    if score > buy_limit:
        long_or_short.append(1)
    elif score < sell_limit:
        long_or_short.append(-1)
    else:
        long_or_short.append(0)

#Exclude those extremly volatile samples 
cleaned_Y = []
for i in Y_test:
    if i < -0.4 or i>0.4:
        cleaned_Y.append(0)
    else:
        cleaned_Y.append(i)
        
profit = np.array(long_or_short)*np.array(cleaned_Y)

#Data Cleaning
profit_plus1 = profit+1


test_small = []
test_big = []
for money in profit_plus1:
    if money<1:
        test_small.append(money)
    if money>1:
        test_big.append(money)

print("small",len(test_small))
print("big",len(test_big))


print("Start Calculating Returns")
total_return = 1

j=0
portfolio_values = []
for money in profit_plus1:
    portfolio_values.append(total_return)
    total_return = total_return * money
    


print(total_return)







