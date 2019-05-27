# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  require 'factory_bot'

  namespace :dev do
    desc 'This will add some development data '
    task populate: 'db:migrate:reset' do
      include FactoryBot::Syntax::Methods
      u = create(:user, email: 's@me.com')
      create(:post, author: u)
      5.times do
        create(:user) do |user|
          2.times { user.posts.create(attributes_for(:post)) }
          user.direct_friends += User.all.reject { |user_i| user_i.id == user.id }
        end
      end
    end
  end
end
