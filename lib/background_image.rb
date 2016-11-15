class BackgroundImage
  attr_reader :background_image, :ground

  GROUND_HEIGHT = 70

  def initialize
    @background_image = Gosu::Image.new("assets/planets/background/default.png")
    @ground           = Gosu::Image.new("assets/planets/ground/default.png", tileable: true)
    @music            = nil
  end

  def draw
    background_image.draw(0,0,Utility::ZIndex::BACKGROUND)
    ground.draw(0, MissileCommand::HEIGHT - GROUND_HEIGHT, Utility::ZIndex::GROUND)
  end

  def set_planet(planet)
    if File.exist?("assets/planets/background/#{planet}.png")
      @background_image = Gosu::Image.new("assets/planets/background/#{planet}.png")
    end
    if File.exist?("assets/planets/ground/#{planet}.png")
      @ground = Gosu::Image.new("assets/planets/ground/#{planet}.png", tileable: true)
    end
  end

  def set_music(music)
    @music.stop if @music
    if music && File.exist?("assets/music/#{music}")
      @music = Gosu::Song.new("assets/music/#{music}")
      @music.play(looping = true)
    end
  end
end