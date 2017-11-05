class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password

  def self.authenticate(name, password)
    user = find_by_name(name)
    if user
      if BCrypt::Password.new(user.password_digest) == password
        user
      end
    else
      # LDAP
      if staff?(name) #or student?(name)
        ldap = Net::LDAP.new
        ldap.host = 'auth1.kyoto-wu.ac.jp'
        ldap.port = 389
        ldap.auth(username: "uid=#{name},cn=users,dc=kyoto-wu,dc=ac,dc=jp", password: password, method: :simple)
        if ldap.bind
          User.new(name: name)
        end
      end
    end
  end

  def self.admin?(name)
    name == "admin"
  end

  def self.staff?(name)
    Staff::find_by_username(name)
  end

  def self.student?(name)
    /^k[0-9]241/ =~ name
  end
end
