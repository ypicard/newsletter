class NewsletterLink < ApplicationRecord
    belongs_to :newsletter
    belongs_to :link
end
