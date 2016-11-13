module Levels
  class Base

    attr_reader :game, :bullets, :explosions, :enemies

    def initialize(game:, details:)
      @game       = game
      @bullets    = []
      @explosions = []
      @bunkers    = create_bunkers(details["bunkers"])
      @enemies    = create_enemies(details["enemies"])
    end

    def update
      @bunkers.each(&:update)
      @bullets.each(&:update)
      @explosions.each(&:update)
      @enemies.each(&:update)

      handle_collisions
    end

    def draw
      @bunkers.each(&:draw)
      @bullets.each(&:draw)
      @explosions.each(&:draw)
      @enemies.each(&:draw)
    end

    def register_bullet(bullet)
      @bullets << bullet
    end

    def remove_bullet(bullet)
      @bullets = @bullets.reject { |b| b == bullet }
    end

    def register_explosion(x:, y:)
      @explosions << Explosion.new(x: x, y: y, level: self)
    end

    def remove_explosion(explosion)
      @explosions = @explosions.reject { |e| e == explosion }
    end

    def register_spaceship(x:, y:)
      @enemies << Enemy::Spaceship.new(x: x, y: y)
    end

    def remove_spaceship(spaceship)
      @enemies = @enemies.reject { |e| e == spaceship }
    end

    def out_of_ammo?
      @explosions.empty? &&
        @bullets.empty? &&
        @bunkers.select{ |b| b.ammo.empty? }.count == @bunkers.count
    end

    def over?
      enemies.count == 0
    end

    private

    def create_enemies(details)
      details["number"].times.collect do
        Enemy::Spaceship.new(
          x: rand(MissileCommand::WIDTH),
          y: to_y_coord(details["height"]),
          mode: details["mode"],
          weapons: details["weapons"],
          delay: details["delay"]
        )
      end
    end

    def to_y_coord(height)
      case height
      when "high"
        rand(MissileCommand::HEIGHT / 6)
      when "medium"
        rand(MissileCommand::HEIGHT / 4)
      when "low"
        rand(MissileCommand::HEIGHT / 2)
      end
    end


    def create_bunkers(details)
      details["number"].times.collect do |i|
        Bunker.new(level: self, key: Utility::BUNKER_KEYS[i], ammo: details["ammo"])
      end
    end

    def handle_collisions
      return if @enemies.empty? || @explosions.empty?
      @enemies.product(@explosions).select {|pair| Collision.detect(*pair)}.each do |spaceship, _|
        remove_spaceship(spaceship)
        Score.increase
      end
    end
  end
end