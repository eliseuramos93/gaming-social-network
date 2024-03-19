require 'rails_helper'

RSpec.describe 'User visits profile', type: :system do
  context 'while authenticated' do
    it 'successfully and sees the own profile details' do
      user = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      user.profile.update!(full_name: 'Peyton Manning', bio: 'Former NFL quarterback, 5x NFL MVP', country: 'USA',
                           birth_date: '1976-03-24')

      login_as user
      visit root_path
      click_on 'sheriff18'

      expect(page).to have_current_path profile_path(user.profile.id)
      expect(page).to have_content 'Peyton Manning'
      expect(page).to have_content 'Former NFL quarterback, 5x NFL MVP'
      expect(page).to have_content 'USA'
      expect(page).to have_content '47 anos'
    end

    it 'successfully and sees another user profile details' do
      peyton = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      peyton.profile.update!(full_name: 'Peyton Manning', bio: 'Former NFL quarterback, 5x NFL MVP', country: 'USA',
                             birth_date: '1976-03-24')
      patrick = User.create!(username: 'grimreaper', email: 'patrick@mahomes.com', password: 'chiefskingdom')

      login_as patrick
      visit profile_path(peyton.profile.id)

      expect(page).to have_current_path profile_path(peyton.profile.id)
      expect(page).to have_content 'sheriff18'
      expect(page).to have_content 'Peyton Manning'
      expect(page).to have_content 'Former NFL quarterback, 5x NFL MVP'
      expect(page).to have_content 'USA'
      expect(page).to have_content '47 anos'
    end

    it 'and returns to the homepage' do
      user = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      user.profile.update!(full_name: 'Peyton Manning', bio: 'Former NFL quarterback, 5x NFL MVP', country: 'USA',
                           birth_date: '1976-03-24')

      login_as user
      visit profile_path(user.profile.id)
      click_on 'GamingSocialNetwork'

      expect(page).to have_current_path root_path
      expect(page).not_to have_content 'Peyton Manning'
      expect(page).not_to have_content 'Former NFL quarterback, 5x NFL MVP'
      expect(page).not_to have_content 'USA'
      expect(page).not_to have_content '47 anos'
    end

    it 'and only sees the username if the user has not updated its profile information' do
      peyton = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      patrick = User.create!(username: 'grimreaper', email: 'patrick@mahomes.com', password: 'chiefskingdom')

      login_as patrick
      visit profile_path(peyton.profile.id)

      expect(page).to have_current_path profile_path(peyton.profile.id)
      expect(page).to have_content 'sheriff18'
      expect(page).not_to have_content 'Peyton Manning'
      expect(page).not_to have_content 'Former NFL quarterback, 5x NFL MVP'
      expect(page).not_to have_content 'USA'
      expect(page).not_to have_content '47 anos'
    end
  end

  context 'while unauthenticated' do
    it 'and is redirected to the login page' do
      user = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')

      visit profile_path(user.profile.id)

      expect(page).to have_current_path new_user_session_path
      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    end
  end
end
