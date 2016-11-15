module Levels
  class Base

    attr_reader :game,
                :bullets,
                :explosions,
                :spaceships,
                :battleships,
                :missiles,
                :bunkers,
                :defenders,
                :fortresses

    def initialize(game:, details:)
      @game       = game
      @bullets    = []
      @explosions = []
      @missiles   = []
      @bunkers    = create_bunkers(details["bunkers"])
      @ships      = []
      @spaceships = create_spaceships(details["spaceships"])
      @battleships = create_battleships(details["battleships"])
      @fortresses = create_fortresses(details["fortresses"])
      @defenders  = create_defenders(details["defenders"])
      @aud_disarm = Gosu::Sample.new("assets/sounds/disarm.wav")
      game.background_image.set_planet(details["planet"] || "space")
    end

    def update
      @bunkers.each(&:update)
      @bullets.each(&:update)
      @explosions.each(&:update)
      @missiles.each(&:update)
      @spaceships.each(&:update)
      @battleships.each(&:update)
      @fortresses.each(&:update)
      @defenders.each(&:update)

      handle_explosions_to_spaceships
      handle_explosions_to_battleships
      handle_explosions_to_fortresses
      handle_missiles_to_bunkers
      handle_missiles_to_defenders
      handle_explosions_to_missiles
    end

    def draw
      @bunkers.each(&:draw)
      @bullets.each(&:draw)
      @explosions.each(&:draw)
      @missiles.each(&:draw)
      @spaceships.each(&:draw)
      @battleships.each(&:draw)
      @fortresses.each(&:draw)
      @defenders.each(&:draw)
    end

    def register_bullet(bullet)
      @bullets << bullet
    end

    def register_missile(missile)
      @missiles << missile
    end

    def register_explosion(explosion)
      @explosions << explosion
    end

    def remove_bullet(bullet)
      @bullets = @bullets.reject { |b| b == bullet }
    end

    def remove_explosion(explosion)
      @explosions = @explosions.reject { |e| e == explosion }
    end

    def remove_spaceship(spaceship, projectile)
      @spaceships = @spaceships.reject { |e| e == spaceship }
      Score.increase(2) if projectile.launcher.is_a?(Bunker)
    end

    def remove_battleship(battleship, projectile)
      @battleships = @battleships.reject { |e| e == battleship }
      Score.increase(5) if projectile.launcher.is_a?(Bunker)
    end

    def remove_fortress(fortress, projectile)
      @fortresses = @fortresses.reject { |e| e == fortress }
      Score.increase(20) if projectile.launcher.is_a?(Bunker)
    end

    def remove_missile(missile, projectile = nil)
      @missiles = @missiles.reject { |m| m == missile }
      # Able to do something depending on type of projectile
    end

    def remove_defender(defender, projectile)
      @defenders = @defenders.reject { |d| d == defender }
      # Able to do something depending on type of projectile
    end

    def out_of_ammo?
      @explosions.empty? &&
        @bullets.empty? &&
        @bunkers.select{ |b| b.ammo.empty? }.count == @bunkers.count
    end

    def over?
      if spaceships.count == 0 && 
          battleships.count == 0 && 
          fortresses.count == 0
        return true
      end
    end

    def apply_bonuses
      ammo_left    = bunkers.map(&:ammo).map(&:count).inject(:+)
      bunkers_left = bunkers.reject(&:destroyed).count
      Score.increase(2 * ammo_left)
      Score.increase(5 * bunkers_left)
    end

    private

    def create_bunkers(details)
      details["number"].times.collect do |i|
        x = (MissileCommand::WIDTH * (i.to_f + 0.5)) / details["number"]
        Bunker.new(
          level: self,
          key: Utility::BUNKER_KEYS[i],
          ammo: details["ammo"],
          x: x,
          health: details["health"] || "low"
        )
      end
    end

    def create_spaceships(details)
      details["number"].times.collect do
        Enemy::Spaceship.new(
          x: rand(MissileCommand::WIDTH),
          y: to_y_coord(details["height"]),
          mode: details["mode"] || "easy",
          weapons: details["weapons"],
          ammo: details["ammo"] || 100,
          health: details["health"] || "low",
          level: self
        )
      end
    end

    def create_battleships(details)
      details["number"].times.collect do
        Enemy::Battleship.new(
          x: rand(MissileCommand::WIDTH),
          y: to_y_coord(details["height"]),
          mode: details["mode"] || "easy",
          weapons: details["weapons"],
          ammo: details["ammo"] || 100,
          health: details["health"] || "low",
          level: self
        )
      end
    end

    def create_fortresses(details)
      details["number"].times.collect do
        Enemy::Fortress.new(
          x: rand(MissileCommand::WIDTH),
          y: to_y_coord(details["height"]),
          mode: details["mode"] || "easy",
          weapons: details["weapons"],
          ammo: details["ammo"] || 100,
          health: nil, # Fixed value
          level: self
        )
      end
    end

    def create_defenders(details)
      details["number"].times.collect do
        Defender.new(
          x: rand(MissileCommand::WIDTH),
          y: MissileCommand::HEIGHT - BackgroundImage::GROUND_HEIGHT - to_y_coord(details["height"]),
          mode: details["mode"] || "easy",
          weapons: details["weapons"],
          ammo: details["ammo"] || 100,
          health: details["health"] || "low",
          level: self,
        )
      end
    end

    def to_y_coord(height)
      case height
      when "medium"
        rand(MissileCommand::HEIGHT / 4)
      when "low"
        rand(MissileCommand::HEIGHT / 2)
      else
        rand(MissileCommand::HEIGHT / 6)
      end
    end

    ###################          COLLISIONS         #########################
    #                                                                       #
    # The ordering of the two objects is important for detecting collisions #
    #                                                                       #
    # I have no idea why it's inconsistent so if you add more collisions    #
    #   try it both ways to see which one works                             #
    #########################################################################

    def handle_explosions_to_spaceships
      return if @spaceships.empty? || @explosions.empty?
      @spaceships.product(@explosions).select {|pair| Collision.detect(*pair)}.each do |spaceship, explosion|
        spaceship.damage!(explosion.projectile)
      end
    end

    def handle_explosions_to_battleships
      return if @battleships.empty? || @explosions.empty?
      @battleships.product(@explosions).select {|pair| Collision.detect(*pair)}.each do |battleship, explosion|
        battleship.damage!(explosion.projectile)
      end
    end

    def handle_explosions_to_fortresses
      return if @fortresses.empty? || @explosions.empty?
      @fortresses.product(@explosions).select {|pair| Collision.detect(*pair)}.each do |fortress, explosion|
        fortress.damage!(explosion.projectile)
      end
    end

    def handle_missiles_to_bunkers
      return if @missiles.empty?
      @missiles.product(@bunkers).select {|pair| Collision.detect(*pair)}.each do |missile, bunker|
        remove_missile(missile)
        bunker.damage!(missile) unless ENV["CHEAT"]
      end
    end

    def handle_missiles_to_defenders
      return if @missiles.empty? || @defenders.empty?
      @missiles.product(@defenders).select {|pair| Collision.detect(*pair)}.each do |missile, defender|
        remove_missile(missile)
        defender.damage!(missile)
      end
    end

    def handle_explosions_to_missiles
      return if @missiles.empty? || @explosions.empty?
      @missiles.product(@explosions).select {|pair| Collision.detect(*pair)}.each do |missile, explosion|
        remove_missile(missile)
        @aud_disarm.play # Maybe softer if it's fired by a defender
        Score.increase(1) if explosion.projectile.launcher.is_a?(Bunker)
      end
    end
  end
end