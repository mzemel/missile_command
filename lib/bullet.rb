class Bullet
  attr_reader :image, :x, :y, :x_end, :y_end, :game

  def initialize( x:, y:, x_end:, y_end:, game:)
    @image = Gosu::Image.new("assets/bullet.png")
    @x     = x
    @y     = y
    @x_end = x_end
    @y_end = y_end
    @game  = game
  end

  def update
    if arrived?
      game.remove_bullet(self)
      game.register_explosion(x: x.floor, y: y.floor)
    else
      move_bullet
    end
  end

  def draw
    image.draw(x, y, Utility::ZIndex::BULLET)
  end

  def arrived?
    (x_end.floor - x.floor).abs <= Utility::BULLET_PROXIMITY &&
      (y_end.floor - y.floor).abs <= Utility::BULLET_PROXIMITY
  end

  private

  def move_bullet
    hypotenuse = Math.sqrt((x - x_end)**2 + (y - y_end)**2)

    x_per_frame = ((x - x_end).abs / hypotenuse) * Utility::BULLET_SPEED
    y_per_frame = ((y - y_end).abs / hypotenuse) * Utility::BULLET_SPEED

    if x > x_end
      @x = (x - x_per_frame)
    elsif x < x_end
      @x = (x + x_per_frame)
    else
      # do nothing
    end

    if y > y_end
      @y = (y - y_per_frame)
    elsif y < y_end
      @y = (y + y_per_frame)
    else
      # do nothing
    end
  end
end