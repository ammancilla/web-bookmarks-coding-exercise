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
    return if url.nil?

    uri = URI.parse(url)

    unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      return
    end

    "#{uri.scheme}://#{uri.host}"
  end

  private

  def format_url
    address = Site.address_from_url(url)
    self.url = address unless address.nil?
  end
end
