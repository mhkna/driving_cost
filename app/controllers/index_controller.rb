get '/' do
  redirect '/trips/new'
end

get '/unauthorized' do
  erb :unauthorized
end
