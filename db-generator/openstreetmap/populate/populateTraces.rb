require 'lorem'
ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

tt_num = ARGV[1].to_i

ttp_num = ARGV[2].to_i

RNG = Random.new(1098109928029800)
begin
    puts "create traces"
    users = User.all
    user_num = users.length
    for i in 1..num
        user = users[rand(user_num)]
        description =  Lorem::Base.new('chars', 200).output
        timestamp = Time.new(rand(40) + 1970)
        name = (0..10).map { o[rand(o.length)] }.join
        lat = RNG.rand(-90..90)
        lng = RNG.rand(-180..180)
        trace = Trace.create(:user => user, :name => name, :inserted => rand(2), :description => description, :visible => rand(2), :latitude => lat, :longitude => lng, :timestamp => timestamp , :visible => rand(2))
        puts "create trace " + trace.id.to_s
    end
    puts "finished traces"
end

begin
    puts "create trace tags"
    traces = Trace.all
    tra_num = traces.length
    for i in 1..tt_num
        trace = traces[rand(tra_num)]
        tag = (0...8).map { o[rand(o.length)] }.join
        tt = Tracetag.create(:gpx_id => trace.id, :tag => tag )
        puts "create trace tag " + tt.id.to_s
    end
    puts "finished trace tags"
end

RNG = Random.new(1098109928029800)
begin
    puts "create trace points"
    traces = Trace.all
    tra_num = traces.length
    for i in 1..ttp_num
        trace = traces[rand(tra_num)]
        timestamp = Time.new(rand(40) + 1970)
        name = (0..10).map { o[rand(o.length)] }.join
        lat = RNG.rand(-90..90)
        lng = RNG.rand(-180..180)
        altitude = RNG.rand(-180..180)
        tracepoint = Tracepoint.create(:altitude => altitude, :trackid => rand(100),  :latitude => lat, :longitude => lng, :timestamp => timestamp, :gpx_id => trace.id)
        puts "create trace point "
    end
    puts "finished trace points"
end