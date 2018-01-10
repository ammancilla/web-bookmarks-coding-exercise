require 'rails_helper'

feature 'visiting landing page' do
  scenario 'browsing' do
    visit '/'

    expect(page).to have_content('New Bookmark')
    expect(page).to have_content('Search Bookmarks')
    expect(page).to have_css('form#new_bookmark')
    expect(page).to have_css(".searchbox form[action='/search']")
  end

  context 'no bookmarks in the page' do
    scenario 'browsing' do
      visit '/'

      expect(page).to_not have_selector('table tbody tr')
    end
  end

  context 'with bookmarks in the page' do
    background { create_list(:bookmark, 3)  }

    scenario 'browsing' do
      visit '/'

      expect(page).to have_selector('table tbody tr', count: 3)
    end
  end
end
