class Bookmark < ApplicationRecord
  # External
  include UrlAttributes

  url_attributes :url, :shortening

  # Associations
  belongs_to :site, counter_cache: true
  accepts_nested_attributes_for :site

  # Validations
  validates :title, :url, presence: true
end
