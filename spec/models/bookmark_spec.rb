require 'rails_helper'
require 'models/concerns/url_attributes_spec'

describe Bookmark, type: :model do
  it_behaves_like 'class with URL attributes', [:url, :shortening]
end
