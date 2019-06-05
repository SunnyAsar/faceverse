require 'faker'

FactoryBot.define do
  factory :user, aliases: %i[author commenter friend sender receiver] do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'foobar' }
    password_confirmation { 'foobar' }

    factory :user_with_friends do
      transient { count { 3 } }

      after :create do |user, vars|
        create_list(:friendship, vars.count, user: user)
      end
    end

    factory :user_with_relations do
      transient do
        friends_count { 3 }
        sent_friend_requests_count { 3 }
        received_friend_requests_count { 3 }
      end

      after :create do |user, vars|
        create_list(:friendship, vars.friends_count, user: user)
        create_list(:friend_request, vars.sent_friend_requests_count, sender: user)
        create_list(:friend_request, vars.received_friend_requests_count, receiver: user)
      end
    end
  end

  factory :post do
    content { Faker::ChuckNorris.fact }
    author

    factory :invalid_post do
      content { '' }
    end
  end

  factory :comment do
    content { Faker::Hacker.say_something_smart }
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
