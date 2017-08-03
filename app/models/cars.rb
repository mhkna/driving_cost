class Cars < ActiveRecord::Base
  has_one :user
  has_many :trips
end
