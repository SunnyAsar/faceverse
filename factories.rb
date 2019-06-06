require 'faker'

FactoryBot.define do
  factory :user, aliases: %i[author commenter friend sender receiver liker] do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'foobar' }
    password_confirmation { 'foobar' }

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

    factory :user_with_posts_comments_and_likes do
      transient do
        posts_count { 3 }
        liked_count { 3 }
        comment_count { 3 }
      end

      after :create do |user, vars|
        create_list(:post_with_likes, vars.posts_count, author: user)
        create_list(:like, vars.liked_count, :for_post, liker: user)
        create_list(:like, vars.liked_count, :for_comment, liker: user)
        create_list(:comment_with_likes, vars.comment_count, commenter: user)
      end
    end
  end

  factory :post do
    content { Faker::ChuckNorris.fact }
    author

    factory :invalid_post do
      content { '' }
    end

    factory :post_with_likes do
      transient { count { 3 } }

      after :create do |post, vars|
        create_list(:like, vars.count, :for_post, likeable: post)
      end
    end
  end

  factory :comment do
    content { Faker::Hacker.say_something_smart }
    commenter
    post

    factory :invalid_comment do
      content { '' }
    end

    factory :comment_with_likes do
      after :create do |comment|
        create_list(:like, 2, :for_comment, likeable: comment)
      end
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
    liker
    for_post

    trait :for_post do
      association :likeable, factory: :post
    end

    trait :for_comment do
      association :likeable, factory: :comment
    end
  end
end
