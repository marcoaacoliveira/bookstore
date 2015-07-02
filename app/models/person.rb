require 'digest/sha1'
class Person < ActiveRecord::Base
	validates :name, presence: true, length: {maximum: 50}
	validates :email, allow_blank: true, allow_nil: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9_.-]+@([a-zA-Z0-9_-]+\.)+[a-zA-Z]{2,4}\z/}
	validates :born_at, presence: true
	validate :age_limit

	attr_accessor :plain_password
	before_save :encrypt_password
	scope :admins, -> { where(["admin=?", true]) }
	
	def self.encrypt_password(pwd)
		Digest::SHA1.hexdigest("123_#{pwd}_456")
	end

	def self.auth(email, password)
		where(["email=? and password=?"], email, encrypt_password(password)).first
	end
	private
	def age_limit
		errors.add(:born_at, "tem que ser maior que 16 anos") if self.born_at.nil? || Date.today.year-self.born_at.year < 16
	end

	def encrypt_password
		return if plain_password.to_s.strip.size < 1
		self.password = Person.encrypt_password(plain_password)
	end
end
