require 'rails_helper'

RSpec.describe Profile, type: :model do
  context '#calculate_age' do
    it 'calculates the correct age' do
      profile = Profile.new(birth_date: 47.years.ago)

      expect(profile.calculate_age).to eq(47)
    end
  end
end
