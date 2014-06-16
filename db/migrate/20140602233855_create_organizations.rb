class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :tag
      t.string :opf
      t.string :short_name
      t.string :full_name
      t.string :inn
      t.string :kpp
      t.string :ogrn
      t.string :okpo

      t.timestamps
    end
  end
end
