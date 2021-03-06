require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe '#create' do
    before do
      @tweet = FactoryBot.build(:tweet)
    end

    it 'title,text,category_idが存在していれば保存できること' do
      expect(@tweet).to be_valid
    end

    it 'titleが空では保存できないこと' do
      @tweet.title = nil
      @tweet.valid?
      expect(@tweet.errors.full_messages).to include('タイトルを入力してください')
    end

    it 'textが空では保存できないこと' do
      @tweet.text = nil
      @tweet.valid?
      expect(@tweet.errors.full_messages).to include('テキストを入力してください')
    end

    it 'category_idが空では保存できないこと' do
      @tweet.category_id = nil
      @tweet.valid?
      expect(@tweet.errors.full_messages).to include('悩みの種類を入力してください')
    end

    it 'cateogry_idが1では保存できないこと' do
      @tweet.category_id = 1
      @tweet.valid?
      expect(@tweet.errors.full_messages).to include('悩みの種類は1以外の値にしてください')
    end

    it 'userが紐付いていないと保存できないこと' do
      @tweet.user = nil
      @tweet.valid?
      expect(@tweet.errors.full_messages).to include('Userを入力してください')
    end
  end
end
