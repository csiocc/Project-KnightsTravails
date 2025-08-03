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

path_lines = []

on :key_down do |event|
  # Read the key event
  case event.key
  when 'escape'
    p 'exiting'
    close
  end
end

on :mouse_down do |event|
  # clear old lines
  path_lines.each(&:remove)
  path_lines.clear

  # x and y coordinates of the mouse button event
  cords = { x: event.x, y: event.y }

  target_tile = test.find_tile(cords)

  # next if no tile clicked or the same as start
  next unless target_tile && target_tile != knight.current_tile

  start_tile = knight.current_tile
  tile_size = test.tile_size
  center_offset = tile_size / 2

  # helper function to draw a line
  draw_line = lambda do |from_tile, to_tile, color|
    start_px = from_tile.draw_cords
    end_px = to_tile.draw_cords

    start = { x: start_px[:x] + center_offset, y: start_px[:y] + center_offset }
    end_center = { x: end_px[:x] + center_offset, y: end_px[:y] + center_offset }

    dr = to_tile.cords[0] - from_tile.cords[0]
    dc = to_tile.cords[1] - from_tile.cords[1]

    corner = if dr.abs > dc.abs # vertikal
               { x: start[:x], y: end_center[:y] }
             else #  horizontal
               { x: end_center[:x], y: start[:y] }
             end

    path_lines << Line.new(
      x1: start[:x], y1: start[:y], x2: corner[:x], y2: corner[:y],
      width: 3, color: color, z: 10
    )
    path_lines << Line.new(
      x1: corner[:x], y1: corner[:y], x2: end_center[:x], y2: end_center[:y],
      width: 3, color: color, z: 10
    )
  end

  if knight.move_legal?(target_tile.cords)
    draw_line.call(start_tile, target_tile, 'red')
    knight.move(target_tile)
    p "Moved to #{target_tile.cords} in 1 move"
  else
    path = knight.find_path(target_tile, test)
    if path
      p "Path found in #{path.length - 1} moves:"
      path.each { |tile| p " -> #{tile.cords}" }
      path.each_cons(2) do |from_tile, to_tile|
        draw_line.call(from_tile, to_tile, 'lime')
      end
      knight.move(target_tile) # Move the knight to the target
    else
      p 'No path found'
    end
  end
end

show
