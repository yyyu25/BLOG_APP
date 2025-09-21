class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
  @post = Post.find(params[:post_id])
  @comment = @post.comments.build(comment_params)
  @comment.user = current_user


  if @comment.save
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @post, notice: "Comment added!" }
    end
  else
    respond_to do |format|
      format.turbo_stream { render "create" }
      format.html { render "posts/show", status: :unprocessable_entity }
    end
  end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post  
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
  def comment_params
    params.require(:comment).permit(:body)
  end

end
