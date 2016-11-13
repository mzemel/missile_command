module Enemy
  class Spaceship
    attr_reader :x, :y, :speed, :mode, :weapons, :delay, :level

    WIDTH = 30
    HEIGHT = 15

    def initialize(x:, y:, mode:, weapons:, delay:, level:)
      @x    = x
      @y    = y
      @mode = mode
      @weapons = weapons
      @delay   = delay
      @level   = level
      @direction = [:left, :right].sample
      @image = Gosu::Image.new("assets/spaceship.png")
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
      @image.draw(x, y, Utility::ZIndex::SPACESHIP)
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
      if rand(Utility::SPACESHIP_FIRE_PROBABILITY[weapons]) == 0
        level.register_missile Enemy::Missile.new(
          x: x,
          y: y,
          x_end: rand(MissileCommand::WIDTH),
          y_end: MissileCommand::HEIGHT - BackgroundImage::GROUND_HEIGHT,
          level: level
        )
      end
    end
  end
end