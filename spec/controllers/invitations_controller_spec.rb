# frozen_string_literal: true

RSpec.describe InvitationsController, type: :controller do
  before(:each) do
    @user = User.create!(email: 'lewarthog@hotmail.com', username: 'lewarthog', password: 'lewarthog')
    @other_user = User.create!(email: 'other@hotmail.com', username: 'other', password: 'otherother')
    @community = Community.create!(name: 'My community', creator: @other_user, users: [@other_user])
    @invitation = Invitation.create!(sender: @other_user, email: @user.email, user: @user, community: @community)
    sign_in(@user)
  end

  context 'pending invitations' do
    it 'accepts' do
      post :accept, params: { id: @invitation.id }
      expect(@invitation.reload.accepted?).to be true
    end

    it 'joins community on accept' do
      post :accept, params: { id: @invitation.id }
      expect(@user.communities).to include(@community)
    end

    it 'rejects' do
      post :reject, params: { id: @invitation.id }
      expect(@invitation.reload.rejected?).to be true
    end

    it 'does not join community on reject' do
      post :reject, params: { id: @invitation.id }
      expect(@user.communities).to be_empty
    end
  end

  context 'revoked invitation' do
    it 'cannot do anything' do
      @invitation.revoke
      @invitation.save
      post :accept, params: { id: @invitation.id }
      expect(@invitation.reload.accepted?).to be false
      expect(flash[:warning]).to match(/You do not have access to this invitation*/)
    end
  end

  context 'user does not have access to invitation' do
    it 'can\'t access' do
      sign_in(@other_user)
      post :accept, params: { id: @invitation.id }
      expect(@invitation.reload.accepted?).to be false
      expect(flash[:warning]).to match(/You do not have access to this invitation*/)
    end
  end
end
