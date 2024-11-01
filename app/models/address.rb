class Address < ApplicationRecord
  validates :street, :city, :state, :zip, presence: true
  validates :zip, length: { is: 5 }

  def to_s
    %W[#{street} #{city} #{state} #{zip}].join(' ').downcase
  end

  def cache_key
    Digest::SHA256.hexdigest(to_s)
  end
end
