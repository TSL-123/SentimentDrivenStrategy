#Design a data structure
#Structure: Python Dict
#News: Key
#Tokenized words in news: values

import pickle
import os
import pandas as pd
import numpy as np
from nltk.tokenize import word_tokenize
import re
from nltk.corpus import stopwords

os.chdir("/Users/ziming/Desktop/Project/CoreProgram")
feature_list = pickle.load(open("features.p","rb"))

df = pd.read_sas("/Users/ziming/Desktop/SASUniversityEdition/myfolders/ProjectSASProgram/Data/a_outputdata.sas7bdat")
df_sort = df.sort_values(by=['sasdate','Time'])
data = list(df_sort.News.values.flatten())

#Decode it into string 
data1 = [i.decode('latin-1') for i in data]
data2 = [i[2:-1] for i in data1]

#Defne Stop Words;
stop_words = set(stopwords.words("english"))

contained_words = []
print("Start building data structure.")
for w in data2:
    #Delete punctuations;
    w = re.sub(r'[^\w\s]',' ',w)
    temp = word_tokenize(w)
    lower_word = []
    for word in temp:
        if word not in stop_words:
            lower_word.append(word.lower())
    contained_words.append(lower_word)
    
pickle.dump(contained_words, open( "contained_words.p", "wb" ) )


