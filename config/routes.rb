Rails.application.routes.draw do

	root 'loans#index'

	resources :loans, only: [:new, :create, :index]
	resources :loan_files, only: [:new, :create]

end
