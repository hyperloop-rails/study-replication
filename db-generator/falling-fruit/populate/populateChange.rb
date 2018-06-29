ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
filename = ARGV[0]
File.new(filename, "r")
re = []
IO.foreach(filename){|block|  re.push(block.to_i)}  

o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
o.append(' ')
o.append(' ')
o.append(' ')
o.append(' ')
o.append(' ')
o.append(' ')
o.append(' ')
begin
    puts "create changes"
    users = User.all
    user_num = users.length
    locations = Location.all
    loc_num = locations.length
    observations = Observation.all
    obs_num = observations.length
    for user in users
        index = users.index(user)
        if index < re.length
            num = re[index]
        else
            num = rand(10)
        end
        for i in 1..num
            description = (0...30).map { o[rand(o.length)] }.join 
            #user = users[rand(user_num)]
            location = locations[rand(loc_num)]
            observation = observations[rand(obs_num)]
            c = Change.new()
            c.user = user
            c.location = location
            c.observation = observation
            c.description = description
            c.save
        end
    end
    puts "finished changes"
end