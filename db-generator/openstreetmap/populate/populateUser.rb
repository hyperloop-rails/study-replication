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

role_num = ARGV[1].to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
pass_crypt = User.find(1).pass_crypt
pass_salt = User.find(1).pass_salt
user_ss = [    'pending',
    'confirmed',
    'suspended',
    'deleted'] + ['active'] * 50
num.times.map do |i|
    email = (0...8).map { o[rand(o.length)] }.join + "@example.com"
    name = (0...8).map { o[rand(o.length)] }.join 
    u = User.create(:email => email, :display_name => name, :pass_crypt => pass_crypt, :pass_salt => pass_salt)
    u.status = user_ss[rand(user_ss.length)]
    u.save!
end

users = User.all
file = File.open("username.txt", "w")
for u in users
  file.write(u.email + "\n") 
end
file.close
roles =  ['administrator', 'moderator']
role_num.times.map do |i|
  user = users[rand(users.length)]
  role = roles[rand(roles.length)]
  ur = UserRole.create(:user_id => user.id, :role => role, :created_at => Time.zone.now - rand(86400 * 365 * 2), :granter_id => users[rand(users.length)].id)
  puts "create user role ", ur.id.to_s
end