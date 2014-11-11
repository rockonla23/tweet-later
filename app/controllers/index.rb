get '/' do
  erb :index
end

get '/sign_in' do
  redirect to("/auth/twitter")
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth/twitter/callback' do
  # @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)
  screen_name = env['omniauth.auth']["extra"]["access_token"].params["screen_name"]
  twitteruser = TwitterUser.find_by(twitter_username: screen_name)
  if twitteruser
    TwitterUser.update(twitter_username: screen_name, oauth_token: env['omniauth.auth']["credentials"]["token"], oauth_secret: env['omniauth.auth']["credentials"]["secret"] )
  else
   twitteruser = TwitterUser.create(twitter_username: screen_name, oauth_token: env['omniauth.auth']["credentials"]["token"], oauth_token_secret: env['omniauth.auth']["credentials"]["secret"] )
  end
  session[:id] = twitteruser.id

erb :index

end

post '/auth' do
  twitteruser = TwitterUser.find(session[:id])
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV["TWITTER_KEY"]
    config.consumer_secret = ENV["TWITTER_SECRET"]
    config.access_token = twitteruser.oauth_token
    config.access_token_secret = twitteruser.oauth_token_secret
  end
  client.update(params[:tweets])
  redirect '/'
end

