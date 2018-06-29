ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
filename = "family_users.txt.dat"
File.new(filename, "r")
re = []
IO.foreach(filename){|block|  re.push(block.to_i)}  

o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create families"
    for i in 1..re.length
        name =  (0...10).map { o[rand(o.length)] }.join
        last_name =  (0...8).map { o[rand(o.length)] }.join
        zip = rand(99999)
        home_phone = rand(1000000).to_s
        email = (0...8).map { o[rand(o.length)] }.join + "@example.com"
        f = Family.create(:name => name, :last_name => last_name, :zip => zip, :home_phone => home_phone, :email => email)
        puts "create family" + f.id.to_s
    end
    puts "finished create families"
end
