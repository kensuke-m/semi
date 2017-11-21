class Request < ActiveRecord::Base
  validates :subject_id, uniqueness: { scope: :studentusername,
    message: "が1人の学生について重複しています" }
  validates :permission, numericality: { only_integer: true }

  belongs_to :subject
  belongs_to :staff

  def self.permission_to_string(permission)
    if permission < 0
    '未定'
    else
      p1 = permission % 2 ? '配属可' : '配属不可'
      p1 + "（第#{permission / 2 + 1}次）"
    end
  end
end
