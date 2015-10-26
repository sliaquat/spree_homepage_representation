class Spree::Admin::HomepageRepresentationsController < Spree::Admin::ResourceController

  def index
    @reviews = Spree::Review.where('approved=true')
  end

  def create
    @taxon_homepage_representation = Spree::HomepageRepresentation.new(homepage_representation)
    if @taxon_homepage_representation.representable_type.constantize == Spree::Taxon || @taxon_homepage_representation.representable_type.constantize == Spree::Review

      if (params["temp"]["background_type"] == 'Color')
        @taxon_homepage_representation.background_image = nil
      else
        @taxon_homepage_representation.background_color = nil
      end

    end

    if (@taxon_homepage_representation.save)
      flash[:success] = "Successfully saved homepage representation"
    else
      flash[:error] = "Error saving homepage representation"
    end
    redirect_to admin_homepage_representations_path
  end

  def update

    @taxon_homepage_representation = Spree::HomepageRepresentation.find(params[:id])

    if (@taxon_homepage_representation.update(homepage_representation))

      if @taxon_homepage_representation.representable_type.constantize == Spree::Taxon || @taxon_homepage_representation.representable_type.constantize == Spree::Review

        if (params["temp"]["background_type"] == 'Color')
          @taxon_homepage_representation.background_image.destroy
          @taxon_homepage_representation.save
        else
          @taxon_homepage_representation.update_attribute(:background_color, nil)
        end

      end


      flash[:success] = "Successfully updated homepage representation"
    else
      flash[:error] = "Error updating homepage representation"
    end
    redirect_to admin_homepage_representations_path
  end

  def taxon_image #new
    @taxon_homepage_representation = Spree::HomepageRepresentation.new()

    load_taxon_image_varables(params)

    respond_to do |format|
      format.js { render layout: false, content_type: 'text/javascript' }
      format.html
    end

  end

  def taxons #new
    @taxon_homepage_representation = Spree::HomepageRepresentation.new()


    load_taxon_varables(params)

    respond_to do |format|
      format.js { render layout: false, content_type: 'text/javascript' }
      format.html
    end

  end

  def taxon_products #new

    @taxon_homepage_representation = Spree::HomepageRepresentation.new()

    @taxon_homepage_representation.background_stellar_offset = 0 unless @taxon_homepage_representation.background_stellar_offset
    @taxon_homepage_representation.background_stellar_ratio = 0.3 unless @taxon_homepage_representation.background_stellar_ratio

    load_taxon_products_variables(params)

    respond_to do |format|
      format.js { render layout: false, content_type: 'text/javascript' }
      format.html
    end


  end

  def reviews #new

    @taxon_homepage_representation = Spree::HomepageRepresentation.new()
    @taxon_homepage_representation.background_stellar_offset = 0 unless @taxon_homepage_representation.background_stellar_offset
    @taxon_homepage_representation.background_stellar_ratio = 0.3 unless @taxon_homepage_representation.background_stellar_ratio

    @reviews = Spree::Review.where('approved=true')

    respond_to do |format|
      format.html
    end


  end

  def edit
    @taxon_homepage_representation = Spree::HomepageRepresentation.find(params[:id])


    if @taxon_homepage_representation.representable_type.constantize == Spree::TaxonImage
      load_taxon_image_varables(params)
      respond_to do |format|
        format.js { render 'taxon_image', layout: false, content_type: 'text/javascript' }
        format.html { render 'edit_taxon_image' }
      end

    elsif @taxon_homepage_representation.representable_type.constantize == Spree::Taxon


      taxon = Spree::Taxon.find_by(id: @taxon_homepage_representation.representable_id)

      if (taxon.children.count > 0)
        load_taxon_varables(params)
        respond_to do |format|
          format.js { render 'taxon', layout: false, content_type: 'text/javascript' }
          format.html { render 'edit_taxons' }
        end

      elsif (taxon.products.count > 0)
        load_taxon_products_variables(params)
        respond_to do |format|
          format.js { render 'taxon_products', layout: false, content_type: 'text/javascript' }
          format.html { render 'edit_taxon_products' }
        end
      end
    elsif @taxon_homepage_representation.representable_type.constantize == Spree::Review
      @reviews = Spree::Review.where('approved=true')
      @taxon_homepage_representation.background_stellar_offset = 0 unless @taxon_homepage_representation.background_stellar_offset
      @taxon_homepage_representation.background_stellar_ratio = 0.3 unless @taxon_homepage_representation.background_stellar_ratio

      respond_to do |format|
        format.html { render 'edit_reviews' }
      end

    end
  end

end


def load_taxon_products_variables(params)
  @taxons_with_products = Spree::Taxon.taxons_that_have_products

  @taxon_homepage_representation.background_stellar_offset = 0 unless @taxon_homepage_representation.background_stellar_offset
  @taxon_homepage_representation.background_stellar_ratio = 0.3 unless @taxon_homepage_representation.background_stellar_ratio


  if (params["homepage_representation_representable_id"])
    @selected_taxon = Spree::Taxon.find_by(id: params["homepage_representation_representable_id"])
  else

    if (@taxon_homepage_representation.representable_id) #editing mode
      @selected_taxon = Spree::Taxon.find_by(id: @taxon_homepage_representation.representable_id)
    else
      @selected_taxon = @taxons_with_products.first
    end

  end

  @products = @selected_taxon.products
end

def load_taxon_varables(params)
  @top_level_taxons = Spree::Taxon.top_level_taxons_with_child_taxons_that_have_products

  @taxon_homepage_representation.background_stellar_offset = 0 unless @taxon_homepage_representation.background_stellar_offset
  @taxon_homepage_representation.background_stellar_ratio = 0.3 unless @taxon_homepage_representation.background_stellar_ratio


  if (params["homepage_representation_representable_id"])
    @selected_parent_taxon = Spree::Taxon.find_by(id: params["homepage_representation_representable_id"])
  else

    if (@taxon_homepage_representation.representable_id) #editing mode
      @selected_parent_taxon = Spree::Taxon.find_by(id: @taxon_homepage_representation.representable_id)
    else
      @selected_parent_taxon = @top_level_taxons.first
    end

  end

  @child_taxons = @selected_parent_taxon.taxons_that_have_products
end


private


def load_taxon_image_varables(params)
  @taxon_homepage_representation.background_stellar_offset = 0 unless @taxon_homepage_representation.background_stellar_offset
  @taxon_homepage_representation.background_stellar_ratio = 0.3 unless @taxon_homepage_representation.background_stellar_ratio

  @taxons_with_taxon_images = Spree::Taxon.taxon_with_published_taxon_images

  if (params["taxon_id"])
    @selected_taxon = Spree::Taxon.find_by(id: params["taxon_id"])
  else

    if (@taxon_homepage_representation.representable_id)
      @selected_taxon = Spree::TaxonImage.find(@taxon_homepage_representation.representable_id).taxon
    else
      @selected_taxon = @taxons_with_taxon_images.first
    end

  end

  @taxon_images = @selected_taxon.published_taxon_images


  if (params["taxon_image_id"])
    @selected_taxon_image = Spree::TaxonImage.find_by(id: params["taxon_image_id"])
  else
    if @taxon_homepage_representation.representable_id && !params["taxon_id"]
      @selected_taxon_image = Spree::TaxonImage.find(@taxon_homepage_representation.representable_id)
    else
      @selected_taxon_image = @taxon_images.first
    end
  end

  # puts ">>>>>>>>> @selected_taxon_image: #{@selected_taxon_image.id} - #{@selected_taxon_image.alt} "

end


def homepage_representation
  params.require(:homepage_representation).permit(:name, :position, :representable_id, :representable_type, :background_color, :background_image, :dark, :description, :background_stellar_offset, :background_stellar_ratio, :no_of_carousel_items)
end

