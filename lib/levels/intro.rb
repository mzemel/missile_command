require_relative '../mixins/dragons'

class Levels::Intro
  include Mixins::Dragons # stubs

  attr_reader :game

  def initialize(game:)
    @info = Gosu::Font.new(20, name:  "assets/fonts/Starjedi.ttf")
    @game = game
    @enemies = [
      Enemy::Fortress.new(
        x: rand(MissileCommand::WIDTH),
        y: 20,
        mode: "easy",
        weapons: false,
        level: self,
        ammo: 0,
        health: 1
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
      "welcome, missile commander!",
      "",
      "use your turrets to destroy imperial aircraft",
      "first turret: a",
      "second turret: s",
      "third turret: d",
      "run out of ammo and you lose.",
      "",
      "press any of the following to start",
      "easy: e, medium: m, hard: h"
    ]
  end
end