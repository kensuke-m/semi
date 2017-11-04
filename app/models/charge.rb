class Charge < ActiveRecord::Base
  validates :subject_id, uniqueness: { scope: :staff_id,
    message: "が1人の教員に対して重複しています" }
  validates :capacity, numericality: { only_integer: true }

  belongs_to :staff
  belongs_to :subject

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      charge = find_by_id(row["id"]) || new
      charge.attributes = row.to_hash.slice(*row.to_hash.keys)
      charge.save!
    end
  end
end
