# -*- encoding : utf-8 -*-
class Report::Upd < Report::General
  def prepare_data
    report = fill_general_data(template_path(:upd))

    @posnumber = 0 #Initial number for order lines (items)
    report.add_table("TABLE_1", activity.activity_items, header: true) do |t|
      t.add_column(:id) {@posnumber +=1}
      t.add_column(:articul) {|activity_item| activity_item.product.try(:articul) }
      t.add_column(:product) {|activity_item| activity_item.product.try(:name) }
      t.add_column (:item_qty) {|activity_item| number_with_precision(activity_item.quantity,
                                                                      :precision => 5,
                                                                      :significant => true,
                                                                      :strip_insignificant_zeros  => true)}
      t.add_column (:item_qty_human) {|activity_item| RuPropisju.propisju_shtuk(number_with_precision(activity_item.quantity,
                                                                                                      :precision => 5,
                                                                                                      :significant => true,
                                                                                                      :strip_insignificant_zeros  => true),
                                                                                1, [])}
      t.add_column (:price) {|activity_item| number_to_currency(activity_item.price_without_vat, unit: '')}
      t.add_column (:price_vat) {|activity_item| number_to_currency(activity_item.total_price_without_vat, unit: '')}
      t.add_column (:vat) {|activity_item| number_to_currency(activity_item.total_vat, unit: '')}
      t.add_column(:sumprice) {|activity_item| number_to_currency(activity_item.total_price, unit: '')}
      t.add_column(:sku) {|activity_item| activity_item.product.try(:name)}
      t.add_column(:uom) {|activity_item| activity_item.product.try(:measure)}
    end

    #TODO add weight for ordr_lines
    #Totals and number to words lines
    report.add_field :total_vat, number_to_currency((activity.total_price)*(1.0-1.0/6), unit: '')
    report
  end

  def build
    prepare_data.generate
  end

  def filename
    generate_filename("УПД")
  end

end
