import scipy.sparse as sps
import numpy as np
import pickle
import os
import pandas as pd
import numpy as np
from nltk.tokenize import word_tokenize
import re
from nltk.corpus import stopwords

def cls():
    print("\n" * 100)

os.chdir("/Users/ziming/Desktop/Project/CoreProgram")

feature_list = pickle.load(open("features.p","rb"))
contained_words = pickle.load(open("contained_words.p","rb"))

print(type(feature_list))
print(type(feature_list[0]))
###Want to build 3 arrays to store a sparse matrix

#Create a dictionary
#Keys: Features
#Values: Index

dic_feature={}
j=0
for i in feature_list:
    dic_feature[i]=j
    j+=1

#Constructino of arr1, arr2, arr3
            
arr1=[]
arr2=[0]
arr3=[]
temp = 0#This is the temp variable to construct arr2

for news in contained_words:
    non_zero_in_1row = 0
    construct_arr1 = []
    for word in news:
        if word in dic_feature:
            arr3.append(dic_feature[word])
            non_zero_in_1row +=1
    #Construct arr1
    construct_arr1 = [1.0/len(news)]*non_zero_in_1row
    arr1.extend(construct_arr1)
    #Construct arr2
    temp+=non_zero_in_1row
    arr2.append(temp)


#18335 Matches
data = np.array(arr1)            
indptr = np.array(arr2)
indices = np.array(arr3)
pickle.dump([data,indptr,indices],open("SparseMatrixParameters.p","wb"))










