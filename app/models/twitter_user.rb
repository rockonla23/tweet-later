class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def twitter_client
    @twitter_client ||= Twitter::Client.new(:oauth_token => self.oauth_token,
                                            :oauth_token_secret => self.oauth_secret)
  end

   def post_tweet(tweet_word)
      tweet = self.tweets.create(text: tweet_word)
      TweetWorker.perform_async(tweet.id)
   end

  def post_tweet_later(tweet_word, time)
      tweet = self.tweets.create(text: tweet_word)
      TweetWorker.perform_at(time.to_i.seconds, tweet.id)
  end

end