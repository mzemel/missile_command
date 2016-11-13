class Defender
  attr_reader :x, :y, :speed, :mode, :weapons, :level, :ammo

  WIDTH = 30
  HEIGHT = 15

  def initialize(x:, y:, mode:, weapons:, ammo:, level:)
    @x    = x
    @y    = y
    @mode = mode
    @weapons = weapons
    @level   = level
    @direction = [:left, :right].sample
    @ammo      = Ammo.new(count: ammo)
    @image = Gosu::Image.new("assets/defender.png")
  end

  def update
    if @direction == :left && x == 0
      @direction = :right
    elsif @direction == :right && x == MissileCommand::WIDTH
      @direction = :left
    end
    move
    fire
  end

  def draw
    @image.draw(x, y, Utility::ZIndex::DEFENDER)
  end

  def top_left
    [x, y]
  end

  def bottom_right
    [x + WIDTH, y + HEIGHT]
  end

  def speed
    @speed  ||= case mode
                when "easy"
                  1
                when "medium"
                  rand(3) + 1
                when "hard"
                  rand(5) + 1
                else
                  Utility::SPACESHIP_SPEED
                end
  end

  private

  def move
    @x = if @direction == :left
      [x - speed, 0].max
    else
      [x + speed, MissileCommand::WIDTH].min
    end
  end

  def fire
    ammo.decrement
    if rand(Utility::FIRE_PROBABILITY[weapons]) == 0
      level.register_bullet Bullet.new(
        x: x,
        y: y,
        x_end: rand(MissileCommand::WIDTH),
        y_end: rand(BackgroundImage::GROUND_HEIGHT),
        level: level,
        launcher: self
      )
    end
  end
end