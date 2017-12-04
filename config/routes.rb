Rails.application.routes.draw do
  #get 'stocks/index'

	root 'stocks#index'
	resource 'stocks', only: :index do
		collection { post :import}
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
