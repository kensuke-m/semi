class Charge < ActiveRecord::Base
  validates :subject_id, uniqueness: { scope: :staff_id,
    message: "が1人の教員に対して重複しています" }
  validates :capacity, numericality: { only_integer: true }

  belongs_to :staff
  belongs_to :subject
end
