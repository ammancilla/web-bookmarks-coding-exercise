require 'rails_helper'
require 'models/concerns/url_attributes_spec'

describe Site, type: :model do
  let!(:site) { create(:site, url: 'https://example.com/apolonio') }

  context 'callbacks' do
    describe 'before_save: :format_attributes' do
      it 'assings :protocol' do
	expect(site.protocol).to eq('https')
      end

      it 'assings :hostname' do
	expect(site.hostname).to eq('example.com')
      end
    end
  end

  it_behaves_like 'class with URL attributes', [:url]
end
