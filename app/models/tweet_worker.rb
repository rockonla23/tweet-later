class TweetWorker
  include Sidekiq::Worker

   def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    twitteruser = tweet.twitter_user

    # twitter = TweetWorker(twitteruser.oauth_token, twitteruser.oauth_token_secret)
    # twitter_client.update(tweet.tweet_text)
    # puts "finished working-------------->#{tweet.tweet_text}"

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = twitteruser.oauth_token
      config.access_token_secret = twitteruser.oauth_token_secret
    end
    client.update(tweet.text)
  end
end


