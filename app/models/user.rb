class User < ActiveRecord::Base
  has_many :identities

  validates :name, :presence => true
  validates :shareholder, inclusion: [true, false]
  validates :shareholding_percent, :numericality => {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  
  validate :shareholding_percent_valid, :on => :update # uses custom validator below
  
  def shareholding_percent_valid
    errors.add(:shareholding_percent, 'must be zero for non-shareholder') if ((!self.shareholder) and has_shareholding?)
    
    errors.add(:shareholding_percent, 'must be non zero for shareholder') if (self.shareholder and !has_shareholding?) 
  end

  def has_shareholding?
    return self.shareholding_percent > 0
  end


  def add_provider(auth)
    # Check if the provider already exists, so we don't add it twice
    unless identities.find_by_provider_and_uid(auth["provider"], auth["uid"])
      Identity.create :user => self, :provider => auth["provider"], :uid => auth["uid"]
    end
  end

end
