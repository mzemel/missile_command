class Score
  class << self
    def increase
      @@score = score + 1
    end

    def decrease
      @@score = score - 1
    end

    def score
      @@score ||= 0
    end

    def position
      [
        MissileCommand::WINDOW_WIDTH - 100,
        20
      ]
    end

    def score_box
      @@score_box ||= Gosu::Font.new(20)
    end

    def draw
      score_box.draw("Score: #{score}", *position, Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
    end
  end
end