class Trip < ActiveRecord::Base
  belongs_to :user

  validates :origin, :destination, presence: true
  validates :car_make, :car_model, :car_year, presence: true

  def total_cost
    (self.cost_gas + self.cost_depreciation + self.cost_phone_data + self.car_type).round(2)
  end

  def distance_request
    uri = URI.parse("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{self.origin}&destinations=#{self.destination}&key=AIzaSyDfm8i0_7HPod93ZbI10qXLoVE3_nSbYcM")
    response = Net::HTTP.get(uri)
    response_hash = JSON.parse(response)
    distance = response_hash["rows"][0]["elements"][0]["distance"]["text"]
    distance.split(' ')[0]
  end

  def cost_depreciation
    if self.car_year >= 2010
      0.50
    elsif self.car_year < 2010 && self.car_year >= 2000
      0.30
    else
      0.10
    end
  end

  def cost_phone_data
    1.00
  end

  def car_type
    if self.car_make == "tesla"
      0.60
    else
      0.30
    end
  end

  def cost_gas
    # why instance var also how geocode
    @distance ||= self.distance_request
    num = @distance.to_i
    (num * 0.15).round(2)
  end

  # def geocode_origin
  #   uri = URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{self.origin}&key=AIzaSyDfm8i0_7HPod93ZbI10qXLoVE3_nSbYcM")
  #   response = NET::HTTP.get(uri)
  #   JSON.parse(response)
  # end

  # def geocode_destination
  #   uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.destination}&key=AIzaSyC1sKYR3nshFbQ0E_FRLz6sg49L7eHzeZE")
  #   response = NET::HTTP.get(uri)
  #   JSON.parse(response)
  #   # @end_lat =
  #   # @end_long =
  # end

  # def request
  #   uri = URI.parse("https://api.uber.com/v1.2/estimates/price?start_latitude=#{self.start_lat}&start_longitude=#{self.start_long}&end_latitude=#{self.end_lat}&end_longitude=#{self.end_long}")
  #   response = NET::HTTP.get(uri)
  #   JSON.parse(response)
  # end
end
