# config/routes.rb
Rails.application.routes.draw do
  get "likes/create"
  get "likes/destroy"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get "home/index"
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  resources :posts do
    # 用于“按下按钮加载显示评论”的懒加载入口（PostsController#comments）
    member do
      get :comments  # /posts/:id/comments  -> posts#comments
    end

    # 评论的创建/删除仍然走标准 REST（CommentsController）
    resources :comments, only: [:index, :create, :destroy]
    # 生成：
    # POST   /posts/:post_id/comments    -> comments#create
    # DELETE /posts/:post_id/comments/:id -> comments#destroy
    resources :likes, only: [:create, :destroy]
  end

  # 密码重置
  get  'reset/start', to: 'password_resets#new'
  post 'reset/send',  to: 'password_resets#create'
end
