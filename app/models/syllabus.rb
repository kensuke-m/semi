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

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
     when '.csv' then Roo::Csv.new(file.path)
     when '.xls' then Roo::Excel.new(file.path)
     when '.xlsx' then Roo::Excelx.new(file.path)
     else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
