Rails.application.routes.draw do
  root to: 'home#index'

  get '/question/search', to: 'search#index'
  get '/home/dashboard', to: 'dashboard#index'
  get '/notifications', to: 'notification#index'

  resources :questions, only: [:show, :create] do 
    resources :answers, only: [:create]
  end

  # Students routes
	  get '/students/sign_up', to: 'students#get_sign_up'
	  get '/students/sign_in', to: 'students#get_sign_in'
  	post '/students/sign_up', to: 'students#post_sign_up'
  	post '/students/sign_in', to: 'students#post_sign_in'
    delete '/students/sign_out', to: 'students#sign_out'

  # Teachers routes
	  get '/teachers/sign_up', to: 'teachers#get_sign_up'
	  get '/teachers/sign_in', to: 'teachers#get_sign_in'
	  post '/teachers/sign_up', to: 'teachers#post_sign_up'
	  post '/teachers/sign_in', to: 'teachers#post_sign_in'
    delete '/teachers/sign_out', to: 'teachers#sign_out'
end
