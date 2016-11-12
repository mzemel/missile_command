%w(background_image cursor utility bunker ammo).each do |f|
  require_relative "./#{f}"
end
