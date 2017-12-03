import pandas as pd
import os
import pickle

os.chdir("/Users/ziming/Desktop/Project/CoreProgram")

df = pd.read_csv("/Users/ziming/Desktop/Project/CoreProgram/LM.csv")


#354
df_pos = df[df['Positive']!=0]
#2355
df_neg = df[df['Negative']!=0]

data_pos = list(df_pos.Word.values.flatten())
data_neg = list(df_neg.Word.values.flatten())

temp = data_pos+data_neg

features= [] 
for i in temp:
    features.append(i.lower())

pickle.dump(features, open("features.p", "wb" ))


