require 'uri'

module UrlAttributes
  extend ActiveSupport::Concern

  included do
    @@url_attrs = []

    # Callbacks
    before_validation :downcase_url_attrs

    # Methods
    def downcase_url_attrs
      @@url_attrs.each do |attr|
        attr_value = self.send(attr)

        if attr_value.present?
          self.send("#{attr}=", attr_value.downcase)
        end
      end
    end
  end

  class_methods do
    #
    # Allow defining URL attributes at class level.
    #
    def url_attributes(*attrs)
      @@url_attrs += attrs
      @@url_attrs.uniq!

      instance_eval do
        validates *@@url_attrs, uniqueness: { case_sensitive: false }, allow_blank: true
        validates *@@url_attrs, format: { with: URI.regexp( %w(http https) ) }, allow_blank: true
      end
    end
  end
end
