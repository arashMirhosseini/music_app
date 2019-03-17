class User < ApplicationRecord

  attr_reader :password

  validates :email, presence: true, uniqueness: true
  validates :session_token, presence: true
  validates :password_digest, presence: { message: "Password can\'t be blank."}
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :notes,
    class_name: :Note,
    foreign_key: :user_id,
    primary_key: :id

  def self.find_by_credentials(email, password)
    user = find_by(email: email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
