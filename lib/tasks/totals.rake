# coding: utf-8
namespace :totals do

  task :defaults => :environment do
    Total.create(name: 'Сумма заказа', expression: 'orders_sum', sort_order:1, is_active: true)
    Total.create(name: 'Сумма отгрузок', expression: 'shipping_sum', sort_order:2, is_active: true)
    Total.create(name: 'Оплата', expression: 'payments_sum', sort_order:3, is_active: true)
    Total.create(name: 'Долг по отгрузкам', expression: 'orders_sum - shipping_sum', sort_order:4, is_active: true)
    Total.create(name: 'Отгружено не оплачено', expression: 'shipping_sum - payments_sum', sort_order:5, is_active: true)
    Total.create(name: 'Процент отгрузки', expression: '(shipping_sum / orders_sum) * 0.01', sort_order:6, is_active: true)
  end


end
