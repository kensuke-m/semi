class Charge < ActiveRecord::Base
  validates :subject_id, uniqueness: { scope: :staff_id,
    message: "が1人の教員に対して重複しています" }
  validates :capacity, numericality: { only_integer: true }

  belongs_to :staff
  belongs_to :subject

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      charge = find_by_id(row["id"]) || new
      charge.attributes = row.to_hash.slice(*row.to_hash.keys)
      charge.save!
    end
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
