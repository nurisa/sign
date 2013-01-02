class User < ActiveRecord::Base
  # attr_accessible :title, :body
	attr_accessor :password
	EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i
	validates :name, :presence => true, :uniqueness => true, :length => {:in => 2..30}
	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	validates :password, :confirmation => true #password_confirmation attr
	validates_length_of :password, :in => 6..20, :on => :create

#salt = BCrypt::Engine.generate_salt
#encrypted_password = BCrypt::Engine.hash_secret(password, salt)
	before_save :encrypt_password
	after_save :clear_password

	attr_accessible :name, :email, :password, :password_confirmation

	def encrypt_password
	if password.present?
		self.salt = BCrypt::Engine.generate_salt
		self.encrypt_password = BCrypt::Engine.hash_secret(password, salt)
	end
	end
	def clear_password
	self.password = nil
	end
end
