if Rails.env.development? || Rails.evn.test? 
  require 'factory_bot'

  namespace :dev do
    desc "This will add some development data " 
      task populate: 'db:migrate:reset' do
        include FactoryBot::Syntax::Methods
        u = create(:user, email: 's@me.com')
        create(:post, author: u)
        5.times do
          create(:user) do |user|
              2.times {user.posts.create(attributes_for :post)}
              create(:friendship)
          end
        end
      end
  end
end