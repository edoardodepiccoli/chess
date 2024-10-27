# CLI Chess Game ♟️

This is a command-line chess game I built in Ruby as the final project for the Ruby section of [The Odin Project](https://theodinproject.com). Coding this was no joke – it took me three full rewrites to get it where it is now. But the challenge was worth it! I feel like I've leveled up my Ruby and object-oriented programming (OOP) skills, and I’m pretty proud of the result.

### Disclaimer 🙃
I know the code isn’t perfect. It could use some serious refactoring, and my choice to use algebraic coordinates everywhere (instead of decimals) made some parts of the code cluttered. Still, this project feels like a big milestone, and it’s just the beginning of my OOP journey!

### Features (In Progress) 🚧

This version of the game is nearly complete, but there are a few features left to implement:
- [ ] **En passant**
- [ ] **Castling**
- [ ] **Pawn promotion** (retrieving pieces when a pawn reaches the opposite side)
- [ ] **Save & Load Game** (serialization)

### Planned Improvements 📌
Here’s what I’d like to add and refine as I continue improving the project:
- [ ] Clean up code by removing the many ChessHelper module calls
- [ ] Refactor code to be cleaner and less redundant
- [ ] Improve user feedback for a more polished experience

**Thoughts on Upcoming Features:**
- **En passant** and **castling**: I’m planning to add a state tracker for the king and rooks to manage castling, plus some checks in the board class to ensure a clear path. For en passant, I’ll need to track the last piece moved and handle pawn captures specifically.
- **Pawn promotion** should be simple, but I’ll need to track each player's lost pieces to handle this fully.
- **Serialization**: Should be straightforward, though I need to brush up a bit on the technique.
- **Stalemate**

I estimate these improvements should take around 10 hours (not including the full refactor).

### What I Learned 📖
This project was packed with lessons. Here are my top takeaways:
- **Chess is complicated!** Planning before coding is essential. I learned this the hard way after two false starts.
- **Testing saves time**. I’m still learning to test effectively, but I see now how much easier it makes the development process.
- **Break down large methods**. Smaller methods are a lifesaver for reuse and readability.

### How to Play 🎮
1. Clone the repo and navigate to the `lib` folder.
2. Run `ruby main.rb` to start the game.

