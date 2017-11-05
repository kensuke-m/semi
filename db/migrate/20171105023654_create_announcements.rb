class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :contents
      t.integer :displayflag

      t.timestamps null: false
    end
  end
end
