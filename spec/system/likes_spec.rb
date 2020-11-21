require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.create(:tweet)
  end

  it 'ログインしたユーザーはツイート詳細ページでいいねできる' do
    # ログインする
    sign_in(@user)
    # ツイート詳細ページに遷移する
    visit tweet_path(@tweet)
    # 投稿にいいねする
    click_on('♡')
    # いいねすると、likeモデルのカウントが1上がることを確認する
    expect do
      click_on('♡')
    end.to change { Like.count }.by(1)
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content(@tweet.likes.count)
  end
end
