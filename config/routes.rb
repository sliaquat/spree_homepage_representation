Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do


    resources :homepage_representations do
      get 'taxon_image', on: :new
      get 'taxons', on: :new
      get 'taxon_products', on: :new
      get 'reviews', on: :new
      collection do
        post :update_positions
      end

    end

  end

end
