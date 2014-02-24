class Identity < ActiveRecord::Base
  belongs_to :user  

  #attr_protected :uid, :provider #TODO add strong parameters to controller

  validates :uid, :presence => true
  validates :provider_name, :presence => true

  def self.find_or_create(auth)
    debugger
    unless identity = find_by_provider_name_and_uid(auth["provider"], auth["uid"])
      user = User.create :name => auth["user_info"]["name"], :shareholder => false, :shareholding_percent => 0 ##:name => auth["info"]["name"]
      #TODO consider treatment of shareholder attributes
      identity = create :user => user, :provider_name => auth["provider"], :uid => auth["uid"]
    end

    identity
  end


end
