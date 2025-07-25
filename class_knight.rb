require 'ruby2d'

class Knight
  attr_reader :sprite
  attr_accessor :current_tile

  def initialize
    @sprite = Sprite.new(
      'img/knight.png',
      x: 0, y: 0,
      width: 64,
      height: 64,
      clip_width: 64
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
    if @current_tile.cords[0]+2 == cords[0] && @current_tile.cords[1]+1 == cords[1]
      return true
    elsif @current_tile.cords[0]+2 == cords[0] && @current_tile.cords[1]-1 == cords[1]
      return true
    elsif @current_tile.cords[0]+1 == cords[0] && @current_tile.cords[1]+2 == cords[1]
      return true
    elsif @current_tile.cords[0]+1 == cords[0] && @current_tile.cords[1]-2 == cords[1]
      return true
    elsif @current_tile.cords[0]-2  == cords[0] && @current_tile.cords[1]+1 == cords[1]
      return true
    elsif @current_tile.cords[0]-2 == cords[0] && @current_tile.cords[1]-1 == cords[1]
      return true
    elsif @current_tile.cords[0]-1 == cords[0] && @current_tile.cords[1]+2 == cords[1]
      return true
    elsif @current_tile.cords[0]-1 == cords[0] && @current_tile.cords[1]-2 == cords[1]
      return true

    else 
      p "current move #{cords} from #{@current_tile.cords} is not legal"
      return false 
    end
  end

  def move_legal2?(cords)
    current_cords = @current_tile.cords
    dx = (current_cords[0] - cords[0]).abs
    dy = (current_cords[1] - cords[1]).abs

    [dx, dy].sort == [1, 2]
  end

end
