ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create users"
    for i in 1..num
        email = (0...8).map { o[rand(o.length)] }.join + "@example.com"
        name = (0...10).map { o[rand(o.length)] }.join
        username = (0...12).map { o[rand(o.length)] }.join
        password = "password"
        user = User.create(:email => email, :name => name, :username => username, :password => password )
        user.save!
        puts "create user " + user.id.to_s
    end
    puts "finish creating users"
end