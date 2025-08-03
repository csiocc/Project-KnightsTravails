# frozen_string_literal: true

require_relative 'class_tile'
require 'ruby2d'
require_relative 'config'

### board class storing all tiles and some functions to access them###
class Board
  attr_accessor :topleft, :tiles, :white_positions, :black_positions, :grid
  attr_reader :side_length, :tile_size

  def initialize
    @topleft = nil
    @grid = nil
    @tiles = []
    @white_positions = []
    @black_positions = []
    @side_length = nil
    @tile_size = nil
  end

  ### setup board ###
  def setup(num)
    get_cords = lambda do |num|
      side_length = Math.sqrt(num)
      @side_length = side_length.to_i
      return side_length.to_i if side_length == side_length.to_i

      raise 'Error: invalid input, try 4, 16, 64, 256'
    end
    side_length = get_cords.call(num)
    @tile_size = Config::WINDOW_SIZE / @side_length

    # tiles erstellen und Cords festlegen
    @grid = Array.new(side_length) { Array.new(side_length) }
    (0...side_length).each do |row|
      (0...side_length).each do |col|
        tile = Tile.new
        tile.cords = [row, col]
        @grid[row][col] = tile
        @tiles << tile

        # tiles verlinken
        tile = @grid[row][col]
        tile.top = @grid[row - 1][col] if row.positive?
        tile.bot = @grid[row + 1][col] if row < side_length - 1
        tile.left = @grid[row][col - 1] if col.positive?
        tile.right = @grid[row][col + 1] if col < side_length - 1
      end
    end

    # tile draw_cords festlegen
    side_length.times do |row|
      side_length.times do |col|
        x = col * (Config::WINDOW_SIZE / side_length)
        y = row * (Config::WINDOW_SIZE / side_length)
        @grid[row][col].draw_cords = { x: x, y: y }
        if (row + col).even?
          @white_positions << { x: x, y: y }
        else
          @black_positions << { x: x, y: y }
        end
      end
    end
    p "Setup done with #{white_positions.length} white Tiles and #{black_positions.length} black tiles"
    @topleft = @grid[0][0]
  end

  def get_tile(cords)
    row, col = cords
    return nil if row.nil? || col.nil? || row.negative? || col.negative?

    @grid.dig(row, col)
  end

  def find_tile(cords)
    @tiles.each do |tile|
      if tile.draw_cords[:x] < cords[:x] && tile.draw_cords[:x] + (Config::WINDOW_SIZE / @side_length) > cords[:x] && tile.draw_cords[:y] < cords[:y] && tile.draw_cords[:y] + (Config::WINDOW_SIZE / @side_length) > cords[:y]
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
