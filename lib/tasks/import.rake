# coding: utf-8
namespace :import do
  require 'yaml'


  desc 'import db from kontador/yaml'
  task :db => :environment do
    file = YAML.load_file('db/data/db.yml')
    file['organization'].each do |org_hash|
      Organization.create(org_hash)
    end

    file['bankaccs'].each do |bankacc_hash|
      Bankacc.create(bankacc_hash)
    end

    file['contacts'].each do |contact_hash|
      Contact.create(contact_hash)
    end

    file['addr'].each do |addr_hash|
      Addr.create(addr_hash)
    end

    file['products'].each do |hash|
      articul = hash['articul']
      if Product.where(articul: articul)
        articul = "#{articul} #{rand(20)}"
      end
      Product.create(hash.except('x', 'y', 'z', 'weight', 'vat', 'sku', 'tag', 'purchased', 'service', 'ean13', 'price', 'sku_id', 'articul').
                         merge(sale_price: hash['price'], sale_currency_id: 1, purchase_currency_id: 1, purchase_price: 0, articul: articul))
    end

    file['orders'].each do |hash|
      match = hash['number'].match(/(\d+)-\d+/) if hash['number']
      parent_id = match ? match[1] : nil
      Activity.create(from_organization_id: hash['from_id'],
                      to_organization_id: hash['to_id'],
      note: hash['note'],
      tag: hash['tag'],
      number: hash['number'],
      activity_type_id: 1, #order
                  sum_koef: 1,
                  date: hash['order_date'],
                  owner_user_id: 1,
                  parent_id: parent_id,
                  price: hash['price']
      )
    end

    file['order_links'].each do |hash|
      next unless hash['order_id']
      activity = Activity.find(hash['order_id'])
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
