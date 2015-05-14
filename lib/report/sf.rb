class Report::SF < Report::General

  def build
    report = Report::Torg12.new(activity).prepare_data
    report.file.instance_variable_set(:@template, template_path(:sf))
    report.generate
  end

  def filename
    generate_filename('С-Ф')
  end

end