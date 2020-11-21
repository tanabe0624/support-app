require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nickname,email,password,password_confirmation,age_id,gender_id,occupation_idがあれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('ニックネームを入力してください')
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールを入力してください')
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end

    it 'emailに@が含まれていない場合は登録できないこと' do
      @user.email = 'abcdefg'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードを入力してください')
    end

    it 'passwordが6文字以上であれば登録できること' do
      @user.password = 'aaa456'
      @user.password_confirmation = 'aaa456'
      expect(@user).to be_valid
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = 'aa345'
      @user.password_confirmation = 'aa345'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = 'aaa456'
      @user.password_confirmation = 'aaa4567'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end

    it 'passwordが半角英数字混合での入力であれば登録できること' do
      @user.password = 'aaa456'
      @user.password_confirmation = 'aaa456'
      expect(@user).to be_valid
    end

    it 'passwordが半角英数字混合での入力でなければ登録できないこと' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて設定してください')
    end

    it 'passwordが半角英数字混合での入力でなければ登録できないこと' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて設定してください')
    end

    it 'age_idが空では保存できないこと' do
      @user.age_id = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('年齢を入力してください', '年齢は数値で入力してください')
    end

    it 'age_idが1では保存できないこと' do
      @user.age_id = 1
      @user.valid?
      expect(@user.errors.full_messages).to include('年齢は1以外の値にしてください')
    end

    it 'gender_idが空では保存できないこと' do
      @user.gender_id = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('性別を入力してください', '性別は数値で入力してください')
    end

    it 'gender_idが1では保存できないこと' do
      @user.gender_id = 1
      @user.valid?
      expect(@user.errors.full_messages).to include('性別は1以外の値にしてください')
    end

    it 'occupation_idが空では保存できないこと' do
      @user.occupation_id = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('職業を入力してください', '職業は数値で入力してください')
    end

    it 'occupation_idが1では保存できないこと' do
      @user.occupation_id = 1
      @user.valid?
      expect(@user.errors.full_messages).to include('職業は1以外の値にしてください')
    end
  end
end
