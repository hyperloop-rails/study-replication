# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require 'lorem'
ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i

# relation tags num
rt_num = ARGV[1]
rt_num = rt_num.to_i

# relation members num
rm_num = ARGV[2]
rm_num = rm_num.to_i

o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

relations = Relation.all
puts "create old relations"
num.times.map do |i|
    relation = relations[rand(relations.length)]
    if ! OldRelation.exists?(:relation_id => relation.id, :version => relation.version)
        r = OldRelation.create(:relation_id => relation.id, :changeset_id => relation.changeset_id, :timestamp => Time.zone.now - rand(86400 * 365 * 2) , :visible => rand(2), :version => relation.version)
        puts "create old relation " + r.id.to_s
    end
end

puts "finished old relations"

puts "create old relation tags"
relations = OldRelation.all

rt_num.times.map do |i|
    relation = relations[rand(relations.length)]
    k = (0..8).map {o[rand(o.length)]}.join
    v = (0..8).map {o[rand(o.length)]}.join
    rt = OldRelationTag.create(:relation_id => relation.relation_id, :k => k, :v => v, :version => relation.version)
    puts "create old relation tag "  + i.to_s
end

puts "finish old relation tags"

puts "create old relation members"
nodes = Node.all
ways = Way.all
member_types = ['Node', 'Way', 'Relation']
mem_roles = ['administrator', 'moderator']
rm_num.times.map do |i|
    member_type = member_types[rand(member_types.length)]
    relation = relations[rand(relations.length)]
    mem_role = mem_roles[rand(mem_roles.length)]
    member = nil
    if member_type == 'Node'
        member = nodes[rand(nodes.length)]
    elsif member_type == 'Way'
        member = ways[rand(ways.length)]
    elsif member_type == 'Relation'
        member = Relation.find(relations[rand(relations.length)].relation_id)
    end
    rm = RelationMember.create(:relation_id => relation.relation_id, :member_type => member_type, :member => member, :member_role => mem_role)
    puts "create old relation member " + i.to_s        
end

puts "create old relation members"