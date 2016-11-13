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

    def high_score
      @@high_score ||= File.read("high_score.txt").to_i
    end

    def check_high_score
      if score > high_score
        File.open("high_score.txt", "w") {|f| f.write score}
        @@high_score = score
      end
    end

    def draw
      score_box.draw("High Score: #{high_score}", *high_score_position, Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
      score_box.draw("Score: #{score}", *score_position, Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
    end

    private

    def score_position
      [
        MissileCommand::WIDTH - 100,
        20
      ]
    end

    def high_score_position
      [
        MissileCommand::WIDTH - 130,
        0
      ]
    end

    def score_box
      @@score_box ||= Gosu::Font.new(20)
    end
  end
end