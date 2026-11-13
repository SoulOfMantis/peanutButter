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
  has_many :gamejam_participations, inverse_of: "participant",  dependent: :destroy
  has_many :joined_gamejams, through: :gamejams_participants
  has_many :jam_submissions, inverse_of: "author", dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, email: true
  validates :nickname, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, password: true
end


