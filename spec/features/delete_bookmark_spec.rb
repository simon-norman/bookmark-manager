require_relative 'web_helper'

feature 'Deleting a bookmark from the list' do
  scenario 'Should remove bookmark from the list' do
    add_bookmark('Facebook')

    click_button('Delete')

    expect(page).not_to have_content('Facebook')
  end
end