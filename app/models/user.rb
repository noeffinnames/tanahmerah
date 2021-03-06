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

  def self.has_shareholding?(id)
    user = User.find_by_id(id)
    return false if user == nil 
    return true if user.has_shareholding?
    false
  end

  def self.get_shareholders
    User.where(shareholder: true)
  end

  def self.all_shareholder_ids
    User.where(shareholder: true).pluck(:id)
  end

  def self.all_shareholder_names_and_ids
    User.where(shareholder: true).order('users.name ASC').pluck(:name, :id)
  end

  def self.shareholding_percent_has_integrity
    User.sum(:shareholding_percent) == 100
  end



  def add_provider(auth)
    # Check if the provider already exists, so we don't add it twice
    unless identities.find_by_provider_and_uid(auth["provider"], auth["uid"])
      Identity.create :user => self, :provider => auth["provider"], :uid => auth["uid"]
    end
  end

end
