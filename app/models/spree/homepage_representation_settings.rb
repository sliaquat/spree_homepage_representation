module Spree
  class HomepageRepresentationSettings < Preferences::Configuration

    preference :allowed_items, :array, default: [:taxons, :reviews, :taxon_image, :taxon_products]

  end
end

