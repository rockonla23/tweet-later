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
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)
   twitteruser = TwitterUser.create(twitter_username: @access_token.params[:screen_name], oauth_token: @access_token.token, oauth_secret: @access_token.secret )
  session[:id] = user.id

erb :index

end

post '/auth' do
  twitteruser = TwitterUser.find(session[:id])
  Twitter.configure do |config|
  config.oauth_token = user.oauth_token
  config.oauth_token_secret = user.oauth_secret
end
  Twitter.update(params[:tweets])
end

