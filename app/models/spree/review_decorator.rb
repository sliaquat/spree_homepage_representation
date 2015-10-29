Spree::Taxon.class_eval do
  has_many :homepage_representations, as: :representable

end