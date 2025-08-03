# frozen_string_literal: true

require 'ruby2d'

### knight class and functions to move, and path finding###
class Knight
  attr_reader :sprite
  attr_accessor :current_tile

  POSSIBLE_MOVES = [
    [1, 2], [1, -2], [-1, 2], [-1, -2],
    [2, 1], [2, -1], [-2, 1], [-2, -1]
  ].freeze

  def initialize(tile_size)
    @sprite = Sprite.new(
      'img/knight.png',
      x: 0, y: 0,
      width: tile_size,
      height: tile_size
    )
    @current_tile = nil
  end

  def move(input)
    cords = input.draw_cords
    @sprite.x = cords[:x]
    @sprite.y = cords[:y]
    @current_tile = input
  end

  def move_legal?(cords)
    current_cords = @current_tile.cords
    dx = (current_cords[0] - cords[0]).abs
    dy = (current_cords[1] - cords[1]).abs
    [dx, dy].sort == [1, 2]
  end

  def find_path(target_tile, board)
    start_tile = @current_tile
    # que for path tiles
    queue = [[start_tile]]
    # keep track of visited tiles
    visited = { start_tile => true }
    # breadth-first search (BFS)
    while queue.any?
      current_path = queue.shift
      last_tile = current_path.last
      # return if target found
      return current_path if last_tile == target_tile

      # find possible moves from the last tile stored in queue
      current_cords = last_tile.cords
      POSSIBLE_MOVES.each do |move|
        next_cords = [current_cords[0] + move[0], current_cords[1] + move[1]]
        next_tile = board.get_tile(next_cords)

        # if valid move and not visited
        if next_tile && !visited[next_tile]
          visited[next_tile] = true
          queue.push(current_path + [next_tile])
        end
      end
    end
  end
end
