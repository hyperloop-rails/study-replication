ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
#  create default user
Spree::User.create(:email => 'abc@124.com', :password => 'abcdabcd', :confirmed_at => Time.zone.now)
begin
    file = File.open("/home/ubuntu/workspace/sandbox/populate/usersinfo.txt", "w")
    for i in 1..num
        first_name = (0...10).map { o[rand(o.length)] }.join
        last_name = (0...8).map { o[rand(o.length)] }.join
        email = (0...8).map { o[rand(o.length)] }.join + "@exapmle.com"
        password =  (0...10).map { o[rand(o.length)] }.join
        Spree::User.create(:email => email, :password => password, :confirmed_at => Time.zone.now)
        file.write(email + " " + password + "\n")
    end
    ensure
    file.close unless file.nil?
    
end