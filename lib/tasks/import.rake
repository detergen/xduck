# coding: utf-8
namespace :import do
  require 'yaml'


  desc 'import db from kontador/yaml'
  task :db => :environment do
    file = YAML.load_file('db/data/db.yml')
    file['organization'].each do |org_hash|
      Organization.create(org_hash)
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE organizations_id_seq RESTART WITH #{Organization.last.id + 1}")

    file['bankaccs'].each do |bankacc_hash|
      Bankacc.create(bankacc_hash)
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE bankaccs_id_seq RESTART WITH #{Bankacc.last.id + 1}")


    file['contacts'].each do |contact_hash|
      Contact.create(contact_hash)
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE contacts_id_seq RESTART WITH #{Contact.last.id + 1}")


    file['addr'].each do |addr_hash|
      Addr.create(addr_hash)
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE addrs_id_seq RESTART WITH #{Addr.last.id + 1}")

    file['products'].each do |hash|
      articul = hash['articul']
      if Product.where(articul: articul)
        articul = "#{articul} #{rand(20)}"
      end
      Product.create(hash.except('x', 'y', 'z', 'weight', 'vat', 'sku', 'tag', 'purchased', 'service', 'ean13', 'price', 'sku_id', 'articul').merge(sale_price: hash['price'], sale_currency_id: 1, purchase_currency_id: 1, purchase_price: 0, articul: articul))
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE products_id_seq RESTART WITH #{Product.last.id + 1}")


    file['orders'].each do |hash|
      match = hash['number'].match(/(\d+)-\d+/) if hash['number']
      parent_number = match ? match[1] : nil
      parent = Activity.find_by_number(parent_number) if parent_number
      activity = Activity.new(
          id: hash['id'],
          from_organization_id: hash['from_id'],
          to_organization_id: hash['to_id'],
          note: hash['note'],
          tag: hash['tag'],
          number: hash['number'],
          activity_type_id: 1, #order
          sum_koef: 1,
          date: hash['order_date'],
          owner_user_id: 1,
          parent: parent,
          price: hash['price'])
      activity.save(validate: false)
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE activities_id_seq RESTART WITH #{Activity.last.id + 1}")


    file['order_links'].each do |hash|
      next unless hash['order_id']
      activity = Activity.find_by_id(hash['order_id'])
      next unless activity
      if activity.child?
        destination_activity = activity
      else
        destination_activity = activity.children.select{ |a| a.number == "Sub #{activity.number}"}.first
        unless destination_activity
          destination_activity = activity.dup
          destination_activity.parent = activity
          destination_activity.number = "Sub #{activity.number}"
          destination_activity.save
        end

      end
      item = destination_activity.activity_items.build(id: hash['id'], product_id: hash['product_id'], quantity: hash['qty'], price: hash['price'])
      item.save
    end

    Activity.all.each{ |a| a.recalculate_total }

  end

  task :clean_db => :environment do
    Organization.delete_all
    Bankacc.delete_all
    Contact.delete_all
    Addr.delete_all
    Product.delete_all
    Activity.delete_all
    ActivityItem.delete_all
    ['active_admin_comments', 'activities', 'activity_items', 'activity_types', 'addrs',
     'articles', 'products', 'bankaccs', 'boms', 'contacts', 'currencies', 'exchange_rates',
    'organizations', 'organizations_users', 'roles', 'users', 'users_roles'].each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE #{table} RESTART IDENTITY")
    end

  end

end
