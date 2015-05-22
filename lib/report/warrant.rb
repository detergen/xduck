# -*- encoding : utf-8 -*-
class Report::Warrant < Report::General

  # todo: finish before useing
  def build
    report = fill_general_data(template_path(:warrant))

    r.add_field :test, @ohash["warrant"].contact.name

    #Order lines
    @posnumber = 0 #Initial number for order lines (items)
    report.add_table("TABLE_1", @ohash["orderlines"], :header=>true) do |t|
      t.add_column(:id) {@posnumber +=1}
      t.add_column(:articul) {|order_line| order_line.product.articul}
      t.add_column(:product) {|order_line| order_line.product.name }
      t.add_column (:item_qty) {|order_line| nc.number_with_precision(order_line.qty, :precision => 5, :significant => true, :strip_insignificant_zeros  => true)}
      t.add_column (:item_qty_human) {|order_line| RuPropisju.propisju_shtuk(nc.number_with_precision(order_line.qty, :precision => 5, :significant => true, :strip_insignificant_zeros  => true), 1, [])}
      t.add_column (:price) {|order_line| nc.number_to_currency(order_line.price,:unit => "")}
      t.add_column(:sumprice) {|order_line| nc.number_to_currency(order_line.sum_price,:unit => "")}
      t.add_column(:sku) {|order_line| order_line.product.sku[:name]}
      t.add_column(:uom) {|order_line| order_line.product.sku[:measure]}
    end

    #Warrant owner
    report.add_field :warrant_id, @ohash["warrant"].id
    report.add_field :warrant_date, @ohash["warrant"].date.strftime("%d.%m.%Y")
    report.add_field :warrant_date_till, @ohash["warrant"].date_till.strftime("%d.%m.%Y")
    report.add_field :name, @ohash["warrant"].contact.to_name

    #Warrant owner's passport data
    report.add_field :pasp_series, @ohash["warrant"].contact.pasp_series
    report.add_field :pasp_number, @ohash["warrant"].contact.pasp_number
    report.add_field :pasp_date, @ohash["warrant"].contact.pasp_date
    report.add_field :pasp_given, @ohash["warrant"].contact.pasp_given

    report.generate
  end

  def filename
    generate_filename('Доверенность')
  end

end
