class Airport < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

  scope :alphabetical, -> { order(name: :asc) }
  scope :european, -> { where(region: 'EU') }

  def name_iata
    "#{name} (#{code})"
  end
end
