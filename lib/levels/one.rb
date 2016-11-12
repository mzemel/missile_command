class Levels::One < Levels::Base

  def initialize(game:)
    super(game: game)
    @enemies = 3.times.collect do
      Enemy::Spaceship.new(
        x: rand(MissileCommand::WIDTH), 
        y: rand(MissileCommand::HEIGHT / 4),
        mode: :easy
      )
    end

    @bunkers = [
      Bunker.new(level: self, key: 'a')
    ]
  end
end