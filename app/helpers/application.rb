def current_twitter_user
  @twitteruser ||= TwitterUser.find_by_id(session[:twitteruser.id])
end