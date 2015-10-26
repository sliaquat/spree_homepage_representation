class AddNoOfCarouselItemsToSpreeHomepageRepresentations < ActiveRecord::Migration
  def change
    add_column :spree_homepage_representations, :no_of_carousel_items, :integer, default: 4

  end
end
