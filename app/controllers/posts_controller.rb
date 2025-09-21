class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
    if params[:q].present?
      pattern = "%#{params[:q]}%"
      @posts = @posts.where("title LIKE ? OR body LIKE ?", pattern, pattern)
    end
  end

  def comments
    @post = Post.find(params[:id])
    render partial: "posts/comments", locals: { post: @post }
  end

  def show
    @comments = @post.comments.includes(:user)
    @comment  = Comment.new
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    redirect_to posts_path, alert: "You are not allowed to do this action." unless @post.user == current_user
  end
end