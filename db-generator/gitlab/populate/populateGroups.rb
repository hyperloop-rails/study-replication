ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
filename = "group_users.txt.dat"
File.new(filename, "r")
re = []
IO.foreach(filename){|block|  re.push(block.to_i)}
num_groups = re.length

 
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
o1 = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
10.times do o1.append(' ') end


begin
    puts "create groups"
    users = User.all
    for i in 1..num_groups
        group = Group.new
        group.name = (0..10).map {o[rand(o.length)]}.join
        group.owner_id = users[rand(users.length)].id
        group.description = (0..100).map {o1[rand(o1.length)]}.join
        group.path = (0..30).map {o[rand(o.length)]}.join
        group.save!
        
        puts "create group " + group.id.to_s
    end
    
    groups = Group.all
    puts "create members"
    for group in groups
        index = groups.index(group)
        num_members = 0
        if index < re.length
            num_members = re[index]
        end
        for i in 1..num_members
            member = Member.new
            member.type = "GroupMember"
            member.source_type = "Namespace"
            member.user_id = users[rand(users.length)].id
            member.access_level = 50
            member.notification_level = 3
            member.source_id = group.id
            if ! Member.exists?(:source_id => member.source_id, :user_id => member.user_id)
                member.save!
            end
            
            puts "create member " + member.id.to_s
        end
    puts "finish creating memberss"
end