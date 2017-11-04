class Staff < ActiveRecord::Base
  belongs_to :course
  has_many :charges, dependent: :destroy
  has_many :recruitments, dependent: :destroy
  has_many :syllabuses, dependent: :destroy
end
