class Order < ActiveRecord::Base
  #Status
  enum status: [:requested, :waiting, :analysing, :paid,
                :availabe, :dispute, :returned, :canceled,
                :debited, :temporary_retention]

  #Associations
  belongs_to :ad
  belongs_to :buyer, :class_name => "Member"

end
