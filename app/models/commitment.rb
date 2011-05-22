class Commitment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description, :type=>String
  belongs_to :request
  belongs_to :user
  belongs_to :startup
  
  def before_create
    self.startup = self.request.startup
  end
end
