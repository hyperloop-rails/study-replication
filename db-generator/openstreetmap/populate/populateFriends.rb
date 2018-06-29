# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require 'lorem'
ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i

mes_num = ARGV[1]
mes_num = mes_num.to_i

o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
users = User.all
user_num = users.length
num.times.map do |i|
    u1 = users[rand(user_num)]
    u2 = users[rand(user_num)]
    if u1 != u2 and ! Friend.exists?(:user_id => u1.id, :friend_user_id => u2.id)
        Friend.create(:user_id => u1.id, :friend_user_id => u2.id)
    end
end

mes_num.times.map do |i|
    u1 = users[rand(user_num)]
    u2 = users[rand(user_num)] 
    body = Lorem::Base.new("chars", rand(300)).output
    title = (0..10).map {o[rand(o.length)]}.join  
    c1 = rand(40)
    sent_on = Time.new(c1 + 1970)
    mes = Message.create(:from_user_id => u1.id, :title => title, :body => body,:sent_on => sent_on, :message_read => rand(2), :to_user_id => u2.id, :to_user_visible => rand(2), :from_user_visible => rand(2))
end