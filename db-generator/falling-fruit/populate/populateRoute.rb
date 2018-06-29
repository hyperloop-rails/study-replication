ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

TransportTypes = ["Walking","Bicycling","Driving"]
begin
    puts "create routes"
    users = User.all
    user_num = users.length
    for i in 1..num
        name = (0...12).map { o[rand(o.length)] }.join 
        user = users[rand(user_num)]
        r = Route.new(:name => name)
        r.user_id = user.id
        r.transport_type = TransportTypes[rand(3)]
        r.save
    end
    puts "finished routes"
end