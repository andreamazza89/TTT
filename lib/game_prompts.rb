GAME_PROMPTS = {
  welcome: "Welcome to TicTacToe!!",
  ask_for_next_move: ", it's your turn, have a look at the board and pick a move:\n",
  board_header: "\n  1 | 2 | 3 \n",
  board_horizontal_spacer: "  ----------\n",
  announce_draw: "It was a draw!\n",
  announce_winner: "Game over: the winner was...\n",
  game_mode_selection: "Please select a game mode: 1-Human v Human, 2-Human v PC, 3-PC v PC",
  invalid_game_mode_selection: "Invalid selection, please enter '1' '2' or '3': 1-Human v Human, 2-Human v PC, 3-PC v PC",
  play_order_selection: "Would you like to swap who goes first? (y/Y)",
  vertical_cell_separator: "|",
  illegal_move: "Cannot make move: invalid input" ,
  cell_already_taken: "Cannot make move: cell already taken",
  please_try_again: "Please try again: "
}

NUMBER_TO_LETTER = {
  0 => 'A',
  1 => 'B',
  2 => 'C',
}

LETTER_TO_NUMBER = {
  'A' => NUMBER_TO_LETTER.key('A'),
  'B' => NUMBER_TO_LETTER.key('B'),
  'C' => NUMBER_TO_LETTER.key('C'),
}
