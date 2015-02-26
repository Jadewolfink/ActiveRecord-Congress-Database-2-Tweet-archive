require 'sqlite3'
require_relative 'models/legislator.rb'
require_relative 'models/rep.rb'
require_relative 'models/sen.rb'
require 'twitter'
require 'byebug'
require_relative 'models/tweet.rb'
# senator = Legislator.new

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "bKXegeuXwBXmJR00Ec9pj3Ce5"
  config.consumer_secret     = "cScIHZKarqFdFU6u68pZsRPpOjSKCQLjNfVSSnUbXLw2WDPgKE"
  config.access_token        = "50880114-wdNWnVHlJGLw2Nkdqtab9lAfGoNpdFuxYyrIlioNt"
  config.access_token_secret = "rf4arlTZJXUbRdWQcnAieulzEz5VGDEpNJGoOp58AwA01"
end



p "which congressman u want to store, by id?"
input = gets.chomp
  @legislator = Legislator.find_by(id: input)
  @sen_twitter_id = @legislator[:twitter_id]
  if @sen_twitter_id.empty?
    p "this congressman has no twitter"
  else
    x = client.user_timeline(@sen_twitter_id).take(10)
    x.each_with_index do |tweet,index|
      "#{index+1}.  #{client.status(tweet).text}"

      Tweet.create(text: tweet.text, unique_tweet_id: tweet.id,
        legislator_id: @legislator.id)

    end
  end



# p "enter a state"
# input = gets.chomp

# p "Senators:"
# Senator.where(state: input, title: 'Sen').order(:lastname).reverse_order.each do |senator|
#   p "#{senator.name} (#{senator[:party]})"
# end
# p "Representatives:"
# Senator.where(state: input, title: 'Rep').order(:lastname).reverse_order.each do |senator|
#   p "#{senator.name} (#{senator[:party]})"
# end

# p "Key in a gender"
# input = gets.chomp

# p "#{input.capitalize} Senators :#{Senator.where(in_office: 1, gender: input, title:'Sen').count} ( #{Senator.where(in_office: 1, gender: input, title:'Sen').count*100/Senator.where(in_office: 1, title:'Sen').count}% )"

# p "#{input.capitalize} Representatives :#{Senator.where(in_office: 1, gender: input, title:'Rep').count} ( #{Senator.where(in_office: 1, gender: input, title:'Rep').count*100/Senator.where(in_office: 1, title:'Rep').count}% )"

# Senator.where(in_office: 1).group('state').order('count_id desc').count('id').each do |pairs|
#   p ("#{pairs[0]}: #{Senator.where(in_office: 1, title: 'Sen', state: pairs[0]).count} Senators, #{Senator.where(in_office: 1, title: 'Rep', state: pairs[0]).count} Representative(s)")
# end

# p "Senators: #{Senator.where(title: 'Sen').count}"
# p "Representatives: #{Senator.where(title: 'Rep').count}"

# Senator.where(in_office: 0).each do |x|
#   x.destroy
# end
