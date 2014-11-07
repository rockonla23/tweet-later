class TwitterUser

 def self.fetch_tweets!
	  $twitter_client.user_timeline("estellechang", count: 10)
 end

 def self.post_tweet!(tweet_msg)
 	$twitter_client.update(tweet_msg)
 end

end