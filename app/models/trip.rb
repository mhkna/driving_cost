class Trip < ActiveRecord::Base
  belongs_to :user

  validates :origin, :destination, presence: true
  validates :car_make, :car_model, :car_year, presence: true

  def total_cost
    (self.cost_depreciation + self.cost_phone_data + self.car_type).round(2)
  end

  def request
    uri = URI.parse("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{self.origin}&destinations=#{self.destination}&key=AIzaSyDfm8i0_7HPod93ZbI10qXLoVE3_nSbYcM")
    response = Net::HTTP.get(uri)
    response_hash = JSON.parse(response)
    distance = response_hash["rows"][0]["elements"][0]["distance"]["text"]
    distance.split(' ')[0]
  end

  def distance
  end

  def cost_depreciation
    if self.car_year >= 2010
      0.5
    elsif self.car_year < 2010 && self.car_year >= 2000
      0.3
    else
      0.1
    end
  end

  def cost_phone_data
    1
  end

  def car_type
    if self.car_make == "tesla"
      0.6
    else
      0.3
    end
  end

  def cost_gas
    @distance ||= self.request
    num = @distance.to_i
    (num * 0.15).round(2)
  end


  # def request
  #   uri = URI.parse("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{self.start_location}&destinations=#{self.end_location}&key=AIzaSyDfm8i0_7HPod93ZbI10qXLoVE3_nSbYcM")
  #   response = Net::HTTP.get(uri)
  #   JSON.parse(response)
  #   # response3 = response2["rows"][0]["elements"][0]["distance"]["text"]
  #   # response4 = response3.split(' ')[0]
  #   # response4.delete ","
  # end
  # 1600+Amphitheatre+Parkway,+Mountain+View,+CA
  # def convert_origin
  #   self.origin
  # end

  # def geocode_origin
  #   uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.origin}&key=AIzaSyC1sKYR3nshFbQ0E_FRLz6sg49L7eHzeZE")
  #   response = NET::HTTP.get(uri)
  #   JSON.parse(response)
  # end

  # def geocode_destination
  #   uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.end_address}&key=AIzaSyC1sKYR3nshFbQ0E_FRLz6sg49L7eHzeZE")
  #   response = NET::HTTP.get(uri)
  #   JSON.parse(response)
  # end

  # def request
  #   uri = URI.parse("https://api.uber.com/v1.2/estimates/price?start_latitude=#{self.start_lat}&start_longitude=#{self.start_long}&end_latitude=#{self.end_lat}&end_longitude=#{self.end_long}")
  #   response = NET::HTTP.get(uri)
  #   JSON.parse(response)
  # end
end
