require  'faker'

FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password {'foobar'}
    password_confirmation {'foobar'}
  end

end