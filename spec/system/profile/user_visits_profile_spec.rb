require 'rails_helper'

RSpec.describe 'User visits profile', type: :system do
  context 'while authenticated' do
    it 'successfully and sees the profile details' do
      user = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      user.profile.update!(full_name: 'Peyton Manning', bio: 'Former NFL quarterback, 5x NFL MVP', country: 'USA',
                           birth_date: '1976-03-24')

      login_as user
      visit root_path
      click_on 'sheriff18'

      expect(page).to have_current_path profile_path(user.profile.id)
      expect(page).to have_content('Peyton Manning')
      expect(page).to have_content('Former NFL quarterback, 5x NFL MVP')
      expect(page).to have_content('USA')
      expect(page).to have_content('47 anos')
    end
  end
end
