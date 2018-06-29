# generate products

ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
# random string 
products = Spree::Product.all
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
for i in Range.new(1,num.to_i)
    product = products[rand(products.length)]
    cost_price = rand(1000000)/Float(100)
    weight = rand(1000000)/Float(100)
    height = rand(1000000)/Float(100)
    width = rand(1000000)/Float(100) 
    depth = rand(1000000)/Float(100)
    tax_category_index = rand(tax_categories.length)
    tax_category = tax_categories[tax_category_index]
    v = product.variants.new
    v.cost_price = cost_price
    v.weight = weight
    v.height = height
    v.width = width
    v.depth = depth
    v.tax_category = tax_category
    v.save
    # (count_on_hand - count_pending_to_customer) > 0 so that available
    # random count_on_hand value 
end
