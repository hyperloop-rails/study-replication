ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create user"
    families = Family.all
    fam_num = families.length
    for i in 1..num
        email = (0...8).map { o[rand(o.length)] }.join + "@example.com"
        first_name = (0...10).map { o[rand(o.length)] }.join
        last_name = (0...8).map { o[rand(o.length)] }.join
        password = 'password'
        password_confirmation = 'password'
        mobile_phone = rand(100000).to_s
        birthday = rand(Date.civil(1970, 1, 1)..Date.civil(1994, 12, 31))
        c = Signup.new(:mobile_phone => mobile_phone, :birthday => birthday, :email => email, :first_name => first_name, :last_name => last_name, :password => password, :password_confirmation => password_confirmation)
        c.save
        pl = Person.order('id desc').limit(1)[0]
        f = families[rand(fam_num)]
        pl.family = f
        pl.password = 'password'
        pl.save
        puts "create user" + pl.id.to_s
    end
    puts "finished users"
end