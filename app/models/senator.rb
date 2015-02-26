require_relative '../../db/config'


class Senator < ActiveRecord::Base
validates :bioguide_id, uniqueness: true ,presence: true
validates :votesmart_id, uniqueness: true, presence: true
validates :fec_id, uniqueness: true, presence: true
validates :govtrack_id, uniqueness: true, presence: true
validates :crp_id, uniqueness: true, presence: true

  def name
    name = "#{self[:firstname]} #{self[:middlename]} #{self[:lastname]} #{self[:namesuffix]}"
  end

end