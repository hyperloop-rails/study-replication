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

# num of change set tags
ct_num = ARGV[1]
ct_num = ct_num.to_i

# num of change comments
cc_num = ARGV[2]
cc_num = cc_num.to_i

RNG = Random.new(1098109928029800)
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

puts "create changesets"
users = User.all
user_num = users.length
num.times.map do |i|
    user = users[rand(user_num)]
    min_lat = RNG.rand(-90..90)
    min_lon = RNG.rand(-180..180)
    max_lat = RNG.rand(min_lat..90)
    max_lon = RNG.rand(min_lon..180)
    c1 = rand(40)
    created_at = Time.new(c1 + 1970)
    c2 = rand(c1..40)
    closed_at = Time.new(c2 + 1970)
    changeset = Changeset.create(:user_id => user.id, :min_lat => min_lat, :max_lat => max_lat, :min_lon => min_lon, :max_lon => max_lon, :created_at => created_at, :closed_at => closed_at)
    puts "create changeset " + changeset.id.to_s
end

puts "finished changesets"
changesets = Changeset.all

puts "create change set tags"
ct_num.times.map do |i|
  changeset = changesets[rand(changesets.length)]
  k = (0..10).map {o[rand(o.length)]}.join
  v = (0..10).map {o[rand(o.length)]}.join
  ct = ChangesetTag.create(:changeset => changeset, :k => k, :v => v)
  puts "create change set tag " + i.to_s

end
puts "finish change set tags"

puts "create change set comments "
cc_num.times.map do |i|
  user = users[rand(users.length)]
  changeset = changesets[rand(changesets.length)]
  body = Lorem::Base.new('chars', 200).output
  cc = ChangesetComment.create(:changeset => changeset, :author_id => user.id, :body => body, :visible => rand(2))
  puts "finish change set comment " + cc.id.to_s
end
puts "finish change set comments "