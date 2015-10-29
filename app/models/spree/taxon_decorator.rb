Spree::Taxon.class_eval do
  has_many :homepage_representations, as: :representable, dependent: :destroy

  has_attached_file :icon,
                    styles: { mini: '32x32>', normal: '128x128>' },
                    default_style: :mini,
                    url: '/spree/taxons/:id/:style/:basename.:extension',
                    path: ':rails_root/public/spree/taxons/:id/:style/:basename.:extension',
                    default_url: 'default_taxon.png'


  def self.top_level_taxons_with_child_taxons_that_have_products

    where("parent_id IS ?", nil).select do |taxon|
      taxons_with_this_parent = Spree::Taxon.where("parent_id = ?", taxon.id)
      taxons_with_this_parent.count > 0 && taxons_with_this_parent.select{|tx| tx.products.count > 0}.count > 0
    end
  end

  def taxons_that_have_products
    taxons_with_this_parent = Spree::Taxon.where("parent_id = ?", id)
    taxons_with_this_parent.select{|taxon| taxon.products.count}
  end

  def self.taxons_that_have_products
    Spree::Taxon.all.order('position ASC').select {|taxon| taxon.products.count > 0}
  end

end