# Tic Tac Toe [![Build Status](https://travis-ci.org/andreamazza89/TTT.svg?branch=master)](https://travis-ci.org/andreamazza89/TTT) [![Coverage Status](https://coveralls.io/repos/github/andreamazza89/TTT/badge.svg?branch=master)](https://coveralls.io/github/andreamazza89/TTT?branch=master)

![screenshot](https://github.com/andreamazza89/TTT/blob/master/screenshot/Screen%20Shot%202016-10-30%20at%2010.47.19.png)

A simple implementation of the TicTacToe game, written in Ruby. Currently 
implemented to be played on the console, but can be extended to use other types 
of IO (e.g. you could use it to play the game via SMS!).

### Setup

Prerequisites:

- Ruby-lang version 2.3.0 (recommended install via [rvm](https://rvm.io/rvm/install))
- [Bundler](http://bundler.io/)

From the command line:

- Clone this repo ```git clone https://github.com/andreamazza89/TTT.git```
- Move into it ```cd TTT```
- Run bundle ```bundle```
- Run the tests to check it is all working ```rspec```
- Start the game and have fun! ```ruby console_game_runner.rb```

### Rationale

A few pointers on the current design:

- The CpuPlayer class uses the [minimax algorithm](https://en.wikipedia.org/wiki/Minimax) 
to evaluate the best possible move to make. This also takes depth into account 
so that for two moves with the same final outcome, one that takes fewer steps to 
achieve gets a higher score. The main limitation of this algorithm is the number 
of processes involved, as it goes through every possible scenario for every move 
available on the board. For an empty board (9 moves available), this equates to 
going through 9! (362880) scenarios. The first measure to overcome this, is to 
simply use a brute force approach when there are 9 options available and simply 
return a corner move (this gives the opponent most chances to make a mistake 
according to [this] (https://en.wikipedia.org/wiki/Tic-tac-toe#Strategy)). The 
next step in improving the efficiency of the algorithm would be to add 
[alpha-beta pruning](https://en.wikipedia.org/wiki/Alpha%E2%80%93beta_pruning). 
This is not used in the current implementation.
- There is a common abstraction for Human and Cpu players, as these have the same 
public interface and are effectively a 'Player' duck type. The _name_ and _flag_ 
attribute readers have the exact same behaviour for the two classes, so that a 
potential improvement could be to create a superclass that the two inherit from. 
This however seems overkill at this point as the crossover between the two is so 
small and it feels safer to leave the small repetition in behaviour, to be 
extracted -if needed- in the future, when and if a superclass makes itself more evident.
- Currently the Board class and utility classes for it (BoardPrinter, BoardEvaluator) 
are arranged in a _horizontal_ manner. In other words, an instance of the board 
class is passed to, say, the BoardEvaluator class to call ```#empty?```. A 
different arrangement of these classes could be more _vertical_, whereby all 
messages are sent to the Board class, who then delegates onto BoardPrinter, 
BoardEvaluator, etc.. This approach has the advantage of a cleaner interface 
from the point of view of the user, so that method calls such as 
```BoardEvaluator.empty?(board)``` become ```board.empty?```; this would also 
mean that the user of these methods would need to know less to achieve the same 
result. However, I have not made the transition from one arrangement to the other. 
This can easily be achieved in the future if further requirements or information 
make it more evident that the approach is best.
