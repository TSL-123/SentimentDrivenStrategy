
# coding: utf-8

# In[261]:

import pandas as pd
import math
import numpy as np
import os
import json
get_ipython().magic('matplotlib inline')


# In[2]:

os.getcwd()
os.chdir("/Users/liutianakira/Desktop/orie 4741 big messy data/project_dictionary_processing")  ##### change directionary here


# In[3]:

rawwordlist=pd.read_excel("LoughranMcDonald_MasterDictionary_2014.xlsx")


# In[4]:

rawwordlist.shape
rawwordlist.head()


# In[5]:

wordlist={}
length=len(rawwordlist["Word"])
for i in range(length):
    if rawwordlist.loc[i,'Negative']!=0:
        wordlist.update({rawwordlist.loc[i,'Word']:-1})
    elif rawwordlist.loc[i,'Positive']!=0:
        wordlist.update({rawwordlist.loc[i,'Word']:1})


# In[140]:

def context(pre,back):
    if ((pre>='a' and pre<='z') or (pre>='A' and pre<='Z')) and ((back>='a' and back<='z') or (back>='A' and back<='Z')):
        return True
    else:
        return False
    

def data_clean(sentence):
    for i in sentence:
        cnt=0
        lenk=len(sentence)
        ##if cnt==0 and sentence[0:10]=='TREASURIES-':
          ##  sentence=sentence[11:]
        if (i>='a' and i<='z') or (i>='A' and i<='Z') or i=='.' or (i>='0' and i <='9'):##or ( i =="/" and  context(sentence[sentence.index(i)-1],sentence[sentence.index(i)+1])==True)## 
            ##print(1,i)
            continue
        elif (sentence.index(i)+1)<lenk:
            if i=="'" and (sentence[sentence.index(i)+1] =='s' or sentence[sentence.index(i)+1] =='S'):
                #print(2)
                temp=sentence.index(i)
                sentence=sentence[:temp]+' '+sentence[temp+2:]
                continue
            else:
                 #print("where are you")
                 temp=sentence.index(i)
                 sentence=sentence[:temp]+' '+sentence[temp+1:]  
            
        if sentence[lenk-3:lenk]=='...':
            sentence=sentence[:lenk-3]
            #print(0)
            continue
    return sentence


def senten_senti(sentence):
    cnt=0
    nb=0
    for i in sentence:
        nb+=1
        if i in wordlist:
            cnt+=wordlist[i]
    if nb>0:
        return cnt*1.0/nb
    else:
        return 0


# In[125]:

f=open("data2007.json","r")
book=json.load(f)
length=len(book)


# In[129]:

for i in range(length):
    tempkey=list(book[i].keys())
    tempvalue=list(book[i].values())
    tempsent=[]
    k=len(tempkey)
    for j in range(k):
        temps=data_clean(tempkey[j])
        temps=temps.upper()
        temps=temps.split()
        tempsent.append(senten_senti(temps))

data2007=list([tempkey,tempvalue,tempsent])


# In[136]:

f=open("data2008.json","r")
book=json.load(f)
length=len(book)

for i in range(length):
    tempkey=list(book[i].keys())
    tempvalue=list(book[i].values())
    tempsent=[]
    k=len(tempkey)
    for j in range(k):
        temps=data_clean(tempkey[j])
        temps=temps.upper()
        temps=temps.split()
        tempsent.append(senten_senti(temps))

data2008=list([tempkey,tempvalue,tempsent])


# In[141]:

f=open("data2009.json","r")
book=json.load(f)
length=len(book)

for i in range(length):
    tempkey=list(book[i].keys())
    tempvalue=list(book[i].values())
    tempsent=[]
    k=len(tempkey)
    for j in range(k):
        temps=data_clean(tempkey[j])
        temps=temps.upper()
        temps=temps.split()
        tempsent.append(senten_senti(temps))

data2009=list([tempkey,tempvalue,tempsent])


# In[143]:

f=open("data2010.json","r")
book=json.load(f)
length=len(book)

for i in range(length):
    tempkey=list(book[i].keys())
    tempvalue=list(book[i].values())
    tempsent=[]
    k=len(tempkey)
    for j in range(k):
        temps=data_clean(tempkey[j])
        temps=temps.upper()
        temps=temps.split()
        tempsent.append(senten_senti(temps))

data2010=list([tempkey,tempvalue,tempsent])


# In[149]:

f=open("data2011.json","r")
book=json.load(f)
length=len(book)

for i in range(length):
    tempkey=list(book[i].keys())
    tempvalue=list(book[i].values())
    tempsent=[]
    k=len(tempkey)
    for j in range(k):
        temps=data_clean(tempkey[j])
        temps=temps.upper()
        temps=temps.split()
        tempsent.append(senten_senti(temps))

data2011=list([tempkey,tempvalue,tempsent])


# In[151]:

f=open("data2012.json","r")
book=json.load(f)
length=len(book)

for i in range(length):
    tempkey=list(book[i].keys())
    tempvalue=list(book[i].values())
    tempsent=[]
    k=len(tempkey)
    for j in range(k):
        temps=data_clean(tempkey[j])
        temps=temps.upper()
        temps=temps.split()
        tempsent.append(senten_senti(temps))

data2012=list([tempkey,tempvalue,tempsent])


# In[152]:

f=open("data2013.json","r")
book=json.load(f)
length=len(book)

for i in range(length):
    tempkey=list(book[i].keys())
    tempvalue=list(book[i].values())
    tempsent=[]
    k=len(tempkey)
    for j in range(k):
        temps=data_clean(tempkey[j])
        temps=temps.upper()
        temps=temps.split()
        tempsent.append(senten_senti(temps))

data2013=list([tempkey,tempvalue,tempsent])


# In[155]:

f=open("data2014.json","r")
book=json.load(f)
length=len(book)

for i in range(length):
    tempkey=list(book[i].keys())
    tempvalue=list(book[i].values())
    tempsent=[]
    k=len(tempkey)
    for j in range(k):
        temps=data_clean(tempkey[j])
        temps=temps.upper()
        temps=temps.split()
        tempsent.append(senten_senti(temps))

data2014=list([tempkey,tempvalue,tempsent])


# In[157]:

f=open("data2015.json","r")
book=json.load(f)
length=len(book)

for i in range(length):
    tempkey=list(book[i].keys())
    tempvalue=list(book[i].values())
    tempsent=[]
    k=len(tempkey)
    for j in range(k):
        temps=data_clean(tempkey[j])
        temps=temps.upper()
        temps=temps.split()
        tempsent.append(senten_senti(temps))

data2015=list([tempkey,tempvalue,tempsent])


# In[159]:

f=open("data2016.json","r")
book=json.load(f)
length=len(book)

for i in range(length):
    tempkey=list(book[i].keys())
    tempvalue=list(book[i].values())
    tempsent=[]
    k=len(tempkey)
    for j in range(k):
        temps=data_clean(tempkey[j])
        temps=temps.upper()
        temps=temps.split()
        tempsent.append(senten_senti(temps))

data2016=list([tempkey,tempvalue,tempsent])


# In[161]:

f=open("data2017.json","r")
book=json.load(f)
length=len(book)

for i in range(length):
    tempkey=list(book[i].keys())
    tempvalue=list(book[i].values())
    tempsent=[]
    k=len(tempkey)
    for j in range(k):
        temps=data_clean(tempkey[j])
        temps=temps.upper()
        temps=temps.split()
        tempsent.append(senten_senti(temps))

data2017=list([tempkey,tempvalue,tempsent])


# In[179]:

#####Plot Part
import matplotlib.pyplot as plt


joint_sent=data2007[2]+data2008[2]+data2009[2]+data2010[2]+data2011[2]+data2012[2]+data2013[2]+data2014[2]+data2015[2]+data2016[2]+data2017[2]
plt.hist(joint_sent,bins=20,range=[-0.3,0.3])
plt.show()


# In[217]:

nonz=[]
k=np.nonzero(joint_sent)[0]
lenk=len(k)
for i in range(lenk):
    nonz.append(joint_sent[k[i]])
plt.hist(nonz,bins=20,range=[-0.4,0.4])
plt.show()


# In[268]:


def plott(k):
    y=k[0]
    y=y/sum(y)
    xtemp=k[1]
    x=[]
    for i in range(1,len(xtemp)):
        x.append((xtemp[i]+xtemp[i-1]+0.0)/2.0)
    ##plt.plot(x,y)
    ##plt.show()
    ##xnew = np.linspace(min(x),max(x),300) #300 represents number of points to make between T.min and T.max
    ##y_smooth = spline(x,y,xnew)
    
    
    return x,y


# In[269]:

from scipy.interpolate import spline
import matplotlib

x1,y1=plott(np.histogram(data2007[2]+data2008[2]+data2009[2]))

x3,y3=plott(np.histogram(data2011[2]+data2010[2]+data2012[2]))



x7,y7=plott(np.histogram(data2013[2]+data2014[2]+data2015[2]))

x9,y9=plott(np.histogram(data2017[2]+data2016[2]))


plt.plot(x1,y1,label="2007+2008+2009")

plt.plot(x3,y3,label="2010+2011+2012")

plt.plot(x7,y7,label="2013+2014+2015")

plt.plot(x9,y9,label="2016+2017")

plt.legend()
plt.show()


# In[213]:

k=list(np.nonzero(joint_sent)[0])


# In[215]:

joint_sent[k]


# In[ ]:



