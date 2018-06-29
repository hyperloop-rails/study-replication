ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
filename = "../user_posts.txt.dat"
File.new(filename, "r")
re = []
IO.foreach(filename){|block|  re.push(block.to_i)}  
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
begin
    users = User.all
    puts "Start posts"
    for u in users
        p = u.person
        index = users.index(u)
        num = re[index] if index < re.length | 0
        for i in 1..num
            text = (0...100).map { o[rand(o.length)] }.join
            Post.create(:author_id => p.id, :public => true, :type => 'StatusMessage',  :text => text)       
        end
    end
    puts "finish posts"
end