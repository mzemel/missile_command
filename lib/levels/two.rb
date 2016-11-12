class Levels::Two < Levels::Base

  def initialize(game:)
    super(game: game)
    @enemies = 5.times.collect do
      Enemy::Spaceship.new(
        x: rand(MissileCommand::WIDTH), 
        y: rand(MissileCommand::HEIGHT / 4),
        mode: :medium
      )
    end
    @bunkers    = [
      Bunker.new(level: self, key: 'a'),
      # Bunker.new(level: self, key: 's')
    ]
  end
end