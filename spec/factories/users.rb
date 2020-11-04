FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password = 'abc123'
    password { password }
    password_confirmation { password }
    age_id { '2' }
    gender_id { '2' }
    occupation_id { '2' }
  end
end
