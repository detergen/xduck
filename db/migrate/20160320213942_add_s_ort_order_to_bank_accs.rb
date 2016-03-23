class AddSOrtOrderToBankAccs < ActiveRecord::Migration
  def change
    add_column :bankaccs, :sort_order, :integer
  end
end
