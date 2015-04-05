# -*- encoding : utf-8 -*-
class Report::General

  include ActionView::Helpers::NumberHelper

  attr_reader :activity

  def initialize(activity)
    @activity = activity
  end

  # заполняем общие для всех репортов поля в репорт
  # и возвращаем его для возможности заполнения специфическими полями
  def fill_general_data(template)

    ODFReport::Report.new(template) do |r|
      r.add_field :order_number, activity.number
      r.add_field :order_document_date, activity.date.strftime("%d.%m.%Y")
      r.add_field :order_document_date_s, I18n.localize(activity.date, format: "%d %B %Y г")

      # Organization from fields
      r.add_field :from, from_organization.short_name
      r.add_field :from_inn, from_organization.inn
      r.add_field :from_kpp, from_organization.kpp
      r.add_field :from_law_address, from_organization.legal_address.string1

      # Organization "to" fields
      recipient = activity.to_organization.contacts.first.try(:short_name)
      r.add_field :to, to_organization.short_name
      r.add_field :to_inn, to_organization.inn
      r.add_field :to_kpp, to_organization.kpp
      r.add_field :to_law_address, to_organization.legal_address.string1
      r.add_field :recipient, recipient

      # Bank acc fields
      bank_acc_from = from_organization.bankaccs.first
      r.add_field :bank_ks, bank_acc_from.ks
      r.add_field :bank_rs, bank_acc_from.rs
      r.add_field :bank_bik, bank_acc_from.bik
      r.add_field :bank_fullname, bank_acc_from.full_name

      # Bank acc fields from
      bank_acc_to = from_organization.bankaccs.first
      r.add_field :bank_to_ks, bank_acc_to.ks
      r.add_field :bank_to_rs, bank_acc_to.rs
      r.add_field :bank_to_bik, bank_acc_to.bik
      r.add_field :bank_to_fullname, bank_acc_to.full_name


      #Totals and number to words lines
      r.add_field :total, number_to_currency(activity.total_price)
      r.add_field :vat_in, number_to_currency(activity.total_price_vat)
      r.add_field :pos_propisju, RuPropisju.propisju_shtuk(activity.activity_items.length, 3, ["наименование","наименования","наименований"])
      r.add_field :total_propisju, RuPropisju.rublej(activity.total_price)

      #Signatures
      r.add_field :sign1, from_organization.head_contact.short_name
      r.add_field :sign2, from_organization.book_contact.short_name
      r.add_field :post1, from_organization.head_contact.post
    end
  end

  def from_organization
    @from_organization ||= @activity.from_organization
  end

  def to_organization
    @to_organization ||= @activity.to_organization
  end

  def template_path(template_name)
    "#{Rails.root}/app/views/reports/#{template_name}.odt"
  end

  def generate_filename(type)
    "#{type}_№#{activity.number}_#{from_organization.name}-#{from_organization.name}" +
        "_#{activity.date.strftime('%d.%m.%Y')}_на_" +
        "#{number_to_currency(activity.total_price, unit: '')}.odt"
  end

end
