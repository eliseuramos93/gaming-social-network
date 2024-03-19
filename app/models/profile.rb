class Profile < ApplicationRecord
  belongs_to :user

  delegate :username, to: :user

  def age
    return nil if birth_date.blank?

    ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end
end
