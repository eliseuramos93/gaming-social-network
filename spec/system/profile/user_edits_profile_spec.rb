require 'rails_helper'

RSpec.describe 'User edits profile', type: :system do
  context 'with authorization' do
    it 'successfully from the profile page, changing all of the information at once' do
      peyton = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')

      login_as peyton
      visit profile_path(peyton.profile.id)
      click_on 'Editar perfil'
      fill_in 'Nome completo', with: 'Peyton Manning'
      fill_in 'Bio', with: 'Former NFL quarterback, 5x NFL MVP'
      fill_in 'País', with: 'USA'
      fill_in 'Data de nascimento', with: 47.years.ago.strftime('%Y-%m-%d')
      click_on 'Salvar'

      expect(page).to have_current_path profile_path(peyton.profile.id)
      expect(page).to have_content 'Seu perfil foi alterado com sucesso'
      expect(page).to have_content 'Peyton Manning'
      expect(page).to have_content 'Former NFL quarterback, 5x NFL MVP'
      expect(page).to have_content 'USA'
      expect(page).to have_content '47 anos'
    end

    it 'successfully from the profile page, removing one or more information from the profile' do
      peyton = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      peyton.profile.update(bio: 'Former NFL quarterback, 5x NFL MVP', country: 'USA', birth_date: 47.years.ago)

      login_as peyton
      visit profile_path(peyton.profile.id)
      click_on 'Editar perfil'
      fill_in 'Nome completo', with: 'Peyton Manning'
      fill_in 'Bio', with: 'Former NFL quarterback, 5x NFL MVP'
      fill_in 'País', with: ''
      fill_in 'Data de nascimento', with: ''
      click_on 'Salvar'

      expect(page).to have_current_path profile_path(peyton.profile.id)
      expect(page).to have_content 'Seu perfil foi alterado com sucesso'
      expect(page).to have_content 'Peyton Manning'
      expect(page).to have_content 'Former NFL quarterback, 5x NFL MVP'
      expect(page).not_to have_content 'USA'
      expect(page).not_to have_content '47 anos'
    end
  end

  context 'without authorization' do
    it 'so it does not see the edit profile link on profile page' do
      peyton = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      patrick = User.create(username: 'grimreaper', email: 'patrick@mahomes.com', password: 'chiefskingdom')

      login_as patrick
      visit profile_path(peyton.profile.id)

      expect(page).not_to have_link 'Editar perfil', href: edit_profile_path(peyton.profile.id)
    end

    it 'so it is redirected to homepage if tries to access the edit profile url' do
      peyton = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      patrick = User.create(username: 'grimreaper', email: 'patrick@mahomes.com', password: 'chiefskingdom')

      login_as patrick
      visit edit_profile_path(peyton.profile.id)

      expect(page).to have_content 'Você não possui autorização para essa ação'
      expect(page).to have_current_path root_path
    end
  end

  context 'while unauthenticated' do
    it 'so it is redirected to login page if tries to access the edit profile url' do
      peyton = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')

      visit edit_profile_path(peyton.profile.id)

      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
      expect(page).to have_current_path new_user_session_path
    end
  end
end
