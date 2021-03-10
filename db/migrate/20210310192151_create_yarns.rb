class CreateYarns < ActiveRecord::Migration
  def change
    create_table :yarns do |t|
      t.string :name
      t.string :color
      t.string :weight
      t.string :fiber
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
