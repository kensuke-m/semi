class CreateSyllabuses < ActiveRecord::Migration
  def change
    create_table :syllabuses do |t|
      t.references :staff, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.text :subtitle
      t.text :goal
      t.text :abstract
      t.text :plan
      t.text :evaluationmethod
      t.text :textbook
      t.text :referencebook
      t.text :selectionmethod
      t.text :remarks

      t.timestamps null: false
    end
  end
end
