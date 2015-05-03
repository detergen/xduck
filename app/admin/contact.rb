ActiveAdmin.register Contact do
  permit_params :name, :short_name, :full_name, :to_name, :post,
                :phone1, :phone2, :phone3, :phone4, :contact_key, :tag, :note,
                :pasp_series, :pasp_number, :pasp_date, :pasp_given,
                :pasp_kp, :address, :organization_id, :organization
  
end
