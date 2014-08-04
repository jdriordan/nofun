#!/usr/bin/env python 

from os import listdir

from scipy.misc.pilutil import imread

from sklearn import svm
from sklearn.externals import joblib
from sklearn.datasets.base import Bunch

bot = svm.SVC()

data_dir = "data/"

samples=[(target,
		  imread(data_dir + target + "/" + filename).flatten()) 
		  for target   in listdir(data_dir) # beware .DS_store 
		  for filename in listdir(data_dir+target)]

inputs,images = zip(*samples)
# dataset = Bunch(data=images,targets=inputs)


bot.fit(images,inputs)	

joblib.dump(bot,"bot/bot.pkl")

