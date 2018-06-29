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
    # Product
    # deleted_at = nil so that product is active
    brands = Brand.all
    brand_index = rand(brands.length)
    brand = brands[brand_index]
    
    product_types = ProductType.all
    product_type_index = rand(product_types.length)
    product_type = product_types[product_type_index]
    
    prototypes = Prototype.all
    prototype_index = rand(prototypes.length)
    prototype = prototypes[prototype_index]
    
    shipping_categories = ShippingCategory.all
    shipping_category_index = rand(shipping_categories.length)
    shipping_category = shipping_categories[shipping_category_index]
    
    
    product = Product.create(:name => name, :description => description, :permalink => permalink, :brand => brand, :product_keywords => ['a','c'], :available_at => Time.zone.now, :product_type => product_type, :prototype => prototype, :shipping_category => shipping_category)

    # variant
    v = Variant.create(:product_id => product.id, :sku => 'ccd')
    # (count_on_hand - count_pending_to_customer) > 0 so that available
    # random count_on_hand value 
    v.inventory.count_on_hand = rand(10000)
    v.inventory.save
    # create image
    image_num = rand(10)
    for i in 1..image_num
        image = Image.create(:imageable_id => product.id, :imageable_type => 'Product', :image_height => 600, :image_width => 800, :position => 1, :caption => 'mi', :photo_file_name => 'fjall3004157661_q1_1-0._UX220_QL90_.jpg', :photo_content_type => 'image/jpeg', :photo_file_size => 46653)
        # copy imgs to the correspoding assets 
        base_dir = "/home/ubuntu/workspace/public/assets/products/"
        dest = base_dir + image.id.to_s
        src = base_dir + "11/"
        FileUtils.copy_entry(src, dest)
    end    
    
end
