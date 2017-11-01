class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.references :staff, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
