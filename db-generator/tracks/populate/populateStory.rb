ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
puts "populate stories"
begin
    users = User.all
    projects = Project.all
    types = ['feature', 'bug', 'chore', 'release']
    states = ['unstarted', 'accepted', 'started', 'finished', 'delivered', 'unscheduled']
    for i in 1..num
        puts "#{i}th stories"
        title = (0...10).map { o[rand(o.length)] }.join
        description = (0...8).map { o[rand(o.length)] }.join + "@exapmle.com"
        story_type = types[rand(types.length)]
        state = states[rand(states.length)]
        owner = users[rand(users.length)]
        owned_by_id = owner.id
        requester = users[rand(users.length)]
        requested_by_id = requester.id
        project = projects[rand(projects.length)]
        project_id = project.id
        owner.projects.append(project)
        requester.projects.append(project)
        owner.save!
        requester.save!
        accepted_at = Time.zone.now - rand(2 * 365 * 86400)
        s = Story.create(:title => title, :description => description, :story_type => story_type, :owned_by_id => owned_by_id, :project_id => project_id, :requested_by_id => requested_by_id, :state => state, :accepted_at => accepted_at, :created_at => accepted_at - rand(2 * 365 * 86400))
        s.save!
    end

end