ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
num = num.to_i
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
for i in 1..num
    brand_name = (0...10).map { o[rand(o.length)] }.join
    Brand.create(:name => brand_name)
end