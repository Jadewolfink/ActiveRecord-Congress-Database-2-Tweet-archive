require_relative '../../db/config'

class Tweet < ActiveRecord::Base
  validates :unique_tweet_id, uniqueness: true
end