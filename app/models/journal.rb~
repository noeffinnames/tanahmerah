class Journal < ActiveRecord::Base

  monetize :amount_cents 

  validates :incurred_date, :presence => true
  validates :amount, :numericality => {greater_than_or_equal_to: 0.01}, :presence => true
  validates :owed_user_id, :presence => true
  validates :owing_user_id, :presence => true

  #TODO - add date validation - need Rails 4 version of https://github.com/adzap/validates_timeliness/


end
