class JobApplication
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description, :type=>String
  belongs_to :job
  belongs_to :user
  belongs_to :startup
  
  def before_create
    self.startup = self.job.startup
  end
end
