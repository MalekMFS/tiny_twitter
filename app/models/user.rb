class User < ActiveRecord::Base
	before_save {email.downcase!}

	validates :name, presence: {message: "نام نمی تواند خالی باشد."}, length: { maximum: 50, message:"نام می تواند حداکثر ۵۰ نویسه باشدs" }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i                                                     #Also includes Uniqueness: true
	validates :email, presence: {message: "پست الکترونیک نمی تواند خالی باشد."},
										length: { maximum: 255, message: "پست الکترونیک می تواند حداکثر ۲۵۵ نویسه باشد." },
										 format: {with: VALID_EMAIL_REGEX, message: "پست الکترونیک نامعتبر است."},
										 uniqueness: {case_sensitive: false, message: "پست الکترونیک قبلاْ استفاده شده است."}
	has_secure_password validation: false
	validates :password, length: { minimum: 6, message: "رمز عبور باید حداقل ۶ نویسه باشد." }

end
