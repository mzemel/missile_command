require_relative '../mixins/dragons'

class Levels::Intro
  include Mixins::Dragons # stubs

  attr_reader :game

  def initialize(game:)
    @info = Gosu::Font.new(20)
    @game = game
    @enemies = [
      Enemy::Spaceship.new(
        x: rand(MissileCommand::WIDTH),
        y: 20,
        mode: "easy",
        weapons: false,
        level: self,
        ammo: 0,
        health: "low"
      )
    ]
    game.background_image.set_music("imperial_march.mp3")
  end

  def update
    @enemies.each(&:update)
    if Utility.e_button?
      game.difficulty = "easy"
      @done = true
    elsif Utility.m_button?
      game.difficulty = "medium"
      @done = true
    elsif Utility.h_button?
      game.difficulty = "hard"
      @done = true
    end
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
      "First bunker fires with [a]",
      "Second with [s], third with [d], etc.",
      "Run out of ammo and you lose.",
      "",
      "Press [e]asy, [m]edium or [h]ard"
    ]
  end
end