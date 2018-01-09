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
  scope :by_title, -> (title) { where("title LIKE ?", "%#{title}%") }
  scope :by_url, -> (url) { where("url LIKE ?", "%#{url}%") }
  scope :by_shortening, -> (shortening) { where("title LIKE ?'", "%#{shortening}%") }

  # Methods
  def self.chain_scopes(scopes)
    return [] if scopes.blank?

    scopes.inject(self) do |chain, skope|
      scope_name = "by_#{skope[0]}"
      scope_param = skope[1]

      chain.send(scope_name, scope_param)
    end
  end

  private

  def assign_site
    self.site = Site.find_or_create_by(url: url)
  end
end
