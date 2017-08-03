class Trip < ActiveRecord::Base
  belongs_to :user

  validates :origin, presence: true
  validates :destination, presence: true

  def request
    uri = URI.parse("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{self.start_location}&destinations=#{self.end_location}&key=AIzaSyDfm8i0_7HPod93ZbI10qXLoVE3_nSbYcM")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
    # response3 = response2["rows"][0]["elements"][0]["distance"]["text"]
    # response4 = response3.split(' ')[0]
    # response4.delete ","
  end

end
