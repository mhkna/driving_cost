get '/trips/new' do
  @trip = Trip.new
  erb :'trips/new'
end
