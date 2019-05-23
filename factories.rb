require  'faker'

FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password {'foobar'}
    password_confirmation {'foobar'}
  end

  factory :post do
    content { Faker::ChuckNorris.fact}
    association :author, factory: :user
  end

  factory :friendship do 
    association :user, factory: :user
    association :friend, factory: :user
  end

end