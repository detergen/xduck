#!/usr/bin/env ruby

table = CSV.table(ARGV[0])
#puts YAML::dump(table)

prev_art1 = ""
prev_art2 = ""
prev_art3 = ""
prod1 = nil
prod2 = nil
prod3 = nil

euro = Currency.find_by code: 'EUR'
rouble = Currency.find_by code: 'RUR'

table.each {
  |row|
  if row[:art1] != prev_art1 then
    unless prod1.nil?
      prod1 = Product.find_by id: prod1.id

      prod1.sale_currency = rouble
      prod1.sale_price = prod1.get_sale_price

      prod1.save or puts YAML::dump(prod1.errors)
    end

    prod1 = Product.find_by articul: row[:art1]
    if prod1.nil? then
      #puts "Product " + row[:art1].to_s + " does not exist"
      prod1 = Product.new(:name => row[:name1], :articul => row[:art1], :active => true,
                          :forsale => true, :sizes => row[:size1])
      unless prod1.save
        puts "Cannot save product " + row[:art1].to_s
        puts YAML::dump(prod1.errors)
      end
    end
  end

  unless row[:art2].nil? || row[:art2].to_s.empty?
    prod2 = Product.find_by articul: row[:art2]
    if prod2.nil? then
      prod2 = Product.new(:name => row[:name2], :articul => row[:art2], :active => true,
                          :forsale => false)
      unless prod2.save
        puts "Cannot save product " + row[:art2]
        puts YAML::dump(prod2.errors)
      end
    end

    bom2 = Bom.find_by product_id: prod1.id, subproduct_id: prod2.id
    if bom2.nil? then
      bom2 = Bom.new(:product => prod1, :subproduct => prod2, :active => true, :qty => row[:qty2])
      unless bom2.save
        puts YAML::dump(bom2.errors)
      end
    end
  end

  unless row[:art3].nil? || row[:art3].to_s.empty?
    prod3 = Product.find_by articul: row[:art3]
    if prod3.nil? then
      prod3 = Product.new(:name => row[:name3], :articul => row[:art3], :active => true,
                          :forsale => false)
      unless prod3.save
        puts "Cannot save product " + row[:art3]
        puts YAML::dump(prod3.errors)
      end
    end

    bom3 = Bom.find_by product_id: prod2.id, subproduct_id: prod3.id
    if bom3.nil? then
      bom3 = Bom.new(:product => prod2, :subproduct => prod3, :active => true, :qty => row[:qty3])
      unless bom3.save
        puts YAML::dump(bom3.errors)
      end
    end
  end

  if !(row[:art3].nil? || row[:art3].to_s.empty?) then
    if prod3.purchase_price.nil? then
      prod3.purchase_currency = euro
      prod3.purchase_price = row[:price]
    end

    if prod3.sale_price.nil? then
      prod3.sale_currency = rouble
      prod3.sale_price = row[:total]
    end
    prod3.save or puts YAML::dump(prod3.errors)
  elsif !(row[:art2].nil? || row[:art2].to_s.empty?) then
    if prod2.purchase_price.nil? then
      prod2.purchase_currency = euro
      prod2.purchase_price = row[:price]
    end

    if prod2.sale_price.nil? then
      prod2.sale_currency = rouble
      prod2.sale_price = row[:total]
    end
    prod2.save or puts YAML::dump(prod2.errors)
  end


  prev_art1 = row[:art1]
  prev_art2 = row[:art2]
  prev_art3 = row[:art3]
}


