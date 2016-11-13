class HighScore
  def self.print
    File.read("high_scores.txt", "ar") do |f|
      scores = f.read
    end
  end
end