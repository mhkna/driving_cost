class Trip < ActiveRecord::Base
  belongs_to :car
  belongs_to :user

  validates :origin, presence: true
  validates :destination, presence: true
end
