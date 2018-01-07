class Site < ApplicationRecord
  # External
  include UrlHandler

  # Enums
  enum protocol: [ :http, :https ]

  # Associations
  has_many :bookmarks

  # Callbacks
  before_save :format_attributes

  # Methods
  private

  def format_attributes
    uri = URI.parse(url)
    self.protocol = uri.scheme
    self.hostname = uri.hostname
  end
end
