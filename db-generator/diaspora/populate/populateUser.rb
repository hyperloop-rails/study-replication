ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
#num = ARGV[0]
#num = num.to_i
filename = "../user_users.txt"
File.new(filename, "r")
re = []
IO.foreach(filename){|block|  re.push(block.to_i)}  

o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
puts "populate users"
begin
    for i in 1..re.length
        puts "#{i}th user"
        username = (0...10).map { o[rand(o.length)] }.join
        email = (0...8).map { o[rand(o.length)] }.join + "@exapmle.com"
        password =  "12345678"
        opt = {:username => username, :email => email, :password => password, color_theme: "original", language: "en"}
        user = User.build(opt)
        user.save
    end
    users = User.all
    puts "start relationship between users"

    for u in users
        index = users.index(u)
        num = re[index].to_i if index < re.length
        count = 0
        while(True)
            u2 =ruesers[rand(users.length)]
            p2 = u2.person
            sharing = rand(2)
            receiving = rand(2)
            if sharing || saving and !Contact.exists?(:user => u, :person => p2, :sharing => sharing, :receiving =>receiving)
                Contact.create(:user => u, :person => p2, :sharing => sharing, :receiving =>receiving)
                count = count + 1
            end
            if count > num
                next 
            end
        end
    end
    puts "finish users relationship"
end