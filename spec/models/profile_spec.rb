require 'rails_helper'

RSpec.describe Profile, type: :model do
  context '#age' do
    it 'calculates the correct age' do
      profile = Profile.new(birth_date: 47.years.ago)

      expect(profile.age).to eq 47
    end

    it 'returns nil if birth_date is blank' do
      profile = Profile.new

      expect(profile.age).to be_nil
    end
  end
end
