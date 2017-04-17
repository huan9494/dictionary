Rails.application.routes.draw do
  get 'translations/index'
  get 'translations/new'
  get 'translations/create'
  get 'translations/show'
  
  root 'translations#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
