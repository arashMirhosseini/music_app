class Track < ApplicationRecord

  TTYPE = %w(regular bonus)

  validates :album_id, :title, :ord, presence: true
  validates :type_track, inclusion: { in: TTYPE }

  belongs_to :album,
    class_name: :Album,
    foreign_key: :album_id,
    primary_key: :id,
    optional: true

  has_many :notes,
    class_name: :Note,
    foreign_key: :track_id,
    primary_key: :id

end
