class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :omniauthable, omniauth_providers: %i[twitter]

  has_one :user_football_team, dependent: :destroy
  has_one :football_team, through: :user_football_team, dependent: :destroy

  has_many :football_reviews, dependent: :destroy

  validates :uid, presence: true
  validates :provider, presence: true
  validates :username, presence: true
  validates :access_token, presence: true
  validates :access_secret, presence: true

  def encrypt_field(value)
    EncryptionService.encrypt(value)
  end

  private

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name
    user.username = auth.info.nickname
    user.location = auth.info.location
    user.access_token = auth.credentials.token
    user.access_secret = auth.credentials.secret
    user.access_token = user.encrypt_field(user.access_token)
    user.access_secret = user.encrypt_field(user.access_secret)
    user.save!
    return user
    #user.image = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails,
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end

  def email_required?
     false
  end



end
