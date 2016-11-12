class Levels::Collection
  attr_reader :levels

  def initialize(game:)
    @levels = [
      Levels::One.new(game: game),
      Levels::Two.new(game: game)
    ]
  end

  def shift
    @levels.shift
  end

  def empty?
    @levels.empty?
  end
end