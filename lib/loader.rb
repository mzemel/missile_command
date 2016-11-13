%w(background_image cursor utility bunker ammo bullet score explosion collision defender).each do |f|
  require_relative "./#{f}"
end

# Enemies
%w(spaceship missile battleship).each do |f|
  require_relative "./enemy/#{f}"
end

# Levels
%w(base collection intro).each do |f|
  require_relative "./levels/#{f}"
end

# Mixins
%w(dragons projectile).each do |f|
  require_relative "./mixins/#{f}"
end