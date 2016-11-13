require_relative '../dragons'

class Levels::Intro
  include Dragons # stubs

  def initialize
    @info = Gosu::Font.new(20)
    @enemies = [
      Enemy::Spaceship.new(
        x: rand(MissileCommand::WIDTH),
        y: 20,
        mode: "easy",
        weapons: false,
        level: self
      )
    ]
  end

  def update
    @enemies.each(&:update)
    @done = true if Utility.space_button?
  end

  def draw
    @enemies.each(&:draw)
    @info.draw("Press [Space] to start", 200, 200, Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
  end

  def over?
    @done == true
  end
end