require 'yaml'

class Levels::Collection
  attr_reader :levels, :count, :game

  def initialize(game:)
    @count = 0
    @game  = game
  end

  def shift
    @count += 1
    Levels::Base.new(game: game, details: YAML.load_file("./config/#{game.difficulty}.yml")[count])
  end

  def empty?
    count >= YAML.load_file("./config/#{game.difficulty}.yml").count
  end
end