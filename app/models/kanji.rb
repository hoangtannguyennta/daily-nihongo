class Kanji < ApplicationRecord
  validates :character, presence: true, uniqueness: true
  validates :meaning, presence: true
end
