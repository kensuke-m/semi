class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :staff, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
