Rails.application.routes.draw do
  root to: "public/homes#top"
  get "/about" => "public/homes#about"
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
get '/admin' => 'admin/homes#top'

namespace :admin do
  resources :items, only: [:index, :create, :new, :show, :edit, :update]
end

get '/admins/sgin_in' => 'admin/session#new'
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do
  resources :items, only: [:index, :show]
end
get '/customers/sign_in' => 'public/session#new'
get '/customers/mypage' => 'public/customers#show'
get '/customers/information/edit' => 'public/customers#edit'
patch '/customers/information' => 'public/customers#update'
get '/customers/confirm_withdraw' => 'public/customers#check'
patch '/customers/withdraw' => 'public/customers#withdrawal'
get '/orders' => 'public/orders#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
