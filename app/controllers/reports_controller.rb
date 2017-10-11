class ReportsController < ApplicationController

  def bill
    report = ::Report::Bill.new(activity)
    send_data report.build,
              filename: report.filename,
              disposition: 'attachment',
              type: 'application/vnd.oasis.opendocument.text'
  end

  def upd
    report = ::Report::Upd.new(activity)
    send_data report.build,
              filename: report.filename,
              disposition: 'attachment',
              type: 'application/vnd.oasis.opendocument.text'
  end

  def torg12
    report = ::Report::Torg12.new(activity)
    send_data report.build,
              filename: report.filename,
              disposition: 'attachment',
              type: 'application/vnd.oasis.opendocument.text'
  end

  def sf
    report = ::Report::SF.new(activity)
    send_data report.build,
              filename: report.filename,
              disposition: 'attachment',
              type: 'application/vnd.oasis.opendocument.text'
  end

  def activity
    @activity ||= Activity.find(params[:activity_id])
  end

end
