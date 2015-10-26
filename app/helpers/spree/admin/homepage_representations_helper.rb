module Spree::Admin::HomepageRepresentationsHelper

  def human_representable_type(type)
    type.gsub(/^.*\:/, "").underscore.humanize.split.map(&:capitalize).join(' ')
  end

  def representation_sub_type(representation)

    if representation.representable_type.constantize == Spree::Taxon
      taxon = Spree::Taxon.find_by(id: representation.representable_id)
      if (taxon.children.count > 0)
               return "> Taxons"
      elsif(taxon.products.count > 0)
        return "> Products"
      end
    end

    return ""

  end

end
