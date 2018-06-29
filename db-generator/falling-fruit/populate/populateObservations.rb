ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
o.append(' ')
o.append(' ')
o.append(' ')
o.append(' ')
o.append(' ')
o.append(' ')
o.append(' ')
begin
    puts "create observations"
    users = User.all
    user_num = users.length
    locations = Location.all
    loc_num = locations.length

    for i in 1..num
        comment = (0...30).map { o[rand(o.length)] }.join 
        user = users[rand(user_num)]
        location = locations[rand(loc_num)]
        Observation.create(:location_id => location.id, :comment => comment, :user_id => user.id)
    end
    puts "finished observations"
end