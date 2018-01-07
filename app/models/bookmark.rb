class Bookmark < ApplicationRecord
  # External
  include UrlHandler

  # Associations
  belongs_to :site, counter_cache: true

  # Validations
  validates :title, presence: true
  validates :shortening, format: { with: URI.regexp( %w(http https) ) }, allow_blank: true
end
