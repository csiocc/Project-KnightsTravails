require 'ruby2d'
class DrawBoard
  attr_accessor :white_positions, :black_positions, :tileset, :knight

  def initialize(white, black)
    @white_positions = white
    @black_positions = black
    @tileset = Tileset.new(
      'img/tiles.png',
      tile_width: 64,
      tile_height: 64
    )
    @tileset.define_tile('white_tile', 1, 1)
    @tileset.define_tile('black_tile', 2, 1)
    @tileset.set_tile('white_tile', @white_positions)
    @tileset.set_tile('black_tile', @black_positions)
    # @knight = Knight.new
    
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
