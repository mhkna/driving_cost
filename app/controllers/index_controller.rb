get '/' do
  redirect '/restaurants'
end

get '/unauthorized' do
  erb :unauthorized
end
