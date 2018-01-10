class Bookmark < ApplicationRecord
  include UrlAttributes

  # External
  url_attributes :url, :shortening

  # Associations
  belongs_to :site, counter_cache: true

  # Validations
  validates :title, :url, presence: true

  # Callbacks
  before_validation :assign_site

  # Scopes
  scope :recents, -> { order(created_at: :desc) }
  scope :title, -> (title) { where("title LIKE ?", "%#{title}%") }
  scope :url, -> (url) { where("url LIKE ?", "%#{url}%") }
  scope :shortening, -> (shortening) { where("shortening LIKE ?", "%#{shortening}%") }

  # Methods
  def self.chain_scopes(scopes)
    return if scopes.blank?

    scopes.inject(self) do |chain, skope|
      scope_name, scope_param = skope[0], skope[1]
      chain.send(scope_name, scope_param)
    end
  end

  private

  def assign_site
    site_url = Site.address_from_url(url)

    return if site_url.nil?

    self.site = Site.find_or_create_by(url: site_url)
  end
end
