feature 'delete bookmarks' do
  scenario 'users can delete bookmarks' do
    visit('/add')
    fill_in('title', with: 'Makers')
    fill_in('url', with: 'https://www.makersacademy.com')
    click_button('Submit')
    visit('/add')
    fill_in('title', with: 'Google')
    fill_in('url', with: 'https://www.google.com')
    click_button('Submit')
    # click delete 
    # we want a link/button associated with the url
    # we want a delete option next to every link
  end
end
