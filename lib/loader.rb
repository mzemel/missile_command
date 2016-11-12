%w(background_image cursor utility bunker ammo bullet score).each do |f|
  require_relative "./#{f}"
end
