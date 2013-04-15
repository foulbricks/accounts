require 'bcrypt'
require 'digest/sha1'

class User < ActiveRecord::Base
  
  attr_accessor :passwd
  
  before_save :encrypt_password
  
  validates_confirmation_of :passwd
  validates_presence_of :first_name, :last_name, :email, :username, :passwd
  validates_uniqueness_of :username
  
  def self.authenticate(uname, pass)
    user = User.find_by_username(uname)
    if user && user.password == BCrypt::Engine.hash_secret(pass, user.salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if passwd.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(passwd, salt)
    end
  end
  
  def forgot_password!
    self.pwcode = make_token
    save(:validate => false)
    UserMailer.forgot_password(self).deliver
  end
  
  private  
    def secure_digest(*args)
      Digest::SHA1.hexdigest(args.flatten.join('--'))
    end

    def make_token
      secure_digest(Time.now, (1..10).map { rand.to_s })
    end
end
