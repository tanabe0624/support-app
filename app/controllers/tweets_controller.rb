class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: :edit

  def index
    @tweets = Tweet.all.page(params[:page]).per(9).includes(:user).order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    return redirect_to root_path if @tweet.save
    
    render :new
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
    @like = Like.new
  end

  def update
    return redirect_to tweet_path(@tweet.id) if @tweet.update(tweet_params)
    
    render :edit
  end

  def destroy
    if user_signed_in? && current_user.id == @tweet.user_id
      @tweet.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def search
    @tweets = Tweet.search(params[:keyword]).includes(:user).order('created_at DESC')
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :text, :category_id).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless current_user.id == @tweet.user_id
  end
end
