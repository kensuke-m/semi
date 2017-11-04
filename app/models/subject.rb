class Subject < ActiveRecord::Base
  has_many :charges, dependent: :destroy
  has_many :recruitments, dependent: :destroy
  has_many :syllabuses, dependent: :destroy
end
