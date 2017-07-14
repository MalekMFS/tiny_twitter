class User < ActiveRecord::Base
	attr_accessor :remember_token, :activation_token, :reset_token
	before_save :downcase_email
	before_create :create_activation_digest

	validates :name, presence: {message: "نام نمی تواند خالی باشد."}, length: { maximum: 50, message:"نام می تواند حداکثر ۵۰ نویسه باشدs" }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i                                                     #Also includes Uniqueness: true
	validates :email, presence: {message: "پست الکترونیک نمی تواند خالی باشد."},
										length: { maximum: 255, message: "پست الکترونیک می تواند حداکثر ۲۵۵ نویسه باشد." },
										 format: {with: VALID_EMAIL_REGEX, message: "پست الکترونیک نامعتبر است."},
										 uniqueness: {case_sensitive: false, message: "پست الکترونیک قبلاْ استفاده شده است."}
	has_secure_password validation: false
	validates :password, length: { minimum: 6,
																 message: "رمز عبور باید حداقل ۶ نویسه باشد." }, allow_blank: true

	#equal to User.new_token #User.digest(string)  and self.new_token #self.digest(string)
	class << self
		#Returns the hash digest of the given string.
		#need for testing
		def digest(string)
			#https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																										BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)
		end

		#Returns a random token.
		def new_token
			SecureRandom.urlsafe_base64
		end
	end
	#use like @current_user.remember
	def remember
		#remember_token is virtual attribute
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	#Forgets a user
	def forget
		update_attribute(:remember_digest, nil)
	end

	#Returns true if  the given token matches the digest
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil? #Prevents error (bug fix)
		BCrypt::Password.new(digest).is_password?(token)
	end

	#Activates an account.
	def activate
		update_columns(activated_at: Time.zone.now, activated: true)
	end
	def send_activation_email
    UserMailer.account_activation(self).deliver_now
	end

	#Sets the password reset attributes
	def create_reset_digest
		self.reset_token = User.new_token
		update_columns(reset_digest:  User.digest(reset_token),
		 							 reset_sent_at: Time.zone.now)
	end
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

private
	#Converts email to all lower-case
	def downcase_email
		email.downcase!
	end
	#Creates and assigns the activation token and digest
	def create_activation_digest
		self.activation_token  = User.new_token
		self.activation_digest = User.digest(activation_token)
	end
end
