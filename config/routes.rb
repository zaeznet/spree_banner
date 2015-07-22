Spree::Core::Engine.routes.draw do
  
  namespace :admin do
    resources :banner_boxes do
      collection do
        post :update_positions
      end
      member do
        get :clone
      end
    end

    resource :banner_box_settings, only: [:show, :edit, :update]
  end
end
