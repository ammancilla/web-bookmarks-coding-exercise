require 'rails_helper'
require 'models/concerns/url_attributes_spec'

describe Bookmark, type: :model do
  context 'callbacks' do
    let!(:bookmark) { build(:bookmark, url: 'http://apo.co/oinolopa') }

    describe 'before_validation: :assign_site' do
      it "creates a Site if it doesn't exists" do
        expect { bookmark.valid? }.to change { Site.count }.from(0).to(1)
      end

      it 'assigns the proper site' do
        expect { bookmark.valid? }.to change { bookmark.site }.from(nil).to(Site)
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

  it_behaves_like 'class with URL attributes', [:url, :shortening]
end