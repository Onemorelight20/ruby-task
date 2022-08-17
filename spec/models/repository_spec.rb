require 'rails_helper'

RSpec.describe Repository, type: :model do
  context 'validation tests' do
    it 'ensures repo title presence' do
      user = User.new(username: 'Donald')
      user.save
      expect { user.repositories.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should save successfully' do
      user = User.new(username: 'Hewlett Frank')
      user.save
      repo = user.repositories.create!(title: 'Interesting task really')
      expect(user.reload.repositories).to eq([repo])
    end
  end

end
