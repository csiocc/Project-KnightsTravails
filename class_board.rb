require_relative 'class_tile'
require 'ruby2d'


class Board
  attr_accessor :topleft, :tiles, :white_positions, :black_positions

  def initialize
    @topleft = nil
    @tiles = []
    @white_positions = []
    @black_positions = []
  end

  ### Setup Board ###
  def setup(num, current = @topleft)
    get_cords = lambda do |num|
      side_length = Math.sqrt(num)
      return side_length.to_i if side_length == side_length.to_i

      raise 'Error: invalid input'
    end
    side_length = get_cords.call(num)

    grid = Array.new(side_length) { Array.new(side_length) }
    (0...side_length).each do |row| # #Tiles erstellen und Cords festlegen
      (0...side_length).each do |col|
        tile = Tile.new
        tile.cords = [row, col]
        grid[row][col] = tile
        @tiles << tile
      end
    end

    (0...side_length).each do |row| # #Tiles verlinken
      (0...side_length).each do |col|
        tile = grid[row][col]
        tile.top = grid[row - 1][col] if row > 0
        tile.bot = grid[row + 1][col] if row < side_length - 1
        tile.left = grid[row][col - 1] if col > 0
        tile.right = grid[row][col + 1] if col < side_length - 1
      end
    end

    side_length.times do |row| ## Tile draw_cords festlegen
      side_length.times do |col|
        x = col * 64
        y = row * 64
        grid[row][col].draw_cords = { x: x, y: y }
        if (row + col).even?
          @white_positions << { x: x, y: y }
        else
          @black_positions << { x: x, y: y }
        end
      end
    end
    p "setup done with #{white_positions.length} white tiles and #{black_positions.length} black tiles"
    @topleft = grid[0][0]
  end

  def find_tile(cords)
    @tiles.each do |tile|
      if tile.draw_cords[:x] < cords[:x] && tile.draw_cords[:x]+64 > cords[:x] && tile.draw_cords[:y] < cords[:y] && tile.draw_cords[:y]+64 > cords[:y]
        return tile
      end
    end
  end

  def print_board(top_left = @topleft)
    start = top_left
    while start
      current = start
      while current
        print current.cords.to_s.ljust(8)
        current = current.right
      end
      puts
      start = start.bot
    end
  end

  def print_tiles
    @tiles.each do |tile|
      puts tile.draw_cords
    end
  end

  def show_white_positions
    @white_positions.each do |tile|
      puts tile.draw_cords
    end
  end

  def show_black_positions
    @black_positions.each do |tile|
      puts tile.draw_cords
    end
  end 

end
