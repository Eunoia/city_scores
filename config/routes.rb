Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: 'pages#index'
	namespace :api do
		namespace :v1 do
			resources :routes do
				get 'segments', on: :collection
			end
		end
	end

	require 'resque/server'
	mount Resque::Server, at: '/jobs'

end
