`nofun` - の糞
====

About
----

This is a simple Lua script which plays (the original) Super Mario Brothers on the NES. It could in theory play other similar games, but at least for the moment it relies on hardcoded memory values and even specific heuristic behaviour. The latter should be fixable (at the cost of speed) but the former is a harder problem. 

Its original purpose was to see how far a minimal almost-brute-force approach could get in a reasonable amount of time (see the 0.1 release). The answer is level 4-4.

The scope has since been expanded to use the original code to generate learning material for a smarter version.

Goal
----

The project was inspired by [`tom7`'s `playfun` and `learnfun`][1]. This approach differs in that `playfun` plays like one might imagine a child plays; watching, learning and trying, while `nofun` plays as an actual child plays i.e. holding `B` and `right` and tapping `A` frantically.

The current goal is to use this "mindless" approach to generate learning data which is then fed to a machine-learning system (probably scikit learn) which can quickly evaluate input combinations (i.e without actually emulating the NES) in combination with screenshots (rather than memory reads). The advantage of this is that `nofun` should be able to play without savestates and memory access, all things going well it may even manage to play in real-time on a console, but that is rather optimistic.

Status
----

`nofun`'s furthest level so far is: **4-4**  

With regard to machine learning `nofun` is able to write out simplified screenshots along with input attempts, the next step is for it to associate success values with the screenshots and input, giving a complete dataset to train the machine-learner on.


[1]: http://www.cs.cmu.edu/~tom7/mario/
