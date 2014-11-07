get '/' do
  # Look in app/views/index.erb
  @tweets = TwitterUser.fetch_tweets!
  erb :index
end

post '/tweet' do
  # Look in app/views/index.erb
  TwitterUser.post_tweet!( params[:tweet_msg] )
  @tweets = TwitterUser.fetch_tweets!
  erb :show, layout: false
end

get '/tweet' do
  # Look in app/views/index.erb
  @tweets = TwitterUser.fetch_tweets!
  erb :show
end