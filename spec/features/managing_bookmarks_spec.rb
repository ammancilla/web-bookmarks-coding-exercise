require 'rails_helper'

feature 'managing bookmarks' do
  given!(:bookmark) { create(:bookmark) }

  scenario 'creating a bookmark with with VALID data' do
    visit '/'

    within 'form#new_bookmark' do
      fill_in 'Title', with: 'Apolonio'
      fill_in 'Url', with: 'https://apo.co'

      click_button('Save')
    end

    expect(page).to have_content('Bookmark saved :)')
    expect(page).to have_content('https://apo.co')
  end

  scenario 'creating a bookmark with with INVALID data' do
    visit '/'

    within 'form#new_bookmark' do
      fill_in 'Url', with: 'invalidurl'

      click_button('Save')
    end

    expect(page).to have_content('errors prohibited this bookmark from being saved')
  end


  scenario 'editing bookmarks with VALID data' do
    visit '/'

    within 'table tbody' do
      click_link 'Edit'
    end

    expect(page).to have_current_path( edit_bookmark_path(bookmark) )

    fill_in 'Title', with: 'EDITED!'

    click_button('Save')

    expect(page).to have_current_path('/')
    expect(page).to have_content('Bookmark updated :)')
    expect(page).to have_content('EDITED!')
  end

  scenario 'editing bookmarks with INVALID data' do
    visit '/'

    within 'table tbody' do
      click_link 'Edit'
    end

    expect(page).to have_current_path( edit_bookmark_path(bookmark) )

    fill_in 'Url', with: 'invalidurl'

    click_button('Save')

    expect(page).to have_current_path("/bookmarks/#{bookmark.id}")
    expect(page).to have_content('error prohibited this bookmark from being saved')
  end

  xscenario 'removing a bookmark', js: true do
    visit '/'

    expect(page).to have_css('table tbody tr', count: 1)

    within 'table tbody' do
      accept_alert do
        click_link 'Remove'
      end
    end

    expect(page).to have_content('Bookmark removed :)')
    expect(page).to_not have_css('table tbody tr')
  end
end
