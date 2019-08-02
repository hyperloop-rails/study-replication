require 'faker'
ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
puts "populate users"

def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

begin
    count = 0
    index = 0
    generator1 = Distribution::Normal.rng(500, 500)
    generator2 = Distribution::Normal.rng(10, 10)
    generator3 = Distribution::Normal.rng(10, 10)
    generator4 = Distribution::Normal.rng(5, 5)
    projects = []
    while(true)
        name = Faker::Name.name 
        first_name = Faker::Name.first_name 
        last_name = Faker::Name.last_name
        password =  "12345678"
        user = User.create(:login => first_name, :first_name => first_name, :last_name => last_name, :password => password, :password_confirmation => password)
        user.save
        index += 1
        projectCount = generator1.call.to_i
        if (projectCount < 0)
            projectCount = -projectCount
        end
        puts "create #{projectCount} projects for users #{user.id}"
        
        #projectCount = 1
        if (projectCount + count >= num)
            projectCount = num - count
        end
        count += projectCount
        projectCount.times do |i|
            projectName = Faker::Company.name
            description = Faker::Job.key_skill
            project = user.projects.new
            project.description = description
            project.name = projectName
            project.save
            projects << project
        end
        contextCount = generator2.call.to_i
        if contextCount < 0
            contextCount = -contextCount
        end
        contextCount.times do |i|
            context = user.contexts.new
            name = Faker::Job.title
            context.name = name
            context.save
        end
        puts "#{index}th user"
        if (count >= num)
            break
        end
    end
    
    tags = []
    rand(1000).times do |i|
        tag = Tag.new
        tag.name = Faker::Job.field
        tag.save
        tags << tag
    end
    puts "total #{tags.length} tags"
    index = 0
    projects.each do |p|
        recurring_todos = []
        recurringTodoCount = generator3.call.to_i
        if (recurringTodoCount < 0)
            recurringTodoCount = -recurringTodoCount
        end
        #todoCount = 1
        contexts = p.user.contexts
        length = contexts.length
        
        # generate notes for project
        notesCount = generator4.call.to_i
        if notesCount < 0
            notesCount = -notesCount
        end
        notesCount.times do |i|
            note = p.notes.new
            note.user_id = p.user_id
            note.project_id = p.id
            note.body = Faker::Name.name
            begin 
              note.save
            rescue
            end
        end
        puts "recurringTodo #{recurringTodoCount}"
        recurringTodoCount.times do |i|
            index += 1
            rtodo = p.recurring_todos.new
            description = Faker::Marketing.buzzwords
            contextIndex = rand(length).to_i
            context = contexts[contextIndex]
            rtodo.description = description
            rtodo.context = context
            rtodo.start_from = time_rand(Time.now, Time.now + 1.year)
            rtodo.notes = Faker::Marketing.buzzwords
            rtodo.recurring_period = ["daily", "weekly", "monthly", "yearly"][rand(4)]
            rtodo.every_other1 = rand(7)
            rtodo.every_other2 = rand(30)
            rtodo.every_other3 = rand(365)
            rtodo.every_day = %w{sunday monday tuesday wednesday thursday friday saturday}[rand(7)]
            rtodo.recurrence_selector = rand(1)
            if (rand(10) > 5)
                ends_on = "ends_on_number_of_times"
                rtodo.ends_on = ends_on
                rtodo.number_of_occurrences = rand(10)
            else      
                ends_on = "ends_on_end_date"
                rtodo.ends_on = ends_on
                rtodo.end_date = time_rand(rtodo.start_from, rtodo.start_from + rand(100).days)
            end
            if (rand(10) > 5)
                rtodo.target = "due_date"
                if (rand(10) > 5)
                    rtodo.show_always = true
                else
                    rtodo.show_always = false
                    rtodo.show_from_delta = rand(100)
                end
            else
                rtodo.target = "show_from_date"
            end
            rtodo.save!
            puts "rtodo #{rtodo.id}"
            recurring_todos << rtodo
            # tag rtodo
            tag = tags[rand(tags.length)]
            Tagging.create(:tag_id => tag.id, :taggable_id => rtodo.id, :taggable_type =>'RecurringTodo')
        end
        todoCount = generator3.call.to_i
        if (todoCount < 0)
            todoCount = -todoCount
        end
        #todoCount = 1
        contexts = p.user.contexts
        length = contexts.length
        todoCount.times do |i|
            index += 1
            todo = p.todos.new
            rtodo = recurring_todos[rand(recurringTodoCount)]
            todo.notes = Faker::Marketing.buzzwords
            description = Faker::Marketing.buzzwords
            todo.description = description
            todo.recurring_todo = rtodo
            contextIndex = rand(length).to_i
            context = contexts[contextIndex]
            todo.context = context if context
            todo.due = time_rand(Time.now, Time.now + 1.year)
            todo.save
            puts "created #{index}th todos"
        end
    end
end
