require 'uri'

module UrlHandler
  extend ActiveSupport::Concern

  included do

    # Validations
    validates :url, presence: true
    validates :url, uniqueness: { case_sensitive: false }
    validates :url, format: { with: URI.regexp( %w(http https) ) }

    # Callbacks
    before_save :format_url

    # Methods
    private

    def format_url
      self.url = url.downcase
    end
  end
end
