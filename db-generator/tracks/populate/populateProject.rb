ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
puts "populate projects"
begin

    for i in 1..num
        puts "#{i}th project"
        name = (0...10).map { o[rand(o.length)] }.join
        start_date = Time.zone.now - rand(365 * 2 * 86400)
        created_at = rand(start_date..Time.zone.now)
        iteration_length = rand(1..4)
        pj  = Project.create(:name => name, :start_date => start_date, :created_at => created_at, :iteration_length => iteration_length)
        pj.save!
    end
 
end