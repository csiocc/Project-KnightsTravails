require 'ruby2d'
require_relative 'config'

### Draw Board Class drawing the Board on the screen ###
class DrawBoard
  attr_accessor :white_positions, :black_positions, :knight

  def initialize(white, black, side_length = 8)
    @white_positions = white
    @black_positions = black
    @side_length = side_length
    draw_board
  end

  def draw_board
    tile_size = Config::WINDOW_SIZE / @side_length
    @white_positions.each do |pos|
      Square.new(x: pos[:x], y: pos[:y], size: tile_size, color: 'white')
    end
    @black_positions.each do |pos|
      Square.new(x: pos[:x], y: pos[:y], size: tile_size, color: 'black')
    end
  end
end
