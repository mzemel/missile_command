%w(background_image cursor utility bunker ammo bullet score explosion).each do |f|
  require_relative "./#{f}"
end
