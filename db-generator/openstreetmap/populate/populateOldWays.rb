ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i

own_num = ARGV[1]
own_num = own_num.to_i

owt_num = ARGV[2]
owt_num = owt_num.to_i

o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create old ways"
    changesets = Changeset.all
    cha_num = changesets.length
    ways = Way.all
    redactions = Redaction.all
    for i in 1..num
        changeset = changesets[rand(cha_num)]
        way = ways[rand(ways.length)]
        redaction = redactions[rand(redactions.length)]
        visible = rand(2)
        version = rand(100) + 1
        if !  OldWay.exists?(:way_id => way.id, :version => version)
            ow = OldWay.create(:way_id => way.id, :changeset_id => changeset.id, :timestamp => Time.new(rand(40) + 1970) , :visible => visible, :version => version, :redaction => redaction)
            puts "create old way "
        end
    end
    puts "finished old ways"
end

begin
    puts "create old waynodes"
    ows = OldWay.all
    ons = Node.all
    for i in 1..own_num
        ow = ows[rand(ows.length)]
        on = ons[rand(ons.length)]
        sequence_id = rand(100)
        if ! OldWayNode.exists?(:way_id => ow.way_id, :sequence_id =>sequence_id, :version => ow.version)
            own = OldWayNode.create(:way_id => ow.way_id, :node_id => on.id, :version => ow.version, :sequence_id => sequence_id)
            puts "create old waynode "
        end
    end
    puts "finished old waynodes"
end

begin
    puts "create old way tags"
    owns = OldWay.all
    for i in 1..owt_num
        own = owns[rand(owns.length)]
        k = (0...8).map { o[rand(o.length)] }.join
        v = (0...8).map { o[rand(o.length)] }.join 
        owt = OldWayTag.create(:way_id => own.way_id, :k => k, :v => v, :version => own.version)
        puts "create old way tag " + owt.id.to_s
    end
    puts "finished old way tags"
end