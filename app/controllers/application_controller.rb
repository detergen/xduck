class ApplicationController < ActionController::Base
  before_action :set_locale
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end


  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  protect_from_forgery
    def authenticate_admin_user!
        authenticate_user!
        #unless current_user.has_role? :admin
        #    flash[:alert] = 'You are not authorized to access this resource!'
        #    redirect_to root_path
        #end
    end
end
