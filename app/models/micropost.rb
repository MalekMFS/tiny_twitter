class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: {message: "نویسنده مشخص نیست!"}
  validates :content, presence: {message: "پیام نمی تواند خالی باشد."},
                      length: {maximum: 140, message: "پیام می تواند حداکثر ۱۴۰ نویسه باشد!"}
  validate :picture_size




  private
  #validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors_add(:picture, "عکس باید کمتر از ۵ مگابایت باشد")
    end
  end
end
