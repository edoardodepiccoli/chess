# chess

## main challenges
- ui part, selecting the pieces and keeping track of the action to be performed
- keeping track of the current available moves a player can chose and let him choose accordingly

the game is played like this:
- board is displayed, every square has the same width and height. pieces are displayed on top of the black or white square
- one square is highlighted a different color: it is the currently selected square. the player can use their arrows to go up, down, right or left to change the current selected square. the player can select one of the square with their piece in it pressing a key, then the available moves get displayed by slightly changing the colors of the available move's squares. the player can press again on the same piece to unselect it. once selected, the player can move the selected square to a valid square and then press the same key again to move the piece.

checks should be made to be sure that

while choosing the piece to move
- the player is not going out of bounds
- the player is selecting its own piece and not an opponents piece or a blank square (there should be a way to check all the possible squares a player can select once they enter the select mode)

while choosing the move to make
- the player is not selecting the current position (otherwise revert the piece choice)
- the player is selecting one of the valid squares provided by the piece (there should be a way to check all the different possible squares a piece can be moved on once selected)

with this, add checkmate constraints
- add the option to see if the king is in danger
- find a way to remove moves that put the king in danger
- find a way to make only the moves that put the king out of danger available when king is in danger



---



no crazy ui part, just use letter + number combo to select the piece and to move it
for example
a1 f5

create a Piece class
create specialized classes that extends Piece

fill the board with the right pieces
this is to do the calculations about the valid moves inside the piece class and not the board (maybe good maybe bad idk), maybe use the piece class to get all the possible moves, and then use the board class to get the actually available ones, something like that, just to lighten the load for the board class and allow for future expansions

so workflow is
user gets selected: white or black
user chooses a move -> 

this is the hard part:
basically checking for threaths to the king, then choosing all the available selectable pieces (so only the pieces that have a move that sets possible_checkmate to false (one option could be simulating all the moves and seeing the valid ones but this is very computer intensive)


make the move 
switch turn




recap:
create game with two players and a board
initialize the board with all the pieces (separate classes)
select player and check for available moves
	if the king is in danger
		available moves = moves that would set the property king_in_danger to false
	else 
		available moves = all the moves from the current player's piece except the ones that would set the property king_in_danger to true
make the move
	if checkmate
		currenty player wins
	else swtich turn, continue

every player should have
- a color property

every piece should have
- a name property
- a color property
- a function like possible_moves(current_index) that returns an array with all the possible indexes where it could move if nothing was there (in range 0..63 of course)







