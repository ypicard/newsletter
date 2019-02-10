# frozen_string_literal: true

class Link < ApplicationRecord
  validates :url, url: true
  validates :url, uniqueness: { scope: %i[url user_id community_id] }

  belongs_to :user
  belongs_to :community

  after_create :update_metadata

  private

  # Fetch link title, description, image preview using linkpreview api (https://www.linkpreview.net/docs)
  def update_metadata
    response = Net::HTTP.post(URI('https://api.linkpreview.net'),
                              { 'key' => ENV['LINKPREVIEW_API_KEY'],
                                'q' => self.url }.to_json)

    body = JSON.parse(response.body)
    self.lp_title = body['title']
    self.lp_url = body['url']
    self.lp_image = body['image']
    self.lp_image = body['image']
    self.lp_description = body['description']
    save
  end

end
