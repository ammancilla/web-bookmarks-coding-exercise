class Site < ApplicationRecord
  # Associations
  has_many :bookmarks, dependent: :delete_all

  # Validations
  validates :url, presence: true
  validates :url, uniqueness: { case_sensitive: false }, allow_blank: true
  validates :url, format: { with: URI.regexp( %w(http https) ) }, allow_blank: true

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
    self.url = url&.downcase

    address = Site.address_from_url(url)
    self.url = address unless address.nil?
  end
end
