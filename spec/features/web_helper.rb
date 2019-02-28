def add_bookmark(title = 'Github')
    visit '/bookmarks'
    fill_in('title', with: title)
    fill_in('url', with: 'https://github.com/')

    click_button 'Submit'
end
