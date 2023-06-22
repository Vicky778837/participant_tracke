Rails.application.routes.draw do
  resources :registries do
    resources :enrollments, only: [:new, :create, :index]
    resources :participants, only: [:index]
  resources :coordinators
  end

  get 'export_participants', to: 'participants#export'
  root 'registries#index'
end
