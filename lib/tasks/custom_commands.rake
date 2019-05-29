# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  require 'factory_bot'

  namespace :dev do
    desc 'This will add some development data '
    task populate: 'db:migrate:reset' do
      include FactoryBot::Syntax::Methods
      u = create(:user, email: 's@me.com')
      create(:post, author: u)
      10.times do
        create(:user) do |user|
          2.times { user.posts.create(attributes_for(:post)) }
        end
      end
      2.times { create(:post, author: u) }
      u.direct_friends += User.all.sample(5).reject { |user_i| user_i.id == u.id }
      other_users = User.where.not(id: (u.friends.map(&:id) << u.id)).sample(3)
      u.friends_requesting += other_users
    end
  end
end
