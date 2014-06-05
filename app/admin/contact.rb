ActiveAdmin.register Contact do
permit_params     :name, :short_name, :full_name, :to_name, :post, :phone1, :phone2, :phone3, :phone4, :key, :tag, :note, :pasp_series, :pasp_number, :pasp_date, :pasp_given, :pasp_kp, :address, :organization_id

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
