ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :roles, :organizations, :role_ids => [], :organization_ids => []
	#controller.authorize_resource

  controller do
    def current_ability
      @current_ability ||= AdminAbility.new(current_admin_user)
    end
  end

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column "Role" do |user|
      (user.roles.map{ |p| p.name }).join(', ')
    end
    column "Organizations" do |user|
      (user.organizations.map{ |p| p.name }).join(', ')
    end
    actions
  end

  filter :email

  form do |f|
    tabs do
      tab 'Basic' do
        f.inputs "User Details" do
          f.input :email
          if f.object.new_record?
            f.input :password, required: false
            f.input :password_confirmation
          end
          f.input :roles, :as => :check_boxes
          f.input :organizations, :as => :check_boxes
        end
      end

      tab 'Password Change' do
        f.inputs "User Details" do
          f.input :email
          f.input :password, required: false
          f.input :password_confirmation
        end
      end
    end
    f.actions
  end
end
