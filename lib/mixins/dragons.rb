# Stubs that bring improperly related objects
#   into having the same API. I be not proud.

module Mixins
  module Dragons
    def self.included(base)
      base.class_eval do
        def out_of_ammo?
          false
        end

        def bunkers
          []
        end

        def apply_bonuses; end
      end
    end
  end
end