# frozen_string_literal: true

module CommunitiesHelper
  def background_color(community)
    idx = (community.name.size * community.description.size) % BULMA_COLORS.size
    BULMA_COLORS[idx]
  end

  def background_color_class(community)
    'is-' + background_color(community)
  end
end
