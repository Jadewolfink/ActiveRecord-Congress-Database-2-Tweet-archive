require 'sqlite3'
require_relative 'models/senator.rb'
senator = Senator.new

p "enter a state"
input = gets.chomp

p "Senators:"
Senator.where(state: input, title: 'Sen').order(:lastname).reverse_order.each do |senator|
  p "#{senator.name} (#{senator[:party]})"
end
p "Representatives:"
Senator.where(state: input, title: 'Rep').order(:lastname).reverse_order.each do |senator|
  p "#{senator.name} (#{senator[:party]})"
end

p "Key in a gender"
input = gets.chomp

p "#{input.capitalize} Senators :#{Senator.where(in_office: 1, gender: input, title:'Sen').count} ( #{Senator.where(in_office: 1, gender: input, title:'Sen').count*100/Senator.where(in_office: 1, title:'Sen').count}% )"

p "#{input.capitalize} Representatives :#{Senator.where(in_office: 1, gender: input, title:'Rep').count} ( #{Senator.where(in_office: 1, gender: input, title:'Rep').count*100/Senator.where(in_office: 1, title:'Rep').count}% )"

Senator.where(in_office: 1).group('state').order('count_id desc').count('id').each do |pairs|
  p ("#{pairs[0]}: #{Senator.where(in_office: 1, title: 'Sen', state: pairs[0]).count} Senators, #{Senator.where(in_office: 1, title: 'Rep', state: pairs[0]).count} Representative(s)")
end

p "Senators: #{Senator.where(title: 'Sen').count}"
p "Representatives: #{Senator.where(title: 'Rep').count}"

Senator.where(in_office: 0).each do |x|
  x.destroy
end
