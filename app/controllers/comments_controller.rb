class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      respond_to do |format|
        format.turbo_stream   # 渲染 app/views/comments/create.turbo_stream.erb
        format.html { redirect_to @post, notice: "Comment added!" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render "create" } # 失败时可以在 turbo_stream 里展示错误
        format.html { render "posts/show", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: "Comment deleted!" }
      end
    else
      redirect_to @post, alert: "You can only delete your own comments."
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
