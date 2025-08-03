# frozen_string_literal: true

### tiles on the board ###
class Tile
  attr_accessor :left, :right, :top, :bot, :cords, :draw_cords

  def initialize
    @cords = nil
    @top = nil
    @bot = nil
    @left = nil
    @right = nil
    @draw_cords = { x: 0, y: 0 }
  end
end
