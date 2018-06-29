ARGV.each do|a|
puts "Argument#{ARGV.index(a)}: #{a}"
end
num_issues = ARGV[0].to_i


o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
o1 = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
10.times do o1.append(' ') end


puts "create issue"
users = User.all
groups = Group.all
projects = Project.all
statuses = ['opened', 'closed']

for i in 1..num_issues
    issue = Issue.new
    project = projects[rand(projects.length)]
    members = project.members 
    milestones = project.milestones
    if (members.length > 0)
        issue.title = (1..10).map {o[rand(o.length)]}.join
        issue.author_id = members[rand(members.length)].user_id
        issue.project_id = project.id
        issue.state = statuses[rand(statuses.length)]
        issue.created_at = Time.zone.now - rand(86400 * 365 * 2)
        issue.assignee_id = members[rand(members.length)].user_id
        issue.milestone_id = milestones[rand(milestones.length)]
        
        if issue.state == 'closed'
            issue.closed_at = rand(issue.created_at..Time.zone.now)
        end
        issue.save!
        
        puts "create issue " + issue.id.to_s
        
        labels = project.labels
        ll = LabelLink.new
        if labels.length > 0
            ll.label_id = labels[rand(labels.length)].id
            ll.target_type = 'Issue'
            ll.target_id = issue.id
            ll.created_at = rand(issue.created_at..issue.closed_at || Time.zone.now)
            ll.save!
            
            puts "create lable link ", ll.id.to_s
        end
        
        todo = Todo.new
        todo.project_id = project.id
        todo.target_id = issue.id
        todo.target_type = "Issue"
        todo.author_id = members[rand(members.length)].user_id
        todo.user_id = members[rand(members.length)].user_id
        todo.created_at = rand(issue.created_at..issue.closed_at || Time.zone.now)
        todo.action = 1
        todo.save!
        
        
        puts " create todo ", todo.id.to_s
        
        event = Event.new
        event.project_id = project.id
        event.target_type = 'Issue'
        event.action = 5
        event.data = (1..100).map {o1[rand(o1.length)]}.join
        event.author_id = issue.author_id
        event.created_at = rand(issue.created_at..issue.closed_at || Time.zone.now)
        event.save!
        puts " create event ", event.id.to_s
    end
    
end
