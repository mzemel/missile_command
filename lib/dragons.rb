# Stubs that bring improperly related objects
#   into having the same API. I be not proud.

module Dragons
  def self.included(base)
    base.class_eval do
      def out_of_ammo?
        false
      end

      def bunkers
        []
      end
    end
  end
end