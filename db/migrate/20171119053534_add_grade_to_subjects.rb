class AddGradeToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :grade, :integer, default: 1
  end
end
