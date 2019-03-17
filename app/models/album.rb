class Album < ApplicationRecord
  KIND = %w(studio live)

  validates :title, :year, :band_id, presence: true
  validates :kind, inclusion: { in: KIND }

  belongs_to :band,
    class_name: :Band,
    foreign_key: :band_id,
    primary_key: :id,
    optional: true

  has_many :tracks,
    class_name: :Track,
    foreign_key: :album_id,
    primary_key: :id,
    dependent: :destroy

end
