#! /usr/bin/env python

import os

os.system("./simplify.sh temp_frame.png do_frame.png")


from sklearn.externals import joblib
from scipy.misc.pilutil import imread

bot = joblib.load("bot/bot.pkl")

sample = imread("do_frame.png").flatten()

print bot.predict(sample)[0]
print "duped!" 
