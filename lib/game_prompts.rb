GAME_PROMPTS = {
  ask_for_next_move: ", it's your turn, have a look at the board and pick a move:",
  board_header: "  1 | 2 | 3 \n",
  board_horizontal_spacer: "  ----------\n",
  announce_draw: "It was a draw!\n",
  game_mode_selection: "Please select a game mode: 1-Human v Human, 2-Human v PC, 3-PC v PC",
  play_order_selection: "Would you like to swap the playing order?"
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
