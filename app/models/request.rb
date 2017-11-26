class Request < ActiveRecord::Base
  validates :subject_id, uniqueness: { scope: :studentusername,
    message: "が1人の学生について重複しています" }
  validates :permission, numericality: { only_integer: true }

  belongs_to :subject
  belongs_to :staff

  def permission_values
    [
      [-1, "未定"],
      [0, "配属可（第1次）"],
      [1, "配属不可（第1次）"],
      [2, "配属可（第2次）"],
      [3, "配属不可（第2次）"]
    ]
  end

  def self.permission_values_for_selection
    if Thread.current[:status] == 4
      [
        ["未定", -1],
        ["配属可（第1次）", 0],
        ["配属不可（第1次）", 1],
      ]
    else
      [
        ["未定", -1],
        ["配属可（第1次）", 0],
        ["配属不可（第1次）", 1],
        ["配属可（第2次）", 2],
        ["配属不可（第2次）", 3]
      ]
    end
  end

  def permission_to_string
    p1 = permission_values[self.permission + 1][1]
    if not User.admin?(Thread.current[:user_name])
      if Thread.current[:status] == 4 and User.student?(Thread.current[:user_name])
        p1 = '未定'
      else
        if Thread.current[:status] == 6 and self.permission / 2 == 1 and User.student?(Thread.current[:user_name])
          p1 = '未定'
        end
      end
    end
    p1
  end
end
