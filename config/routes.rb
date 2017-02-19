Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    get :blog, to: 'blog#index'
    get :home, to: 'static#home'
    root 'static#home'
    get :search, to: 'static#search'
    get :contact_details, to: 'static#contact_details'

end
