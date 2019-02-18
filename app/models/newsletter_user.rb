class NewsletterUser < ApplicationRecord
    belongs_to :newsletter
    belongs_to :user
end
