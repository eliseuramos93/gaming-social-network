require 'rails_helper'

RSpec.describe 'PATCH profiles/:id/', type: :request do
  context 'with authorization' do
    it 'successfully from the profile page, changing all of the information at once' do
      peyton = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      profile_params = { profile:
        { full_name: 'Peyton Manning',
          bio: 'Former NFL quarterback, 5x NFL MVP',
          country: 'USA',
          birth_date: 47.years.ago.strftime('%Y-%m-%d') } }

      login_as peyton
      patch profile_path(peyton.profile.id), params: profile_params
      peyton.profile.reload

      expect(response).to redirect_to profile_path(peyton.profile.id)
      expect(peyton.profile.full_name).to eq 'Peyton Manning'
      expect(peyton.profile.bio).to eq 'Former NFL quarterback, 5x NFL MVP'
      expect(peyton.profile.country).to eq 'USA'
      expect(peyton.profile.age).to eq 47
    end

    it 'successfully from the profile page, removing one or more information from the profile' do
      peyton = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      peyton.profile.update(bio: 'Former NFL quarterback, 5x NFL MVP', country: 'USA', birth_date: 47.years.ago)
      profile_params = { profile:
        { full_name: '',
          bio: '',
          country: 'USA',
          birth_date: '' } }

      login_as peyton
      patch profile_path(peyton.profile.id), params: profile_params
      peyton.profile.reload

      expect(response).to redirect_to profile_path(peyton.profile.id)
      expect(peyton.profile.full_name).to eq ''
      expect(peyton.profile.bio).to eq ''
      expect(peyton.profile.country).to eq 'USA'
      expect(peyton.profile.age).to be_nil
    end
  end

  context 'without authorization' do
    it 'fails to update and redirects to homepage' do
      peyton = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      patrick = User.create!(username: 'grimreaper', email: 'patrick@mahomes.com', password: 'chiefskingdom')
      profile_params = { profile:
        { full_name: 'Peyton Manning',
          bio: 'Former NFL quarterback, 5x NFL MVP',
          country: 'USA',
          birth_date: 47.years.ago.strftime('%Y-%m-%d') } }

      login_as patrick
      patch profile_path(peyton.profile.id), params: profile_params
      peyton.profile.reload

      expect(response).to redirect_to root_path
      expect(peyton.profile.full_name).to be_nil
      expect(peyton.profile.bio).to be_nil
      expect(peyton.profile.country).to be_nil
      expect(peyton.profile.age).to be_nil
    end
  end

  context 'while unauthenticated' do
    it 'fails to update and redirects to login page' do
      peyton = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')
      profile_params = { profile:
        { full_name: 'Peyton Manning',
          bio: 'Former NFL quarterback, 5x NFL MVP',
          country: 'USA',
          birth_date: 47.years.ago.strftime('%Y-%m-%d') } }

      patch profile_path(peyton.profile.id), params: profile_params
      peyton.profile.reload

      expect(response).to redirect_to new_user_session_path
      expect(peyton.profile.full_name).to be_nil
      expect(peyton.profile.bio).to be_nil
      expect(peyton.profile.country).to be_nil
      expect(peyton.profile.age).to be_nil
    end
  end
end
