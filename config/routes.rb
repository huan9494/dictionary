Rails.application.routes.draw do
  get 'translations/index'
  post 'translations/index'

  get 'translations/auto_complete', to: 'translations#auto_complete'
  root 'translations#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
