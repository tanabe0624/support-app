class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true # 一意性であること
  validates :nickname, presence: true

  with_options presence: true, numericality: { other_than: 1 } do
    validates :gender_id
    validates :age_id
    validates :occupation_id
  end
   # このバリデーションは、各idのid:1以外のときに保存できるという意味


  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
  # 上記２行でパスワードは、半角英数字混合での入力が必須であることの実装

  has_many :tweets

end
