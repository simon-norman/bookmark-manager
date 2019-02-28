feature 'Adding a bookmark to our list' do
  scenario 'Should display bookmark' do
    add_bookmark

    url = page.find('.bookmark')[:href]
    expect(url).to eq 'https://github.com/'
  end
end
