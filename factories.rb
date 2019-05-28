require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end

  factory :post do
    content { Faker::ChuckNorris.fact }
    association :author, factory: :user
  end

  factory :invalid_post, class: :post do
    content { '' }
  end

  factory :friendship do
    association :user, factory: :user
    association :friend, factory: :user
  end
end
