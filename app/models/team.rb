class Team
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :startup
  has_and_belongs_to_many :users
end
