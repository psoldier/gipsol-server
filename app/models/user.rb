class User
  include Mongoid::Document
  include Shield::Model
  include Mongoid::Timestamps
  include Mongoid::Pagination

  field :name,             type: String
  field :last_name,        type: String
  field :email,            type: String
  field :crypted_password, type: String
  field :suspended,        type: Boolean, default: false #Enable Solo visto por el Admin
  field :email_validated,  type: Boolean, default: false
  field :last_ip,          type: String
  field :login_count,      type: Integer, default: 0
  field :last_login_at,    type: DateTime
  field :key,              type: Hash,    default: {password_reset_token: 0, email_validate_token: 0}
  field :token,            type: String

  index({ email: 1 }, { unique: true })
  index({ token: 1 }, { unique: true })

  validates :email, uniqueness: true

  def self.[](id)
    self.find(id)
  end

  def self.fetch(email)
    where(email: email).first
  end

  before_create do |user|
    user.token = SecureRandom.hex(32)
  end
end