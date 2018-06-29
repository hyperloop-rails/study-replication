require 'lorem'
ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

begin
    puts "create redactions"
    users = User.all
    user_num = users.length
    for i in 1..num
        title = (0...8).map { o[rand(o.length)] }.join
        description = Lorem::Base.new('chars', 200).output
        user = users[rand(user_num)]
        redaction = Redaction.create(:title => title, :description => description, :user_id => user.id)
        puts "create redaction " + redaction.id.to_s
    end
    puts "finished redactions"
end