require './spec/features/web_helper'

feature 'Updating bookmarks' do
  scenario 'a bookmark is updated' do
    add_bookmark
    click_button 'Edit'
    fill_in :title, with: 'Apple'
    fill_in :url, with: 'https://www.apple.com'
    click_button 'Update'
    expect(page).to have_link('Apple', href: 'https://www.apple.com')
  end
end
