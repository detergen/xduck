class DatePickerInput < SimpleForm::Inputs::StringInput
  def input
    value = object.send(attribute_name) if object.respond_to? attribute_name
    display_pattern = I18n.t('datepicker.dformat', :default => '%d/%m/%Y')
    input_html_options[:value] ||= I18n.localize(value, :format => display_pattern) if value.present?

    input_html_options[:type] = 'text'
    picker_pettern = I18n.t('datepicker.pformat', :default => 'DD/MM/YYYY')

    template.content_tag :div, class: 'datepicker' do
      input = super # leave StringInput do the real rendering

    end
  end

  def input_html_classes
    super.push ''   # 'form-control'
  end
end
