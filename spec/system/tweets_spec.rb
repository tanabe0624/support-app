require 'rails_helper'

RSpec.describe "ツイート投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.create(:tweet)
    # @tweet_title = Faker::Lorem.sentence
    # @tweet_text = Faker::Lorem.sentence
    # @tweet_category_id = "2"
  end
  context 'ツイート投稿ができる時' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('新規投稿')
      # 投稿ページに移動する
      visit new_tweet_path
      # フォームに情報を入力する
      fill_in 'tweet_title', with: @tweet.title
      fill_in 'tweet_text', with: @tweet.text
      select '人間関係', from: '悩みの種類'
      select '健康', from: '悩みの種類'
      select 'お金', from: '悩みの種類'
      select '子育て', from: '悩みの種類'
      select '夫婦仲', from: '悩みの種類'
      select '介護', from: '悩みの種類'
      select '恋愛', from: '悩みの種類'
      select 'その他', from: '悩みの種類'
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        click_on('送信')
      }.to change { Tweet.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のタイトルが存在することを確認する
      expect(page).to have_content(@tweet.title)
      # トップページには先ほど投稿した内容のテキストが存在することを確認する
      expect(page).to have_content(@tweet.text)
      # トップページには先ほど投稿したツイートにニックネームが存在することを確認する
      expect(page).to have_content(@tweet.user.nickname)
      # トップページには先ほど投稿したツイートに年齢が存在することを確認する
      expect(page).to have_content(@tweet.user.age.name)
      # トップページには先ほど投稿したツイートに性別が存在することを確認する
      expect(page).to have_content(@tweet.user.gender.name)
    end
  end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('新規投稿')
    end
  end
end

RSpec.describe 'ツイート編集', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit root_path
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      click_on("送信")
      expect(current_path).to eq root_path
      # 投稿詳細ページに遷移する
      visit tweet_path(@tweet1)
      # ツイート1に「編集」ボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#tweet_title').value
      ).to eq @tweet1.title
      expect(
        find('#tweet_text').value
      ).to eq @tweet1.text
      expect(page).to have_select('悩みの種類', selected: '人間関係')
      # 投稿内容を編集する
      fill_in 'tweet_title', with: "#{@tweet1.title}+編集したタイトル"
      fill_in 'tweet_text', with: "#{@tweet1.text}+編集したテキスト"
      select 'お金', from: '悩みの種類'
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        click_on('送信')
      }.to change { Tweet.count }.by(0)
      # 投稿詳細ページに遷移する
      visit tweet_path(@tweet1)
      # 投稿詳細ページには先ほど変更した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content("#{@tweet1.title}+編集したタイトル")
      # 投稿詳細ページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content("#{@tweet1.text}+編集したテキスト")
      # 投稿詳細ページには先ほど変更した内容のツイートが存在することを確認する（悩みの種類）
      expect(page).to have_content("お金")
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      visit root_path
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      click_on("送信")
      expect(current_path).to eq root_path
      # 投稿詳細ページに遷移する
      visit tweet_path(@tweet2)
      # ツイート2に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('編集')
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 投稿詳細ページに遷移する
      visit tweet_path(@tweet1)
      # ツイート1に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('編集')
      # ツイート2に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('編集')
    end
  end
end

RSpec.describe 'ツイート削除', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイート削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したツイートの削除ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit root_path
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      click_on("送信")
      expect(current_path).to eq root_path
      # 投稿詳細ページに遷移する
      visit tweet_path(@tweet1)
      # ツイート1に「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        click_on('削除')
      }.to change { Tweet.count }.by(-1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページにはツイート1の内容が存在しないことを確認する（タイトル）
      expect(page).to have_no_content("#{@tweet1.title}")
      # トップページにはツイート1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content("#{@tweet1.text}")
      # トップページにはツイート1の内容が存在しないことを確認する（悩みの種類）
      expect(page).to have_no_content("#{@tweet1.category_id}")
    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # ツイート1を投稿したユーザーでログインする
      visit root_path
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      click_on("送信")
      expect(current_path).to eq root_path
      # 投稿詳細ページに遷移する
      visit tweet_path(@tweet2)
      # ツイート2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # ツイート１の投稿詳細ページに遷移する
      visit tweet_path(@tweet1)
      # ツイート1に「削除」ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
      # トップページに移動する
      visit root_path
      # ツイート２の投稿詳細ページに遷移する
      visit tweet_path(@tweet2)
      # ツイート2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
    end
  end
end

RSpec.describe 'ツイート詳細', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.create(:tweet)
  end
  it 'ログインしたユーザーはツイート詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    sign_in(@user)
    # ツイートに「詳しく見る」ボタンがあることを確認する
    expect(page).to have_content('詳しく見る >>')
    # 詳細ページに遷移する
    visit tweet_path(@tweet)
    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_content(@tweet.title)
    expect(page).to have_content(@tweet.text)
    expect(page).to have_content(@tweet.category.name)
    expect(page).to have_content(@tweet.user.nickname)
    expect(page).to have_content(@tweet.user.age.name)
    expect(page).to have_content(@tweet.user.gender.name)
    expect(page).to have_content(@tweet.user.occupation.name)
    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態でツイート詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # ツイートに「詳しく見る」ボタンがあることを確認する
    expect(page).to have_content('詳しく見る >>')
    # 詳細ページに遷移する
    visit tweet_path(@tweet)
    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_content(@tweet.title)
    expect(page).to have_content(@tweet.text)
    expect(page).to have_content(@tweet.category.name)
    expect(page).to have_content(@tweet.user.nickname)
    expect(page).to have_content(@tweet.user.age.name)
    expect(page).to have_content(@tweet.user.gender.name)
    expect(page).to have_content(@tweet.user.occupation.name)
    # フォームが存在しないことを確認する
    expect(page).to have_no_content('コメントする')
    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content('コメントの投稿には新規登録/ログインが必要です')
  end
end