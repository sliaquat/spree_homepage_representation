class AddColorAndImageToSpreeHomepageRepresentations < ActiveRecord::Migration
  def change

    change_table :spree_homepage_representations do |t|
      t.attachment :background_image
      t.string :background_color
    end


  end
end
