# frozen_string_literal: true

module ApplicationHelper
  def random_bulma_color
    %w[black dark light white primary link info success warning danger].sample
  end

  def random_bulma_color_class
    'is-' + random_bulma_color
  end
end
