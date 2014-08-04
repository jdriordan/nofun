#! /usr/bin/env python

from sklearn.externals import joblib
from scipy.misc.pilutil import imread

bot = joblib.load("bot/bot.pkl")

sample = imread("do_frame.png").flatten()

print bot.predict(sample)[0] 
