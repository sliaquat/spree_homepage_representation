class AddStellarOffsetAndRatioSpreeHomepageRepresentations < ActiveRecord::Migration
  def change
    add_column :spree_homepage_representations, :background_stellar_ratio, :float
    add_column :spree_homepage_representations, :background_stellar_offset, :integer
  end
end
