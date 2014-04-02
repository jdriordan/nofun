`nofun` - の糞
====

About
----

This is a simple Lua script which plays (the original) Super Mario Brothers on the NES. It could in theory play other similar games, but at least for the moment it relies on hardcoded memory values and even specific heuristic behaviour. The latter should be fixable (at the cost of speed) but the former is a harder problem. 


Goal
----

The project was inspired by [`tom7`'s `playfun` and `learnfun`][1]. This approach differs in that `playfun` plays like one might imagine a child plays; watching, learning and trying, while `nofun` plays as an actual child plays i.e. holding `B` and `right` and tapping `A` frantically.


Status
----

`nofun`'s furthest level so far is: ## 3-2

There are several hardcoded conditions which try to guess whether the code should either wait longer, or kill Mario pre-emptively but they could be removed. 

Additionally here are numerous problems with the code, logically and stylistically,

[1]: http://www.cs.cmu.edu/~tom7/mario/
