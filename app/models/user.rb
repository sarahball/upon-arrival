class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:twitter]

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true

  def to_s
    name || username
  end

  def to_param
    username
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,32]

      user.username = auth.info.nickname
      user.name = auth.info.name
      user.description = auth.info.description
      user.location = auth.info.location
      user.website_url = auth.info.urls['Website']
      user.profile_image_url = auth.info.image
    end
  end
end
