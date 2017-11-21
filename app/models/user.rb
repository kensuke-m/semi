class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password

  def self.authenticate(name, password)
    if (Thread.current[:status] == 0 and admin?(name)) or
       (Thread.current[:status] == 1 and not student?(name)) or
       Thread.current[:status] >= 2
      user = find_by_name(name)
      if user
        # Local user
        if BCrypt::Password.new(user.password_digest) == password
          user
        end
      else
        # LDAP
        if staff?(name) or student?(name)
          ldap = Net::LDAP.new( host: 'auth1.kyoto-wu.ac.jp',
                                port: 389,
                                auth: { username: "uid=#{name},cn=users,dc=kyoto-wu,dc=ac,dc=jp",
                                        password: password,
                                        method: :simple } )
          if ldap.bind
            ldap.search( base: 'dc=kyoto-wu,dc=ac,dc=jp',
                         filter: Net::LDAP::Filter.eq("uid", name),
                         attributes: ["description"],
                         return_result: false ) do |entry|
              fullname = entry[:description][0]
            end
            User.new(name: name)
          end
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

  def self.grade(name)
    if self.student?(name)
      e = name[1].to_i
      y = Time.now.year % 10
      if e > y
        10 + y - e + 1
      else
        y - e + 1
      end
    else
      4
    end
  end
  
  def self.fullname
    Thread.current[:fullname]
  end
  
  def self.fullname=(fullname)
    Thread.current[:fullname] = fullname
  end
end