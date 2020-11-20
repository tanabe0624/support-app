require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: @user.nickname
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in '確認用パスワード', with: @user.password
      select '男性', from: '性別'
      select '女性', from: '性別'
      select '選択しない', from: '性別'
      select '10代以下', from: '年齢'
      select '20代', from: '年齢'
      select '30代', from: '年齢'
      select '40代', from: '年齢'
      select '50代', from: '年齢'
      select '60代', from: '年齢'
      select '70代', from: '年齢'
      select '80代以上', from: '年齢'
      select '会社員', from: '職業'
      select '会社役員', from: '職業'
      select '自営業', from: '職業'
      select 'パート、アルバイト', from: '職業'
      select '専業主婦(夫)', from: '職業'
      select '公務員', from: '職業'
      select '学生', from: '職業'
      select 'その他', from: '職業'
      # サインアップボタンを押すとユーザーモデルのカウントが１上がることを確認する
      expect{
        click_on('送信')
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # ログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # 新規投稿ボタンが表示されることを確認する
      expect(page).to have_content('新規投稿')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: ""
      fill_in 'メールアドレス', with: ""
      fill_in 'パスワード', with: ""
      fill_in '確認用パスワード', with: ""
      select '', from: '性別', match: :first
      select '', from: '年齢', match: :first
      select '', from: '職業', match: :first
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        click_on('送信')
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      # ログインボタンを押す
      click_on('送信')
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # ログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # 新規投稿ボタンが表示されることを確認する
      expect(page).to have_content('新規投稿')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'メールアドレス', with: ""
      fill_in 'パスワード', with: ""
      # ログインボタンを押す
      click_on('送信')
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end
