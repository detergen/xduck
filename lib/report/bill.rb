# -*- encoding : utf-8 -*-
class Report::Bill < Report::General

  #Return report and filename for send_file in controller
  def build
    report = fill_general_data(template_path(:bill))

    #Order lines
    @posnumber = 0 #Initial number for order lines (items)
    report.add_table("TABLE_1", activity.activity_items, header: true) do |t|
      t.add_column(:id) {@posnumber +=1}
      t.add_column(:articul) {|activity_item| activity_item.product.articul}
      t.add_column(:product) {|activity_item| activity_item.product.name }
      t.add_column (:item_qty) {|activity_item| number_with_precision(activity_item.quantity,
                                                                      precision: 5,
                                                                      significant: true,
                                                                      strip_insignificant_zeros: true)}
      t.add_column (:price) {|activity_item| number_to_currency(activity_item.price, unit: '')}
      t.add_column(:sumprice) {|activity_item| number_to_currency(activity_item.total_price, unit: '')}
      t.add_column(:sku) {|activity_item| activity_item.product.name}
      t.add_column(:uom) {|activity_item| activity_item.product.measure}
    end

    report.generate
  end

  def filename
    generate_filename("Счет")
  end

end
