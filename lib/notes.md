checks on the start position:
check if board boundaries are ok (done)
check if the selected piece exists (done)
check if the selected piece is the right color (done)

checks on the end position:
check if end position is outside of boundaries (done)
check if end position is same color piece (done)
check if the end position is in the legal move set of the selected piece => hard part, should be taken car for each piece (*)
check for obstructions
	check if sliding pieces have something blocking the path (see *)
	check if pawn has something in front of it blocking the path (see *)
check if, in case of capturing, the piece captured is of the opposite color (see *)
check, if pawn, if it is the fist move (see *)
check for en passant conditions
check for pawn promotion
check for castling (see better this part)
check if the move leaves the king in check or, if making the move puts the king in check
after validating the move, check if opponent is in checkmate
see more about stalemate conditions