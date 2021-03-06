Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "links#new"
  resources :links, only: [:create,:new,:show]
  get '/:hash_key' => 'links#forward_to_link', as: :short_url_forward
  namespace :admin do
    resources :links, only:[:show] do
      member do
        put :expire_link
      end
    end
  end

end
