def oauth_consumer
  raise RuntimeError, "You must set twitter_consumer_key_id and twitter_consumer_secret_key_id in your server environment." unless ENV['twitter_consumer_key_id'] and ENV['twitter_consumer_secret_key_id']
  @consumer ||= OAuth::Consumer.new(
    ENV['twitter_consumer_key_id'],
    ENV['twitter_consumer_secret_key_id'],
    :site => "https://api.twitter.com"
  )
end


def request_token
  if not session[:request_token]

    host_and_port = request.host
    host_and_port << ":9393" if request.host == "localhost"

    session[:request_token] = oauth_consumer.get_request_token(
    :oauth_callback => "http://#{host_and_port}/auth"
    )
  end
  session[:request_token]
end
