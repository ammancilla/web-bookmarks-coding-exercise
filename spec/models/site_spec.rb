require 'rails_helper'
require 'models/concerns/url_attributes'

describe Site, type: :model do
  it_behaves_like 'class with URL attributes', [:url]

  let!(:url) { 'https://example.com/apolonio' }
  let!(:site) { create(:site, url: url) }

  context 'callbacks' do
    describe 'before_save: :format_url' do
      it 'assigns properly the site url' do
	expect(site.url).to eq('https://example.com')
      end
    end
  end

  describe '.address_from_url' do
    subject { Site.address_from_url(url) }

    it { is_expected.to eq('https://example.com') }
  end
end
