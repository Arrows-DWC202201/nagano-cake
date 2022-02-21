Rails.application.routes.draw do

# 管理者側のルーティング設定
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    root to: "homes#top"
    resources :customers, only:[:index, :show, :edit, :update]
    resources :items, except:[:destroy]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_items, only:[:update]
  end

  # 会員側のルーティング設定

  scope module: :public do
    root to: "homes#top"
    get "/about", to: "homes#about"
    resource :customers, only:[:show, :edit, :update] do
      collection do
        get "quit"
        patch "out"
      end
    end
    resources :items, only:[:index, :show]
    resources :cart_items, only:[:index, :update, :create, :destroy]
    delete "/cart_items", to: "cart_items#all_destroy"
    resources :orders, only:[:new, :create, :index, :show] do
      collection do
        post "confirm"
        get "thanks"
      end
    end
    resources :addresses, except:[:new, :show]
  end

  devise_scope :customer do
    get '/customers/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
