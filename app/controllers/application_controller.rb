class ApplicationController < ActionController::Base
  protect_from_forgery
<<<<<<< HEAD
    def authenticate_admin_user!
        authenticate_user!
        #unless current_user.has_role? :admin
        #    flash[:alert] = 'You are not authorized to access this resource!'
        #    redirect_to root_path
        #end
    end
=======
>>>>>>> 1200571a19aad4a8b8271d24fdce6e7a0dc09450
end
