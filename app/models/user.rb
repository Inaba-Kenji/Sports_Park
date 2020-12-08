class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]



  attachment :profile_image

  has_many :likes

  has_many :recruitments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  validates :name, :email, :postal_code, :address, :gender, :age, :favorites_sports, presence: :true


  #フォローしているかを確認
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  #フォローする
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  #フォローを外す
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          name: auth.info.name,
          email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { user: user ,sns: sns}
  end

   def self.with_sns_data(auth, snscredential)
      user = User.where(id: snscredential.user_id).first
      unless user.present?
        user = User.new(
          name: auth.info.name,
          email: auth.info.email,
        )
      end
      return {user: user}
   end

   def self.find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid: uid, provider: provider).first
      if snscredential.present?
        user = with_sns_data(auth, snscredential)[:user]
        sns = snscredential
      else
        user = without_sns_data(auth)[:user]
        sns = without_sns_data(auth)[:sns]
      end
      return { user: user ,sns: sns}
   end

end
