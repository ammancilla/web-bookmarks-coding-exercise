require 'rails_helper'
require 'models/concerns/url_attributes'

describe Bookmark, type: :model do
  it_behaves_like 'class with URL attributes', [:url, :shortening]

  context 'callbacks' do
    let(:site) { create(:site, url: 'http://apo.co') }
    let!(:bookmark) { build(:bookmark, url: 'http://apo.co/oinolopa') }

    describe 'before_validation: :assign_site' do
      it "creates a Site if it doesn't exists" do
        expect { bookmark.valid? }.to change { Site.count }.from(0).to(1)
      end

      it "doesn't creates a Site if it exists" do
        site # First, create the site

        expect { bookmark.valid? }.to_not change { Site.count }
      end

      it 'assigns the proper site' do
        expect { bookmark.valid? }.to change { bookmark.site }.from(nil).to(site)
      end
    end
  end

  describe '.chain_scopes' do
    let!(:query) { "SELECT \"bookmarks\".* FROM \"bookmarks\" WHERE (title LIKE '%test%') AND (url LIKE '%apo.co%')" }

    subject { Bookmark.chain_scopes(title: 'test', url: 'apo.co') }

    it 'generates a single query' do
      expect( subject.to_sql ).to eq(query)
    end

    it { is_expected.to be_an(ActiveRecord::Relation)  }
  end
end
