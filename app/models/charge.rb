class Charge < ActiveRecord::Base
  belongs_to :staff
  belongs_to :subject
end
