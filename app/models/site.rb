class Site < ApplicationRecord
  # External
  include UrlAttributes

  url_attributes :url

  # Enums
  enum protocol: [ :http, :https ]

  # Associations
  has_many :bookmarks, dependent: :delete_all

  # Validations
  validates :url, presence: true

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
