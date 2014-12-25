Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resource :fastly_settings, only: [:edit, :update]
  end
  get '/csrf_meta_tags' => 'home#csrf_meta_tags'
end