require 'rails_helper'

RSpec.describe 'User signs up, starting from the homepage', type: :system do
  it 'successfully' do
    visit root_path
    click_on 'Inscrever-se'
    fill_in 'E-mail', with: 'billy@pampers.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastrar'

    expect(User.count).to eq 1
    expect(User.last.email).to eq 'billy@pampers.com'
    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    expect(page).to have_current_path(root_path)
    expect(page).to have_content 'billy@pampers.com'
    expect(page).to have_button 'Sair'
    expect(page).not_to have_link 'Inscrever-se', href: new_user_registration_path
    expect(page).not_to have_link 'Login', href: new_user_session_path
  end

  context 'unsuccessfully if' do
    it 'fails to provide an e-mail address' do
      visit root_path
      click_on 'Inscrever-se'
      fill_in 'E-mail', with: ''
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Cadastrar'

      expect(User.count).to eq 0
      expect(page).to have_content 'Não foi possível salvar usuário'
      expect(page).to have_content 'E-mail não pode ficar em branco'
    end

    it 'uses an already registered e-mail address' do
      User.create!(email: 'peyton@manning.com', password: 'laserqb18')

      visit root_path
      click_on 'Inscrever-se'
      fill_in 'E-mail', with: 'peyton@manning.com'
      fill_in 'Senha', with: '654321'
      fill_in 'Confirme sua senha', with: '654321'
      click_on 'Cadastrar'

      expect(User.count).to eq 1
      expect(page).to have_content 'Não foi possível salvar usuário'
      expect(page).to have_content 'E-mail já está em uso'
    end

    it 'fails to provide a password' do
      visit root_path
      click_on 'Inscrever-se'
      fill_in 'E-mail', with: 'peyton@manning.com'
      fill_in 'Senha', with: ''
      fill_in 'Confirme sua senha', with: ''
      click_on 'Cadastrar'

      expect(User.count).to eq 0
      expect(page).to have_content 'Não foi possível salvar usuário'
      expect(page).to have_content 'Senha não pode ficar em branco'
    end

    it 'provides a password confirmation that does not match the password' do
      visit root_path
      click_on 'Inscrever-se'
      fill_in 'E-mail', with: 'peyton@manning.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: ''
      click_on 'Cadastrar'

      expect(User.count).to eq 0
      expect(page).to have_content 'Não foi possível salvar usuário'
      expect(page).to have_content 'Confirme sua senha não é igual a senha'
    end
  end
end
