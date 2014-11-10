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
  session[:id] = twitteruser.id

erb :index

end

post '/auth' do
  twitteruser = TwitterUser.find(session[:id])
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV["TWITTER_KEY"]
    config.consumer_secret = ENV["TWITTER_SECRET"]
    config.access_token = twitteruser.oauth_token
    config.access_token_secret = twitter.user.oauth_secret
  end
  client.update(params[:tweets])
end

