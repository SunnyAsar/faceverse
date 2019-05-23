if Rails.env.development? || Rails.evn.test? 
  require 'factory_bot'

  namespace :dev do
    desc "This will add some development data " 
      task populate: 'db:migrate:reset' do
        include FactoryBot::Syntax::Methods
        create(:user, email: 's@me.com')
        5.times do
          create(:user)
        end
      end
  end
end