ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
filename = ARGV[0]
File.new(filename, "r")
re = []
IO.foreach(filename){|block|  re.push(block.to_i)}  


o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
begin
    puts "create location"
    users = User.all
    user_num = users.length
    types = Type.all
    type_num = types.length
    for user in users
        index = users.index(user)
        if index < re.length
            num = re[index] 
        else
            num = rand(10)
        end
        for i in 1..num
            # random location
            lng = rand() * 160  - 80
            lat = rand() * 20  + 20
            description = (0...30).map { o[rand(o.length)] }.join 
            t_num = rand(10)
            t_ids = []
            for j in 1..t_num
                t_ids.append(types[rand(type_num)].id)
            end
            # create location
            l = Location.create(:author => user.name, :user_id => user.id , :lat => lat, :lng => lng, :description => description, :type_ids => t_ids)
            puts "create location " + l.id.to_s
        end
    end
    puts "finished locations"
end