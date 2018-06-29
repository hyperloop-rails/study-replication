ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
begin
    users = User.all
    for u in users
        for i in 1..rand(num)
            puts "#{i}th aspects"
            name = (0...10).map { o[rand(o.length)] }.join
            Aspect.create(:name => name, :user_id => u.id)
        end
    end
    for u in users
        contacts = u.contacts
        aspects = u.aspects
        for c in contacts
            index = rand(aspects.length)
            if aspects.length != 0 and !AspectMembership.exists?(:aspect => aspects[index], :contact => c)
               AspectMembership.create(:aspect => aspects[index], :contact => c)
            end
        end
    end

    puts "finish aspects"
end