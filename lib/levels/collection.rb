require 'yaml'

class Levels::Collection
  attr_reader :levels

  def initialize(game:)
    @levels = YAML
              .load_file("./config/levels.yml")
              .collect do |_, details|
                Levels::Base.new(game: game, details: details)
              end
    @levels = [
      Levels::Intro.new
    ] + @levels
  end

  def shift
    @levels.shift
  end

  def empty?
    @levels.empty?
  end
end