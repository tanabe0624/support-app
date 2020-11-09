class Tweet < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category

  belongs_to :user
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :text
    validates :category_id, numericality: { other_than: 1 }
  end
end
