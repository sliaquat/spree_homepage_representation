module Spree
  class HomepageRepresentationSettings < Preferences::Configuration

    preference :allowed_items, :array, default: []

  end
end

