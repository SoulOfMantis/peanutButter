class JamSubmission < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :gamejam

  validates :name, presense: true 

end
