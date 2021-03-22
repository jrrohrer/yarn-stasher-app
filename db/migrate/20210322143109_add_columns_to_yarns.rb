class AddColumnsToYarns < ActiveRecord::Migration
  def change
    add_column :yarns, :num_of_skeins, :integer
    add_column :yarns, :yardage, :integer
  end
end
