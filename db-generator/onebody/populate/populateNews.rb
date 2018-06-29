require 'lorem'
ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create news"
    people = Person.all
    peo_num = people.length
    for i in 1..num
        title =  (0...10).map { o[rand(o.length)] }.join
        body =  Lorem::Base.new('chars', 200).output
        link = "https://" + (0...10).map { o[rand(o.length)] }.join + ".com"
        home_phone = rand(1000000).to_s
        email = (0...8).map { o[rand(o.length)] }.join + "@example.com"
        n = NewsItem.new(:title => title, :body => body, :link => link, :person => people[rand(peo_num)])
        n.save
        puts "create news" + n.id.to_s
    end
    puts "finished create news"
end
