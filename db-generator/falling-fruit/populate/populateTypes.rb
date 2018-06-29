ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
begin
    puts "create types"

    for i in 1..num
        name = (0...12).map { o[rand(o.length)] }.join 
        Type.create(:name => name)
    end
    puts "finished types"
end