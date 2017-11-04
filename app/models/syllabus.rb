class Syllabus < ActiveRecord::Base
  validates :subject_id, uniqueness: { scope: :staff_id,
    message: "が1人の教員に対して重複しています" }

  belongs_to :staff
  belongs_to :subject

  def self.import(file, id)
    spreadsheet = Roo::Spreadsheet.open(file)
    header = spreadsheet.column(1)
    column = Hash[[header, spreadsheet.column(2)].transpose]
    syllabus = find(id)
    syllabus.attributes = column.to_hash.slice(*column.to_hash.keys)
    syllabus.save!
  end
end
