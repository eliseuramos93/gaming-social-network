require 'rails_helper'

RSpec.describe User, type: :model do
  it 'creates a related profile instance after creation' do
    user = User.create!(username: 'sheriff18', email: 'peyton@manning.com', password: 'broncocolts18')

    expect(Profile.count).to eq 1
    expect(user.profile).to be_a(Profile)
  end
end
