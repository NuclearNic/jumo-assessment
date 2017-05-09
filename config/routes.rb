Rails.application.routes.draw do

	root 'loans#index'

	resources :loans
	resources :loan_files

end
