get '/trips/new' do
  @trip = Trip.new
  erb :'trips/new'
end

post '/trips' do
  @trip = Trip.new(params[:trip])
  # p "right here  " * 90
  if @trip.save
    redirect "/trips/#{@trip.id}"
  else
    erb :'trips/new'
  end
end

get '/trips/:id' do
  @trip = Trip.find(params[:id])
  erb :'trips/show'
end
