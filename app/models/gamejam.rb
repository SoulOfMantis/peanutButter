class Gamejam < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :jam_submissions
  
#  validates :name, :theme, :status, presense: true 

  def published?
    status != "Draft"
  end

  def was_started?
    status == "Ongoing" or status == "Finished"
  end

  def draft?
    status == "Draft"
  end

  def accessible?
    published? or authored_by_current_user?
  end

  def authored_by? (user)
    user == author
  end

  def authored_by_current_user?
    !Current.nil? and !Current.session.nil? and (authored_by? Current.session.user)
  end

end
