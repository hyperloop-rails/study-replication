ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
filename = "group_users.txt.dat"
File.new(filename, "r")
re = []
IO.foreach(filename){|block|  re.push(block.to_i)}  
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create groups"
    for i in 1..re.length
        name =  (0...10).map { o[rand(o.length)] }.join
        g = Group.create(:name =>  name, :category => rand(10).to_s) 
        puts "create groups" + g.id.to_s
    end
    puts "finished create groups"
end
