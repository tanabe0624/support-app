class LikesController < ApplicationController
before_action :set_tweet, only: [:create, :destroy]

  def create
    @like = current_user.likes.build(tweet_id: params[:tweet_id], user_id: current_user.id)
    @like.save
  end

  def destroy
    @like = Like.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
    @like.destroy
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
