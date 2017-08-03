class User < ActiveRecord::Base
  has_one :car
  has_many :trips
end
