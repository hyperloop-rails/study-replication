ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num_projects = ARGV[0].to_i

members_proj = ARGV[1].to_i
milestones_proj = ARGV[2].to_i
tags_proj = ARGV[3].to_i
labels_proj = ARGV[4].to_i
stars = ARGV[5].to_i
 
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
o1 = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
10.times do o1.append(' ') end

services = ['AsanaService','AssemblaService','BambooService','BuildkiteService','BuildsEmailService',   'CampfireService','CustomIssueTrackerService','DroneCiService','EmailsOnPushService','ExternalWikiService','FlowdockService','GemnasiumService','HipchatService',          'IrkerService',      'JiraService',                           'PivotaltrackerService','PushoverService','RedmineService','SlackService',             'TeamcityService']
properties = ["{}",        "{}",             "{}",           "{}","{\"notify_only_broken_builds\":true}","{}",            "{}",                       "{}",            "{}",                 "{}",                  "{}",            "{}",  "{\"notify_only_broken_builds\":true}","{}", "{\"api_url\":\"\",\"jira_issue_transition_id\":\"2\"}","{}",                   "{}",             "{}", "{\"notify_only_broken_builds\":true}","{}"]
categories = ['common',    'common',         'ci',           'ci',               'common',               'common',        'issue_tracker',            'ci',            'common',             'common',              'common',        'common',           'common',                 'common',            'issue_tracker',                         'common',               'common',         'issue_tracker', 'common',                   'ci'] 

begin
    puts "create projects"
    users = User.all
    namespaces = Namespace.all
    groups = Group.all
    access_levels = [10, 20, 30, 40, 50]
    for i in 1..num_projects
        project = Project.new
        project.name = (1..10).map {o[rand(o.length)]}.join
        project.description = (0..100).map {o1[rand(o1.length)]}.join
        project.path = (1..10).map {o[rand(o.length)]}.join
        project.creator = users[rand(users.length)]
        project.namespace = namespaces[rand(namespaces.length)]
        project.save!
        puts "create project " + project.id.to_s
        
        pid = ProjectImportData.new
        pid.project_id = project.id
        pid.data = (1..rand(1000)).map {o[rand(o.length)]}.join
        pid.encrypted_credentials_iv = "\"" +  (1..22).map {o[rand(o.length)]}.join  + "==  \n\""
        pid.encrypted_credentials_salt = (1..16).map {o[rand(o.length)]}.join
        pid.save!
        
        for s in services
            service = Service.new
            service.type = s
            service.project_id = project.id
            service.save!
        end
        
        event = Event.new
        event.project_id = project.id
        event.action = 1
        event.author_id = project.creator.id
        event.save!
        
    end
    puts "finish create projects"
    projects = Project.all
    pro_ids = projects.ids
    user_ids = users.ids
    for i in 1..members_proj
        member = Member.new
        member.type = "ProjectMember"
        member.source_type = "Project"
        member.user_id = user_ids[rand(user_ids.length)]
        member.access_level = access_levels[rand(access_levels.length)]
        member.notification_level = 3
        member.source_id = pro_ids[rand(pro_ids.length)]
        if ! Member.exists?(:source_type => 'Project', :source_id => member.source_id, :user_id => member.user_id)
            member.save!
        end
        puts "create member " + member.id.to_s
    end
    
    puts "finish create members"
    for i in 1..tags_proj
        event = Event.new
        project = projects[rand(projects.length)]
        event.project_id = project.id
        event.action = 5
        event.data = (1..100).map {o1[rand(o1.length)]}.join
        event.author_id = project.creator.id
        event.save!
        
        release = Release.new
        release.description = (1..rand(7..1000)).map {o1[rand(o1.length)]}.join
        release.project_id = project.id
        release.tag = (1..rand(3..20)).map {o[rand(o.length)]}.join
        release.save!
    end
    
    puts "finish create tags"
    
    for i in 1..labels_proj
       label = Label.new
       label.type = "ProjectLabel"
       label.title = (0..15).map {o[rand(o.length)]}.join
       label.color = "#5CB85C"
       label.project_id = projects[rand(projects.length)]
       label.save!
    end
    
    
    puts "finish create labels"
    for i in 1..stars
        usp = UsersStarProject.new
        usp.project_id = projects[rand(projects.length)].id
        usp.user_id = users[rand(users.length)].id
        if !UsersStarProject.exists?(:project_id => usp.project_id, :user_id => usp.user_id)
            usp.save!
        end
    end
    
    puts "finish create stars"
    for i in 1..milestones_proj 
        milestone = Milestone.new
        project = projects[rand(projects.length)]
        milestone.project_id = project.id
        milestone.description = (1..rand(5..1000)).map {o1[rand(o1.length)]}.join
        milestone.title = (1..rand(5..15)).map {o[rand(o.length)]}.join
        milestone.due_date = Time.zone.now + rand(86400 * 365)
        milestone.save!
        
        event = Event.new
        event.project_id = project.id
        event.action = 5
        event.data = (1..100).map {o1[rand(o1.length)]}.join
        event.author_id = project.creator.id
        event.save!
 
    end
  
    puts "finish create milestones"
end