class BankaccsController < ApplicationController

  def index
    render json: organization.bankaccs.sorted.as_json
  end


  def organization
    @organization ||= Organization.find(params[:organization_id])
  end


end
