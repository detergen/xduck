ActiveAdmin.register Bankacc do
  permit_params :name, :full_name, :ks, :rs, :bik, :organization_id

end
