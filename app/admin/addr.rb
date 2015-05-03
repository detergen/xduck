ActiveAdmin.register Addr do
  permit_params :name, :typeofaddr, :postindex, :string1, :string2,
                :address_key, :note, :organization_id, :contact_id
  
end
