require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures username presence' do
      user = User.new().save
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(username: 'PeterParker').save
      expect(user).to eq(true)
    end
  end

  context 'has many repositories tests' do
    it 'should have 2 repositories' do
      user = User.new(username: 'Penny')
      user.save
      repo1 = user.repositories.create!(:title => 'first repo')
      repo2 = user.repositories.create!(:title => 'second repo')
      expect(user.reload.repositories).to match_array([repo2, repo1])
    end
  end

  context 'scope tests' do
    let(:params) { {username: "Eminem"} }
    before(:each) do
      User.new(params).save
      User.new(params).save
      User.new(params).save
      User.new(params).save
      User.new(params).save
    end

    it 'should save 5 users' do
      expect(User.count).to eq(5)
    end
  end
end
