require_relative '../mixins/dragons'

class Levels::Intro
  include Mixins::Dragons # stubs

  def initialize
    @info = Gosu::Font.new(20)
    @enemies = [
      Enemy::Spaceship.new(
        x: rand(MissileCommand::WIDTH),
        y: 20,
        mode: "easy",
        weapons: false,
        level: self,
        ammo: 0
      )
    ]
  end

  def update
    @enemies.each(&:update)
    @done = true if Utility.space_button?
  end

  def draw
    @enemies.each(&:draw)
    instructions.each_with_index do |line, i|
      @info.draw(line, 50, 100 + 20 * (i), Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
    end
  end

  def over?
    @done == true
  end

  private

  def instructions
    @instructions ||= [
      "Welcome to Missile Command",
      "",
      "Destroy enemy ships & missiles",
      "First bunker fires with 'a'",
      "Second with 's', third with 'd', etc.",
      "Run out of ammo and you lose.",
      "",
      "Press [Space] to start"
    ]
  end
end