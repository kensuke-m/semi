class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password

  def self.authenticate(name, password)
    user = find_by_name(name)
    if user
      if BCrypt::Password.new(user.password_digest) == password
        user
      else
        false
      end
    else
      # LDAP
      false
    end
  end

  def self.admin?(name)
    name == "admin"
  end

  def self.staff?(name)
    Staff::find_by_username(name)
  end
end
