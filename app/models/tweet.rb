class Tweet < ActiveRecord::Base
  belongs_to :twitter_user

  validates_length_of :text, :maximum=>141

end