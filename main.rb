require_relative 'class_tile'
require_relative 'class_drawboard'
require_relative 'class_board'
require_relative 'class_knight'

require 'ruby2d'
system 'clear'

test = Board.new

test.setup(64)

window = DrawBoard.new(test.white_positions, test.black_positions)

set title: "Knights Travails press ESC to exit"
set width: 512
set height: 512
# tileset = window.tileset

knight = Knight.new
knight.current_tile = test.topleft

on :key_down do |event|
  # Read the key event
  case event.key
  when "escape"
    p "exiting"
    close
  end
end

on :mouse_down do |event|
  # x and y coordinates of the mouse button event
  cords = { x: event.x, y: event.y }
  
  move_cords = test.find_tile(cords)
  p knight.move_legal2?(move_cords.cords)
  knight.move(move_cords)
  # Read the button event
  case event.button
  when :left
    # Left mouse button pressed down
  when :middle
    # Middle mouse button pressed down
  when :right
    # Right mouse button pressed down
  end
end

show
