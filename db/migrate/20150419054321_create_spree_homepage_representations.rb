class CreateSpreeHomepageRepresentations < ActiveRecord::Migration
  def change
    create_table :spree_homepage_representations do |t|
      t.string :name
      t.references :representable, polymorphic: true
      t.integer :position, null: false, default: 0
      t.timestamps null: false
    end

    add_index :spree_homepage_representations, [:representable_type, :representable_id], :name => "index_s_h_r_representable"
    add_index :spree_homepage_representations, :position, :name => "index_s_h_r_position"
  end
end
