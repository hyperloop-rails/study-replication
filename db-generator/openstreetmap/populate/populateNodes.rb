ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i

nt_num = ARGV[1].to_i

o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create nodes"
    changesets = Changeset.all
    cha_num = changesets.length
    for i in 1..num
        changeset = changesets[rand(cha_num)]
        lng = rand(changeset.min_lon..changeset.max_lon)
        lat = rand(changeset.min_lat..changeset.max_lat)
        node = Node.create(:latitude => lat, :longitude => lng, :changeset_id => changeset.id, :timestamp => Time.new(rand(40) + 1970) , :visible => rand(2), :version => rand(100))
        puts "create node " + node.id.to_s
    end
    puts "finished nodes"
end

begin
    puts "create nodetags"
    nodes = Node.all
    nod_num = nodes.length
    for i in 1..nt_num
        node = nodes[rand(nod_num)]
        k = (0...8).map { o[rand(o.length)] }.join
        v = (0...8).map { o[rand(o.length)] }.join 
        nt = OldNodeTag.create(:node_id => node.id, :k => k, :v => v )
        puts "create nodetag "
    end
    puts "finished nodetags"
end