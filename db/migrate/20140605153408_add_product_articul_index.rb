class AddProductArticulIndex < ActiveRecord::Migration
  def up
    add_index "products", ["articul"], name: "idx_prodcuts_articul", unique: true
  end

  def down
    remove_index "products", name: "idx_prodcuts_articul"
  end
end
