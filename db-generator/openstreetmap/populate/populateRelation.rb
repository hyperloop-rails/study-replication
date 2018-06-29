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

changesets = Changeset.all
cha_num = changesets.length
puts "create relations"
num.times.map do |i|
    changeset = changesets[rand(cha_num)]
    r = Relation.create(:changeset_id => changeset.id, :timestamp => Time.new(rand(40) + 1970) , :visible => rand(2), :version => 1)
    puts "create relation " + r.id.to_s
end

puts "finished relations"

puts "create relation tags"
relations = Relation.all

rt_num.times.map do |i|
    relation = relations[rand(relations.length)]
    k = (0..8).map {o[rand(o.length)]}.join
    v = (0..8).map {o[rand(o.length)]}.join
    rt = RelationTag.create(:relation_id => relation.id, :k => k, :v => v)
    puts "create relation tag "  + i.to_s
end

puts "finish relation tags"

puts "create relation members"
nodes = Node.all
ways = Way.all
member_types = [   'Node', 'Way', 'Relation']
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
        member = relations[rand(relations.length)]
    end
    rm = RelationMember.create(:relation => relation, :member_type => member_type, :member => member, :member_role => mem_role)
    puts "create relation member " + i.to_s        
end

puts "create relation members"