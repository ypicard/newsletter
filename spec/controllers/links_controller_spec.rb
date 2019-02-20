# frozen_string_literal: true

RSpec.describe LinksController, type: :controller do
  before(:each) do
    @user = User.create!(email: 'lewarthog@hotmail.com', username: 'lewarthog', password: 'lewarthog')
    @other_user = User.create!(email: 'other@hotmail.com', username: 'other', password: 'otherother')
    @community = Community.create!(name: 'My community', creator: @user, users: [@user])
    sign_in(@user)
  end

  context 'belongs to community' do
    it 'can post' do
      post :create, params: { community_id: @community.id, link: { url: 'https://www.theverge.com' } }
      expect(response).to render_template(:create)
      expect(@user.links.size).to be(1)
      expect(@community.links.size).to be(1)
    end
  end

  context 'does not belong to community' do
    it 'can\'t post' do
      sign_in @other_user
      post :create, params: { community_id: @community.id, link: { url: 'https://www.theverge.com' } }
      expect(flash[:warning]).to match(/You do not have access to this community/)
      expect(@other_user.links).to be_empty
      expect(@community.links).to be_empty
    end
  end

  it 'can\'t post duplicate links' do
    post :create, params: { community_id: @community.id, link: { url: 'https://www.theverge.com' } }
    expect(flash[:warning]).to be_nil
    expect(response).to render_template(:create)
    post :create, params: { community_id: @community.id, link: { url: 'https://www.theverge.com' } }
    expect(response).to render_template(:new)
  end
end
