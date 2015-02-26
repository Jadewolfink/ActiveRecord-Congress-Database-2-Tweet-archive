require_relative '../config'

class CreateTweet < ActiveRecord::Migration
  def change

    create_table :tweets do |t|
      t.string :unique_tweet_id
      t.text :text
      t.string :legislator_id
      t.timestamps :null => false
    end
  end
end
