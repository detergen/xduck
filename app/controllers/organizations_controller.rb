class OrganizationsController < ApplicationController

  def index

  end

  def bankaccs

  end

  def organization
    @organization ||= Organization.find(params[:id])
  end

end
