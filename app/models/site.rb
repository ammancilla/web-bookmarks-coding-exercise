class Site < ApplicationRecord
  include UrlAttributes

  # External
  url_attributes :url

  # Associations
  has_many :bookmarks, dependent: :delete_all

  # Validations
  validates :url, presence: true

  # Callbacks
  before_validation :format_url

  # Methods
  def self.address_from_url(url)
    uri = URI.parse(url)
    "#{uri.scheme}://#{uri.host}"
  rescue URI::InvalidURIError
    url
  end

  private

  def format_url
    self.url = Site.address_from_url(url)
  end
end
