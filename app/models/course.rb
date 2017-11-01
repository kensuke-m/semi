class Course < ActiveRecord::Base
  has_many :staffs
  before_destroy :ensure_not_referenced_by_any_staff

  private

  def ensure_not_referenced_by_any_staff
    if staffs.empty?
      return true
    else
      errors.add(:base, 'Staffs present')
      return false
    end
  end
end
