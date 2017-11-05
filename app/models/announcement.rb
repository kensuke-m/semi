class Announcement < ActiveRecord::Base
  validates :contents, presence: true
  validates :displayflag, numericality: { only_integer: true }
end
