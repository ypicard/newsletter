# frozen_string_literal: true

RSpec.describe Community do
  before(:each) do
    @user = User.create!(email: 'lewarthog@hotmail.com', username: 'lewarthog', password: 'lewarthog')
    @community = Community.create!(name: 'My community', creator: @user, users: [@user])
    sign_in(@user)
  end

  it 'creates a newsletter if not already existing'
  it 'updates existing newsletters'
  it 'does not update already delivered newsletters'
  it 'sets delivered to true only if email successfully sent'
end
