class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :full_name, :type => String
  field :bio, :type => String
  field :email, :type => String
  references_many :startups, :inverse_of=>:owner
  embeds_many :services
  references_many :jobs, :inverse_of=>:owner
  has_one :profile
  accepts_nested_attributes_for :profile
end
