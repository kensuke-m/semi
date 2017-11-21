class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :subject, index: true, foreign_key: true
      t.references :staff, index: true, foreign_key: true
      t.string :studentusername
      t.string :studentname
      t.text :reason
      t.integer :permission, default: -1

      t.timestamps null: false
    end
  end
end
