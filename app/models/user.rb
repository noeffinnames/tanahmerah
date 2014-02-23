class User < ActiveRecord::Base
  has_many :identities

  validates :name, :presence => true
  validates :shareholder, inclusion: [true, false]
  validates :shareholding_percent, :numericality => {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}

  def add_provider(auth)
    # Check if the provider already exists, so we don't add it twice
    unless identities.find_by_provider_and_uid(auth["provider"], auth["uid"])
      Identity.create :user => self, :provider => auth["provider"], :uid => auth["uid"]
    end
  end

end
