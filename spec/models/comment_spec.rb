require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#create' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    it 'textが存在していれば保存できること' do
      expect(@comment).to be_valid
    end

    it 'textが空では保存できないこと' do
      @comment.text = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("テキストを入力してください")
    end

    it 'userが紐づいていないと保存できないこと' do
      @comment.user = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Userを入力してください")
    end

    it 'tweetが紐づいていないと保存できないこと' do
      @comment.tweet = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Tweetを入力してください")
    end

  end
end
