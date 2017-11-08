class Message < ApplicationRecord
  mount_uploader :image, ImagesUploader
  belongs_to :user
  belongs_to :group

  validates :body_or_image, presence: true

  private
    def body_or_image
      body.presence or image.presence
    end

end
