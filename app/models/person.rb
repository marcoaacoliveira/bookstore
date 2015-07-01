class Person < ActiveRecord::Base
	validates :name, presence: true, length: {maximum: 50}
	validates :email, allow_blank: true, allow_nil: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9_.-]+@([a-zA-Z0-9_-]+\.)+[a-zA-Z]{2,4}\z/}
	validates :born_at, presence: true
	validate :age_limit

	private
	def age_limit
		errors.add(:born_at, "tem que ser maior que 16 anos") if self.born_at.nil? || Date.today.year-self.born_at.year < 16
	end
end
