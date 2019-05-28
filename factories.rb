require 'faker'

FactoryBot.define do
  factory :user, aliases: %i[author commenter friend sender receiver] do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end

  factory :post do
    content { Faker::ChuckNorris.fact }
    author

    factory :invalid_post do
      content { '' }
    end
  end

  factory :comment do
    content { Faker::Lorem.sentences(1) }
    commenter
    post

    factory :invalid_comment do
      content { '' }
    end
  end

  factory :friendship do
    user
    friend
  end

  factory :friend_request do
    sender
    receiver
  end

  factory :like do
    for_post

    trait :for_post do
      association :likeable, factory: :post
    end

    trait :for_comment do
      association :likeable, factory: :comment
    end
  end
end
