ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
filename = ARGV[0]
File.new(filename, "r")
re = []
IO.foreach(filename){|block|  re.push(block.to_i)}  

o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create locations_routes"
    locations = Location.all
    loc_num = locations.length
    routes = Route.all
    rou_num = routes.length
    for loc in locations
        index = locations.index(loc)
        if index < re.length
            num = re[index]
        else
            num = rand(10)
        end
        for i in 1..num
            loc = locations[rand(loc_num)]
            rou = routes[rand(rou_num)]
            lr = LocationsRoute.new()
            lr.location_id = loc.id
            lr.route_id = rou.id
            lr.save
        end
    end
    puts "finished locations_routes"
end