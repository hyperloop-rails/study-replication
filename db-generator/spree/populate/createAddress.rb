# generate products

ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
# random string
z = [(0..9)].map(&:to_a).flatten
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
countries = Spree::Country.all
states = Spree::State.all
for i in Range.new(1,num.to_i)
    firstname = (0...12).map { o[rand(o.length)] }.join
    lastname = (0...12).map { o[rand(o.length)] }.join
    address1 = (0...50).map { o[rand(o.length)] }.join
    address2 = (0...20).map { o[rand(o.length)] }.join
    city = (0...10).map { o[rand(o.length)] }.join
    zipcode = (0..5).map{ z[rand(z.length)] }.join
    phone = (0..11).map{ z[rand(z.length)] }.join
    state = states[rand(states.length)]
    country = countries[rand(countries.length)]
    Spree::Address.create(firstname: firstname,
    lastname: lastname,
    address1: address1,
    address2: address2,
    city: city,
    zipcode: zipcode,
    phone: phone,
    state: state,
    country: country
    )
end
