ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i

wn_num = ARGV[1]
wn_num = wn_num.to_i

wt_num = ARGV[2]
wt_num = wt_num.to_i

o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create ways"
    changesets = Changeset.all
    cha_num = changesets.length
    for i in 1..num
        changeset = changesets[rand(cha_num)]
        way = Way.create(:changeset_id => changeset.id, :timestamp => Time.new(rand(40) + 1970) , :visible => rand(2), :version => rand(10) + 1)
        puts "create way " + way.id.to_s
    end
    puts "finished ways"
end

begin
    puts "create waynodes"
    ways = Way.all
    way_num = ways.length
    nodes = Node.all
    nod_num = nodes.length
    for i in 1..wn_num
        way = ways[rand(way_num)]
        node = nodes[rand(nod_num)]
        sequence_id = rand(100)
        if ! WayNode.exists?(:way => way, :sequence_id => sequence_id)
            wn = WayNode.create(:way => way, :node => node, :sequence_id => sequence_id)
            puts "create waynode "
        end
    end
    puts "finished waynodes"
end

begin
    puts "create way tags"
    ways = Way.all
    way_num = ways.length
    for i in 1..wt_num
        way = ways[rand(way_num)]
        k = (0...8).map { o[rand(o.length)] }.join
        v = (0...8).map { o[rand(o.length)] }.join 
        wt = WayTag.create(:way_id => way.id, :k => k, :v => v)
        puts "create way tag "
    end
    puts "finished way tags"
end