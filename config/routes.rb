Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :patients do
    resources :phones
    resources :emails
    resources :notes
    resources :google_drive_folders
  end
  
  namespace 'typeahead' do
    get "districts", to: '/patients#districts', :defaults => { :format => 'json' }
  end

  root 'patients#index'
end
