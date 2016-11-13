module Enemy
  class Spaceship

    def self.factory(n = 1)
      n.times.collect do
        Spaceship.new(
          x: rand(MissileCommand::WIDTH), 
          y: rand(MissileCommand::HEIGHT / 4),
          mode: :easy
        )
      end
    end

    attr_reader :x, :y, :speed, :mode, :weapons, :delay

    WIDTH = 30
    HEIGHT = 15

    def initialize(x:, y:, mode:, weapons:, delay:)
      @x    = x
      @y    = y
      @mode = mode
      @weapons = weapons
      @delay   = delay
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
  end
end