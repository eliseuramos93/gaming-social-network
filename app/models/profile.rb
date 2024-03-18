class Profile < ApplicationRecord
  belongs_to :user

  delegate :username, to: :user

  def calculate_age
    ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end
end
