require 'helpers/github_helper'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.describe GitHubHelper, type: :helper do

  let(:test_class) { Class.new { extend GitHubHelper } }

  describe 'test with existing user' do
    it 'returns response status 200' do
      username = 'Onemorelight20'
      VCR.use_cassette('Users get request test') do
        response = test_class.users_get_request(username)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'test with non-existing user' do
    it 'returns response status 404' do
      username = 'Onemorelight202424424242'
      VCR.use_cassette('Non-existing users get request test') do
        response = test_class.users_get_request(username)
        expect(response.status).to eq(404)
      end
    end
  end

end

