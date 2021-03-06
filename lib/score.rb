class Score
  class << self
    def increase(n = 1)
      @@score = score + n
    end

    def decrease(n = 1)
      @@score = score - n
    end

    def score
      @@score ||= 0
    end

    def high_score
      @@high_score  ||= if File.exist?("high_score.txt")
                          File.read("high_score.txt").to_i
                        else
                          0
                        end
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
        0
      ]
    end

    def high_score_position
      [
        10,
        0
      ]
    end

    def score_box
      @@score_box ||= Gosu::Font.new(20, name:  "assets/fonts/Starjedi.ttf")
    end
  end
end