# frozen_string_literal: true

RSpec.describe Users::RegistrationsController, type: :controller do
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user] # Required for devise

    @user = User.create!(email: 'lewarthog@hotmail.com', username: 'lewarthog', password: 'lewarthog')
    @community = Community.create!(name: 'My community', creator: @user, users: [@user])
    @invitation = Invitation.create!(sender: @user, email: 'other@email.com', user: nil, community: @community)
  end

  it 'links invitations to new user based on token' do
    post :create, params: { user: { email: 'other@email.com', username: 'other_user', password: 'password', invitation_token: @invitation.token } }
    expect(User.where(email: 'other@email.com').first.invitations.count).to eq(1)
  end

  it 'does not link user to invitation if no token' do
    post :create, params: { user: { email: 'other@email.com', username: 'other_user', password: 'password' } }
    expect(User.where(email: 'other@email.com').first.invitations).to be_empty
  end

  it 'does not link invitation twice'
end
