class CommentsController < ApplicationController
  before_action :load_article
  before_action :authenticate_user!

  load_and_authorize_resource

  def create
    @comment = @article.comments.new(comment_params)
    @comment.email = current_user.email
    @comment.user = current_user
    if @comment.save
      redirect_to @article
    else
      redirect_to @article, alert: 'Unable to add comment'
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to @article, notice: 'Comment Deleted'
  end

  private

  def load_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:email, :body)
  end
end
