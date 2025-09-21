class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post.likes.find_or_create_by!(user: current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @post }
    end
  end

  def destroy
    @post.likes.find_by!(user: current_user)&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @post }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end