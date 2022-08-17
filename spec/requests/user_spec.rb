require 'rails_helper'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.describe UsersController, type: :request do

  it "creates a User and redirects to the User's page" do
    get '/users/new'
    expect(response).to render_template(:new)

    VCR.use_cassette('Controller Test') do
      post '/users', params: { user: { username: 'DonaldDumb' } }
    end

    expect(response).to have_http_status(:ok)
  end

  it 'does not render a different template' do
    get '/users/new'
    expect(response).to_not render_template(:show)
  end
end