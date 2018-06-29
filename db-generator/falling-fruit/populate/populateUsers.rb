ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create user"
    for i in 1..num
        email = (0...8).map { o[rand(o.length)] }.join + "@example.com"
        address = (0...16).map { o[rand(o.length)] }.join 
        u = User.create(:email => email, :password => 'password', :address => address)
        u.confirm!
        u.save!
    end
    puts "finished users"
end