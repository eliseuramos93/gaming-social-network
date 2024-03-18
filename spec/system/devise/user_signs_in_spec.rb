require 'rails_helper'

RSpec.describe 'User signs up, starting from the homepage', type: :system do
  it 'successfully' do
    User.create(username: 'sheriff18', email: 'patrick@mahomes.com', password: 'arrowhead15')

    visit root_path
    click_on 'Login'
    fill_in 'E-mail', with: 'patrick@mahomes.com'
    fill_in 'Senha', with: 'arrowhead15'
    click_on 'Entrar'

    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_current_path(root_path)
  end

  context 'unsuccessfully if' do
    it 'fails to provide an e-mail address' do
      User.create(username: 'sheriff18', email: 'patrick@mahomes.com', password: 'arrowhead15')

      visit root_path
      click_on 'Login'
      fill_in 'E-mail', with: ''
      fill_in 'Senha', with: 'arrowhead15'
      click_on 'Entrar'

      expect(page).to have_content('E-mail ou senha inválidos.')
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'provides an invalid e-mail address' do
      User.create(username: 'sheriff18', email: 'patrick@mahomes.com', password: 'arrowhead15')

      visit root_path
      click_on 'Login'
      fill_in 'E-mail', with: 'joe@burrow.com'
      fill_in 'Senha', with: 'arrowhead15'
      click_on 'Entrar'

      expect(page).to have_content('E-mail ou senha inválidos.')
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'fails to provide a password' do
      User.create(username: 'sheriff18', email: 'patrick@mahomes.com', password: 'arrowhead15')

      visit root_path
      click_on 'Login'
      fill_in 'E-mail', with: 'patrick@mahomes.com'
      fill_in 'Senha', with: ''
      click_on 'Entrar'

      expect(page).to have_content('E-mail ou senha inválidos.')
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'provides an incorrect password' do
      User.create(username: 'sheriff18', email: 'patrick@mahomes.com', password: 'arrowhead15')

      visit root_path
      click_on 'Login'
      fill_in 'E-mail', with: 'patrick@mahomes.com'
      fill_in 'Senha', with: ''
      click_on 'Entrar'

      expect(page).to have_content('E-mail ou senha inválidos.')
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
