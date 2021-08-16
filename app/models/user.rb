class User < ApplicationRecord
    belongs_to :organization, optional: true
    # has_many :shifts, dependent: :delete_all, inverse_of: :user
    has_many :shifts, through: :organization

    has_secure_password
    validates_confirmation_of :password
    validates :name, :email, presence: true
    validates :email, :session_token, uniqueness: true
    validates :password, length: {minimum: 6}, :on => :create, allow_nil: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

    after_initialize :ensure_session_token

    def self.generate_session_token!
        SecureRandom.urlsafe_base64
    end

    def reset_session_token!
        self.update!(session_token: self.class.generate_session_token!)
        self.session_token
    end

    private
    def ensure_session_token
        self.session_token ||= User.generate_session_token!
    end

end
