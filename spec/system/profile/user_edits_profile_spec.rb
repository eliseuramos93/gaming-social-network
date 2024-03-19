require 'rails_helper'

RSpec.describe 'User edits profile', type: :system do
  context 'with authorization' do
    it 'successfully from the profile page' do
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
  end
end
