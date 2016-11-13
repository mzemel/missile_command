%w(background_image cursor utility bunker ammo bullet score explosion collision).each do |f|
  require_relative "./#{f}"
end

# Enemies
%w(spaceship).each do |f|
  require_relative "./enemy/#{f}"
end

# Levels
%w(base collection intro).each do |f|
  require_relative "./levels/#{f}"
end