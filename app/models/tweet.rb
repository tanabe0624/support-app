class Tweet < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category

  belongs_to :user

  with_options presence: true do
    validates :title
    validates :text
    validates :category_id, numericality: { other_than: 1 }
  end
end
