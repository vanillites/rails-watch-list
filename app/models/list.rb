class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks

  validates :name, presence: true, uniqueness: true
  validates :photo_url, presence: true
end
