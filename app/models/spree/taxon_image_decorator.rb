Spree::TaxonImage.class_eval do
  has_many :homepage_representations, as: :representable, dependent: :destroy

  after_update :remove_homepage_representations, :if => "published == false"


  def remove_homepage_representations
    self.homepage_representations.destroy_all
  end

end