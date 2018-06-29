ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
filename = "user_comments.txt.dat"
File.new(filename, "r")
re = []
IO.foreach(filename){|block|  re.push(block.to_i)}  

o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create comments"
    people = Person.all
    peo_num = people.length
    news = NewsItem.all
    new_num = news.length
    for person in people
        num = 0 
        index = people.index(person)
        if index < re.length
            num = re[index]
        end
        for i in 1..num
            text =  (0...10000).map { o[rand(o.length)] }.join
            c = Comment.create(:person => person, :recipe_id => people[rand(peo_num)].id, :news_item_id => news[rand(new_num)].id , :text => text)
            c.save
            puts "create comment" + c.id.to_s
        end
    end
    puts "finished create comments"
end
