ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i

begin
    puts "create memberships"
    people = Person.all
    peo_num = people.length
    groups = Group.all
    gro_num = groups.length
    for i in 1..num
        m = Membership.create(:group_id => groups[rand(gro_num)].id, :person_id => people[rand(peo_num)].id, :share_address => rand(2), :share_mobile_phone => rand(2), :share_work_phone => rand(2), :share_fax => rand(2), :share_email => rand(2) )
        puts "create membership" + m.id.to_s
    end
    puts "finished create memberships"
end
