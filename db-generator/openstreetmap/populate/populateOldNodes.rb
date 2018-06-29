ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

ont_num = ARGV[1].to_i

begin
    puts "create old nodes"
    
    nodes = Node.all
    nod_num = nodes.length
    
    redactions = Redaction.all
    red_num = redactions.length
    for i in 1..ont_num
        node = nodes[rand(nod_num)]
        changeset = node.changeset
        lng = rand(changeset.min_lon..changeset.max_lon)
        lat = rand(changeset.min_lat..changeset.max_lat)
        redaction = redactions[rand(red_num)]
        old_node = OldNode.create(:node_id => node.id, :latitude => lat, :longitude => lng, :changeset_id => changeset.id, :timestamp => Time.new(rand(40) + 1970) , :visible => rand(2), :version => rand(10), :redaction => redaction)
        puts "create old node " + old_node.id.to_s
    end
    puts "finished old nodes"
end

begin
    puts "create old nodetags"
    old_nodes = OldNode.all
    old_num = old_nodes.length
    for i in 1..num
        old_node = old_nodes[rand(old_num)]
        k = (0...8).map { o[rand(o.length)] }.join
        v = (0...8).map { o[rand(o.length)] }.join 
        ont = OldNodeTag.create(:node_id => node.id, :k => k, :v => v, :version => old_node.version )
        puts "create old nodetag "
    end
    puts "finished old nodetags"
end