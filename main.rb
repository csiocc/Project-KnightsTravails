require_relative 'class_tile'
require_relative 'class_drawboard'
require_relative 'class_board'
require_relative 'class_knight'
require_relative 'config'
require 'ruby2d'
system 'clear'

test = Board.new

test.setup(Config::TILE_COUNT)

DrawBoard.new(test.white_positions, test.black_positions, test.side_length)

set title: 'Knights Travails press ESC to exit'
set width: Config::WINDOW_SIZE
set height: Config::WINDOW_SIZE
# tileset = window.tileset

knight = Knight.new(test.tile_size)
knight.current_tile = test.topleft

on :key_down do |event|
  # Read the key event
  case event.key
  when 'escape'
    p 'exiting'
    close
  end
end

on :mouse_down do |event|
  # x and y coordinates of the mouse button event
  cords = { x: event.x, y: event.y }

  target_tile = test.find_tile(cords)
  if knight.move_legal?(target_tile.cords)
    knight.move(target_tile)
    p "Moved to #{target_tile.cords} in 1 move"
  else
    path = knight.find_path(target_tile, test)
    if path
      path.each { |tile| p tile.cords }
      p "Path found in #{path.length} moves:"
      knight.move(target_tile) # Move the knight to the target
    else
      p 'No path found'
    end
  end
end

show
