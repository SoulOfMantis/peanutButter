class Gamejam < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :jam_submissions
  def public?
    status != "Private"
  end
  def was_started?
    status == "Ongoing" or status == "Finished"
  end
  def private?
    status == "Private"
  end
  def accessible?
    return true if public?
    if !Current.nil? & !Current.session.nil? 
      return Current.session.user == author
    end
    false
  end
end
