require 'rails_helper'

feature 'searching bookmarks' do
  context 'by single attribute' do
    background do
      create_list(:bookmark, 5)
    end

    scenario 'searching bookmark by Title' do
      create(:bookmark, title: 'Find me')

      visit '/'

      expect(page).to have_css('table tbody tr', count: 6)

      within '.searchbox form' do
        fill_in 'Title', with: 'Find me'

        click_button('Search')
      end

      expect(page).to have_css('table tbody tr', count: 1)
      expect(page).to have_content('Find me')
    end

    scenario 'searching bookmark by URL' do
    end

    scenario 'searching bookmark by Shortening' do
    end
  end

  context 'by combined attributes' do
    scenario 'searching bookmark by Title and URL' do
    end
  end
end
