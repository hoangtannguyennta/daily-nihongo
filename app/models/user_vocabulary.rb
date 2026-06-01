class UserVocabulary < ApplicationRecord
  belongs_to :user
  belongs_to :vocabulary

  enum :status, {
    not_learned: 0,
    not_remembered: 1,
    remembered: 2
  }

end
