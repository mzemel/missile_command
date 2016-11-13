class Bunker
  attr_reader :ammo, :key, :destroyed, :level, :damage

  WIDTH = 50
  HEIGHT = 40
  OFFSET = 10
  HEALTH_COLOR = Gosu::Color.argb(0xff_ffff00)

  def initialize(level:, key:, ammo:, x:, health:)
    @key       = key
    @level     = level
    @ammo      = Ammo.new(count: ammo)
    @x         = x
    @health    = health
    @damage    = 0
    @img_alive     = Gosu::Image.new("assets/bunker.png")
    @img_destroyed = Gosu::Image.new("assets/bunker_busted.png")
    @aud_launch    = Gosu::Sample.new("assets/launch.wav")
    @text      = Gosu::Font.new(20)
    @destroyed = false
  end

  def update
    fire if Utility.send("#{key}_button?")
  end

  def draw
    image = @destroyed ? @img_destroyed : @img_alive 
    image.draw(*top_left, Utility::ZIndex::BUNKER)
    @text.draw(ammo.text, *text_top_left, Utility::ZIndex::BUNKER, 1.0, 1.0, 0xff_ffff00)
    draw_health_bar
  end


  def top_left
    @top_left ||= [
      @x - WIDTH/2,
      MissileCommand::HEIGHT - BackgroundImage::GROUND_HEIGHT - HEIGHT + OFFSET
    ]
  end

  def bottom_right
    @bottom_right ||= [
      @x + WIDTH/2,
      MissileCommand::HEIGHT - BackgroundImage::GROUND_HEIGHT + OFFSET
    ]
  end

  def damage!(projectile)
    @damage += projectile.damage_value
    if damage >= health
      destroy
    end
  end

  def destroy
    @destroyed = true
    ammo.deplete
  end

  private

  def health
    @_health  ||= case @health
                  when "medium"
                    5
                  when "high"
                    10
                  else
                    1
                  end
  end

  def draw_health_bar
    return if health == 1
    health_percent = 1.0 - damage.to_f / health
    bar_length = WIDTH * health_percent
    Gosu.draw_line(
      top_left[0], top_left[1] - 4,
      HEALTH_COLOR,
      top_left[0] + bar_length, top_left[1] - 4,
      HEALTH_COLOR,
      Utility::ZIndex::HEALTH_BAR,
      :default
      )
  end

  def text_top_left
    [
      top_left[0],
      bottom_right[1] + 10
    ]
  end

  def fire
    return if Utility::Cooldown.on? || ammo.empty?
    ammo.decrement
    level.register_bullet Bullet.new(
      x: top_left[0] + WIDTH / 2,
      y: top_left[1],
      x_end: level.game.cursor.x,
      y_end: level.game.cursor.y,
      level: level,
      launcher: self
    )
    @aud_launch.play
    Utility::Cooldown.set
  end
end