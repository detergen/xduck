class BankaccsController < ApplicationController

  def index
    render json: organization.bankaccs.as_json
  end


  def organization
    @organization ||= Organization.find(params[:organization_id])
  end


end
