Rails.application.routes.draw do
  get 'index/find'
  root 'index#find'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
