class Staff < ActiveRecord::Base
  belongs_to :course
  has_many :charges, dependent: :destroy
end
