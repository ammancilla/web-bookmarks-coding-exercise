require 'rails_helper'
require 'models/concerns/url_attributes'

describe Site, type: :model do
  it_behaves_like 'class with URL attributes', [:url]

  context 'callbacks' do
    let!(:site) { create(:site, url: 'https://example.com/apolonio') }

    describe 'before_save: :format_attributes' do
      it 'assings :protocol' do
	expect(site.protocol).to eq('https')
      end

      it 'assings :hostname' do
	expect(site.hostname).to eq('example.com')
      end
    end
  end
end
