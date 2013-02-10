Rakeleak::Engine.routes.draw do
  resources :tasks, :only => [:index] do
    post 'run', on: :member
  end
end
