# frozen_string_literal: true

RSpec.describe CommunitiesController do
  before(:each) do
    @user = User.create!(email: 'lewarthog@hotmail.com', username: 'lewarthog', password: 'lewarthog')
    @other_user = User.create!(email: 'other@hotmail.com', username: 'other', password: 'otherother')
    @community = Community.create!(name: 'My community', creator: @user, users: [@user])
    sign_in(@user)
  end

  context 'belongs to community' do
    it 'can access' do
      get :show, params: { id: @community.id }
      expect(response).to render_template(:show)
    end

    it 'can invite' do
      post :create_invitation, params: { community_id: @community.id, invitation: { handle: 'test@email.com' } }
      expect(response).to render_template(:invitations)
    end

    it 'sends email on invite'
  end

  context 'does not belong to community' do
    it 'can\'t access' do
      other_community = Community.create!(name: 'Other community', creator: @other_user)
      get :show, params: { id: other_community.id }
      expect(response).to render_template(:index)
    end
  end

  context 'user exists' do
    it 'invites on email' do
      post :create_invitation, params: { community_id: @community.id, invitation: { handle: @other_user.email } }
      expect(@other_user.invitations.size).to eq(1)
    end

    it 'invites on username' do
      post :create_invitation, params: { community_id: @community.id, invitation: { handle: @other_user.username } }
      expect(@other_user.invitations.size).to eq(1)
    end
  end

  context 'user does not exist' do
    context 'handle is email' do
      it 'sends email'

      it 'links invitation when user created' do
        post :create_invitation, params: { community_id: @community.id, invitation: { handle: 'some_user@email.com' } }
        some_user = User.create!(username: 'some_user', email: 'some_user@email.com', password: 'password')
        expect(some_user.invitations.size).to eq(1)
      end
    end

    context 'handle is username' do
      it 'does nothing' do
        post :create_invitation, params: { community_id: @community.id, invitation: { handle: 'random' } }
        expect(response).to render_template(:new_invitation)
      end
    end
  end

  context 'is invitation sender' do
    it 'can revoke' do
      invitation = Invitation.create!(sender: @user, email: @other_user.email, user: @other_user, community: @community)
      post :revoke_invitation, params: { community_id: @community.id, id: invitation.id }
      expect(invitation.reload.revoked?).to be true
    end
  end

  context 'is not invitation sender' do
    it 'can\'t revoke' do
      invitation = Invitation.create!(sender: @other_user, email: @user.email, user: @user, community: @community)
      post :revoke_invitation, params: { community_id: @community.id, id: invitation.id }
      expect(invitation.reload.revoked?).to be false
    end
  end
end
