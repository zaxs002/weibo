#encoding:utf-8
require 'digest/sha2'
class User < ActiveRecord::Base
  has_many :microposts,dependent: :destroy
  has_many :relationships,foreign_key: "follower_id",dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name: "Relationship",
           dependent: :destroy
  has_many :followers,through: :reverse_relationships,source: :follower

  validates :name,presence:true,length:{maximum:50}
  validates_uniqueness_of :name,:message => "该用户名已存在!"
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence:true,format:{with:VALID_EMAIL_REGEX,message:'不合法'},uniqueness:true

  before_save {self.email = email.downcase}
  before_create :create_remember_token
  #has_secure_password

  validates :password,length:{minimum:6},confirmation:true
  attr_accessor :password_confirmation
  attr_reader :password

  def self.search s
    if s
      find(:all,conditions: ['name LIKE ?',"%#{s}%"])
    else
      find(:all)
    end
  end

  def following? other_user
    relationships.find_by(followed_id: other_user.id)
  end

  def follow! other_user
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow! other_user
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def password=(p)
    @password = p
    if p.present?
      generate_salt
      self.password_digest = self.class.encrypt_password(p,salt)
    end
  end

  def User.authenticate(email,password)
    if user = find_by_email(email)
      if user.password_digest == encrypt_password(password,user.salt)
        user
      end
    end
  end

  def User.encrypt_password(password,salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  private
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end


end
