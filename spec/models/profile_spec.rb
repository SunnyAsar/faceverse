require 'rails_helper'

RSpec.describe Profile, type: :model do

  context 'Association' do
    it { should belong_to(:user) }
  end

end
