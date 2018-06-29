ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
User.create(:first_name => "hello", :last_name => "world", :email => "abc@124.com", :password => "abcdabcd")
begin
    file = File.open("/home/ubuntu/workspace/populate/usersinfo.txt", "w")
    for i in 1..num
        first_name = (0...10).map { o[rand(o.length)] }.join
        last_name = (0...8).map { o[rand(o.length)] }.join
        email = (0...8).map { o[rand(o.length)] }.join + "@exapmle.com"
        password =  (0...10).map { o[rand(o.length)] }.join
        User.create(:first_name => first_name, :last_name => last_name, :email => email, :password => password)
        file.write(email + " " + password + "\n")
    end
    ensure
    file.close unless file.nil?
    
end