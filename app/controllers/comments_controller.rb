class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to tweet_path(@comment.tweet)
    else
      @tweet = @comment.tweet
      @comments = @tweet.comment
      render 'tweets/show'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], tweet_id: params[:tweet_id])
    @comment.destroy
    redirect_to tweet_path(@comment.tweet)
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
