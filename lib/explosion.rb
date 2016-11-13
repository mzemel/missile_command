class Explosion
  attr_reader :x, :y, :top_left, :bottom_right, :level, :bullet

  COLOR = Gosu::Color.argb(0xff_ffff00)

  def initialize(x:, y:, level:, bullet:)
    @x = x
    @y = y
    @top_left     = [x, y]
    @bottom_right = [x, y]
    @level         = level
    @decreasing   = false
    @img_explosion = Gosu::Image.new("assets/explosion.png")
    @bullet = bullet
    Gosu::Sample.new("assets/explosion.mp3").play
  end

  # Explosion starts increasing, then decreases until a 2x2 square and disappears
  def update
    if width > Utility::EXPLOSION_SPEED * 30 || height > Utility::EXPLOSION_SPEED * 30
      @decreasing = true
      decrease
    elsif @decreasing && (width > 2 && height > 2)
      decrease
    elsif @decreasing
      level.remove_explosion(self)
    else
      increase
    end
  end

  def draw
    @img_explosion.draw(*top_left, Utility::ZIndex::EXPLOSION, width / 50.0, height / 50.0 )
    # Utility::Debug.trace(self)
    # Gosu.draw_rect(*top_left, width, height, COLOR, Utility::ZIndex::EXPLOSION)
  end

  private

  def increase
    @top_left[0] = [top_left[0] - Utility::EXPLOSION_SPEED, 0].max
    @top_left[1] = [top_left[1] - Utility::EXPLOSION_SPEED, 0].max

    @bottom_right[0] = [bottom_right[0] + Utility::EXPLOSION_SPEED, MissileCommand::WIDTH].min
    @bottom_right[1] = [bottom_right[1] + Utility::EXPLOSION_SPEED, MissileCommand::HEIGHT].min
  end

  def decrease
    @top_left[0] = [top_left[0] + Utility::EXPLOSION_SPEED, x].min
    @top_left[1] = [top_left[1] + Utility::EXPLOSION_SPEED, y].min

    @bottom_right[0] = [bottom_right[0] - Utility::EXPLOSION_SPEED, x].max
    @bottom_right[1] = [bottom_right[1] - Utility::EXPLOSION_SPEED, y].max
  end

  def width
    (bottom_right[0] - top_left[0]).abs
  end

  def height
    (bottom_right[1] - top_left[1]).abs
  end
end


