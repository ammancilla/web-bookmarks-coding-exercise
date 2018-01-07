class Bookmark < ApplicationRecord
  # External
  include UrlHandler

  # Associations
  belongs_to :site, counter_cache: true
end
