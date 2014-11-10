get '/' do
  erb :index
end

get '/sign_in' do
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  byebug
  @access_token = request_token.get_access_token(:access_verifier => params[:access_verifier])

  session.delete(:request_token)

   twitteruser = TwitterUser.create(twitter_username: @access_token.params[:screen_name], access_token: @access_token.token, access_token_secret: @access_token.secret )
  session[:id] = user.id

erb :index

end

post '/auth' do
  twitteruser = TwitterUser.find(session[:id])
  Twitter.configure do |config|
  config.access_token = user.access_token
  config.access_token_secret = user.access_token_secret
end
  Twitter.update(params[:tweets])
end

