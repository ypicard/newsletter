# frozen_string_literal: true

module ApplicationHelper

  def random_bulma_color_class
    'is-' + BULMA_COLORS.sample
  end

end
