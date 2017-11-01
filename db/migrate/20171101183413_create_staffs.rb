class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :username
      t.string :lastname
      t.string :firstname
      t.string :kana
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
