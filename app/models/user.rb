class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless URI::MailTo::EMAIL_REGEXP.match?(value)
      record.errors.add attribute, (options[:message] || "is not an email")
    end
  end
end

class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.length >= 8
      record.errors.add attribute, (options[:message] || "must be at least 8 characters long")
    end
    if value.index(/[0-9]/).nil?
      record.errors.add attribute, (options[:message] || "must include at least one digit")
    end
    if value.index(/[a-z]/).nil?
      record.errors.add attribute, (options[:message] || "must include at least one lowercase latin letter")
    end
    if value.index(/[A-Z]/).nil?
      record.errors.add attribute, (options[:message] || "must include at least one uppercase latin letter")
    end
    if value.index(/[\-\+\*_]/).nil?
      record.errors.add attribute, (options[:message] || "must include at least one special character (-+*_)")
    end
  end
end

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :gamejams, inverse_of: "author", dependent: :destroy
  has_and_belongs_to_many :jam_commands
  has_many :joined_jams, through: :jam_commands
  has_many :jam_submissions, through: :jam_commands, inverse_of: "member"

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, email: true
  validates :nickname, presence: true, uniqueness: true, length: { in: 3..20 }
  validates :name, presence: true, length: { in: 1..20 }
  validates :password, password: true
end


