# generate products

ARGV.each do|a|
  puts "Argument#{ARGV.index(a)}: #{a}"
end
num = ARGV[0]
# random string 
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
for i in Range.new(1,num.to_i)
    
    name = (0...12).map { o[rand(o.length)] }.join
    description = (0...50).map { o[rand(o.length)] }.join
    permalink = (0...20).map { o[rand(o.length)] }.join
    meta_keywords = (0...20).map { o[rand(o.length)] }.join
    price = rand(1000000)/Float(100)
    # Product
    # deleted_at = nil so that product is active
  
    
    tax_categories = Spree::TaxCategory.all
    tax_category_index = rand(tax_categories.length)
    tax_category = tax_categories[tax_category_index]
    
    shipping_categories = Spree::ShippingCategory.all
    shipping_category_index = rand(shipping_categories.length)
    shipping_category = shipping_categories[shipping_category_index]
    
    
    product = Spree::Product.create(:name => name, :description => description, :meta_keywords => meta_keywords, :available_on => Time.zone.now, :tax_category => tax_category, :shipping_category => shipping_category, :price => price)
    
    sku =  (0...20).map { o[rand(o.length)] }.join
    # variant
    
    cost_price = rand(1000000)/Float(100)
    weight = rand(1000000)/Float(100)
    height = rand(1000000)/Float(100)
    width = rand(1000000)/Float(100) 
    depth = rand(1000000)/Float(100)
    tax_category_index = rand(tax_categories.length)
    tax_category = tax_categories[tax_category_index]
    v = Spree::Variant.where(:product => product).first
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
