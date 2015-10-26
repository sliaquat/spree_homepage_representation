class Spree::HomepageRepresentation < ActiveRecord::Base
  acts_as_list
  default_scope { order("#{self.table_name}.position") }
  has_attached_file :background_image,
                    styles: { mini: '48x48>', small: '100x100>', product: '240x240>', large: '600x600>' },
                    default_style: :product,
                    url: '/spree/homepage_representations/:id/:style/:basename.:extension',
                    path: ':rails_root/public/spree/homepage_representations/:id/:style/:basename.:extension',
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
  validates_attachment :background_image,
                       :content_type => { :content_type => %w(image/jpeg image/jpg image/png image/gif) }

  validates :background_stellar_ratio, inclusion: { in: 0..1 }
  validates :background_stellar_offset, inclusion: { in: 0..1500 }
  validates :no_of_carousel_items, inclusion: { in: 1..8 }
end
