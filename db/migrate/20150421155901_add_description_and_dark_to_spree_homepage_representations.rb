class AddDescriptionAndDarkToSpreeHomepageRepresentations < ActiveRecord::Migration
  def change
    change_table :spree_homepage_representations do |t|
      t.boolean :dark
      t.text :description
    end
  end
end
