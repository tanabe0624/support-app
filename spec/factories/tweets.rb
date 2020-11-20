FactoryBot.define do
  factory :tweet do
    title {Faker::Lorem.sentence}
    text {Faker::Lorem.sentence}
    category_id { '2' }
    association :user
  end
end
