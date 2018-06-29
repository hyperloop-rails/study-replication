ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
puts "populate users"
begin
    for i in 1..num
        puts "#{i}th user"
        name = (0...10).map { o[rand(o.length)] }.join
        email = (0...8).map { o[rand(o.length)] }.join + "@exapmle.com"
        password =  "12345678"
        initials =  (0...10).map { o[rand(o.length)] }.join
        user = User.create(:name => name, :initials => initials, :email => email, :password => password)
        user.confirm!
        user.save
    end

end