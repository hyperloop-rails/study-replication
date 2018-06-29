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

# num of DiaryEntrySubscription
des_num = ARGV[1]
des_num = des_num.to_i

# num of diary comments
dc_num = ARGV[2]
dc_num = dc_num.to_i

RNG = Random.new(1098109928029800)
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

puts "create diaries"
users = User.all
num.times.map do |i|
    user = users[rand(users.length)]
    latitude = RNG.rand(-90..90)
    longitude = RNG.rand(-180..180)
    c1 = rand(40)
    created_at = Time.new(c1 + 1970)
    c2 = rand(c1..40)
    closed_at = Time.new(c2 + 1970)
    title = (0..8).map {o[rand(o.length)]}.join
    body = Lorem::Base.new('chars', 200).output
    de = DiaryEntry.create(:user_id => user.id, :title => title, :latitude => latitude, :longitude => longitude, :created_at => created_at, :updated_at => closed_at, :visible => rand(2), :body => body)
    puts "create diary " + de.id.to_s
end

puts "finished diaries"
diaries = DiaryEntry.all

puts "create change DiaryEntrySubscriptions"
des_num.times.map do |i|
  user = users[rand(users.length)]
  diary = diaries[rand(diaries.length)]
  if ! DiaryEntrySubscription.exists?(:user_id => user.id, :diary_entry_id => diary.id)
    des = DiaryEntrySubscription.create(:user_id => user.id, :diary_entry_id => diary.id)
  end
  puts "create DiaryEntrySubscription " + i.to_s

end
puts "finish DiaryEntrySubscriptions"

puts "create DiaryComments "
dc_num.times.map do |i|
  user = users[rand(users.length)]
  diary = diaries[rand(diaries.length)]
  body = Lorem::Base.new('chars', 200).output
  visible = rand(2)
  if ! DiaryComment.exists?(:diary_entry_id => diary.id, :user_id => user.id, :body => body, :visible => visible)
    dc = DiaryComment.create(:diary_entry_id => diary.id, :user_id => user.id, :body => body, :visible => visible)
  end
  puts "finish DiaryComment " + dc.id.to_s
end
puts "finish DiaryComments "