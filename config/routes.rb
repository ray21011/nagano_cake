Rails.application.routes.draw do
  root to: "public/homes#top"
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
get '/admin' => 'admin/homes#top'
get '/admins/sgin_in' => 'admin/session#new'
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
get '/customers/sign_in' => 'public/session#new'
get '/customers/mypage' => 'public/customers#show'
get '/customers/information/edit' => 'public/customers#edit'
get '/orders' => 'public/orders#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
