class Trip < ActiveRecord::Base
  belongs_to :car

  validates :origin, presence: true
  validates :destination, presence: true
end
